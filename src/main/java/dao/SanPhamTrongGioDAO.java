package dao;

import java.sql.*;
import java.util.*;
import model.SanPhamTrongGio;

public class SanPhamTrongGioDAO {
    private final GioHangDAO gioHangDAO = new GioHangDAO();

    public List<SanPhamTrongGio> getItemsByUserId(int idNguoiDung) throws SQLException {
        String sql = "SELECT ct.*, sp.ten_san_pham, sp.url_anh, bt.ten_bien_the, bt.gia_bien_the, bt.so_luong_ton " +
                     "FROM gio_hang gh " +
                     "JOIN san_pham_trong_gio ct ON gh.id_gio_hang = ct.id_gio_hang " +
                     "JOIN bien_the_san_pham bt ON ct.id_bien_the = bt.id_bien_the " +
                     "JOIN san_pham sp ON bt.id_san_pham = sp.id_san_pham " +
                     "WHERE gh.id_nguoi_dung = ? ORDER BY ct.id_bien_the DESC";
        List<SanPhamTrongGio> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public boolean addItem(int idNguoiDung, int idBienThe, int soLuong) throws SQLException {
        if (soLuong <= 0) throw new SQLException("Số lượng phải lớn hơn 0");
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int idGioHang = gioHangDAO.getOrCreateCartId(conn, idNguoiDung);
                int tonKho = getStockForUpdate(conn, idBienThe);
                int soLuongHienTai = getCurrentQuantity(conn, idGioHang, idBienThe);
                if (soLuongHienTai + soLuong > tonKho) {
                    throw new SQLException("Số lượng trong giỏ vượt quá tồn kho");
                }

                String sql = "INSERT INTO san_pham_trong_gio(id_gio_hang, id_bien_the, so_luong) VALUES (?, ?, ?) " +
                             "ON DUPLICATE KEY UPDATE so_luong = so_luong + VALUES(so_luong)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, idGioHang);
                    ps.setInt(2, idBienThe);
                    ps.setInt(3, soLuong);
                    ps.executeUpdate();
                }
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public boolean updateQuantity(int idNguoiDung, int idBienThe, int soLuong) throws SQLException {
        if (soLuong <= 0) return removeItem(idNguoiDung, idBienThe);
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int idGioHang = gioHangDAO.getOrCreateCartId(conn, idNguoiDung);
                int tonKho = getStockForUpdate(conn, idBienThe);
                if (soLuong > tonKho) throw new SQLException("Số lượng vượt quá tồn kho");

                String sql = "UPDATE san_pham_trong_gio SET so_luong = ? WHERE id_gio_hang = ? AND id_bien_the = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, soLuong);
                    ps.setInt(2, idGioHang);
                    ps.setInt(3, idBienThe);
                    int rows = ps.executeUpdate();
                    conn.commit();
                    return rows > 0;
                }
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public boolean removeItem(int idNguoiDung, int idBienThe) throws SQLException {
        String sql = "DELETE ct FROM san_pham_trong_gio ct JOIN gio_hang gh ON ct.id_gio_hang = gh.id_gio_hang " +
                     "WHERE gh.id_nguoi_dung = ? AND ct.id_bien_the = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            ps.setInt(2, idBienThe);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean clearCart(int idNguoiDung) throws SQLException {
        String sql = "DELETE ct FROM san_pham_trong_gio ct JOIN gio_hang gh ON ct.id_gio_hang = gh.id_gio_hang WHERE gh.id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            return ps.executeUpdate() >= 0;
        }
    }

    public int countItems(int idNguoiDung) throws SQLException {
        String sql = "SELECT COALESCE(SUM(ct.so_luong), 0) FROM gio_hang gh JOIN san_pham_trong_gio ct ON gh.id_gio_hang = ct.id_gio_hang WHERE gh.id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    private int getStockForUpdate(Connection conn, int idBienThe) throws SQLException {
        String sql = "SELECT so_luong_ton FROM bien_the_san_pham WHERE id_bien_the = ? FOR UPDATE";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idBienThe);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("so_luong_ton");
            }
        }
        throw new SQLException("Không tìm thấy biến thể sản phẩm");
    }

    private int getCurrentQuantity(Connection conn, int idGioHang, int idBienThe) throws SQLException {
        String sql = "SELECT so_luong FROM san_pham_trong_gio WHERE id_gio_hang = ? AND id_bien_the = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idGioHang);
            ps.setInt(2, idBienThe);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("so_luong") : 0;
            }
        }
    }

    private SanPhamTrongGio map(ResultSet rs) throws SQLException {
        SanPhamTrongGio item = new SanPhamTrongGio();
        item.setIdGioHang(rs.getInt("id_gio_hang"));
        item.setIdBienThe(rs.getInt("id_bien_the"));
        item.setSoLuong(rs.getInt("so_luong"));
        item.setTenSanPham(rs.getString("ten_san_pham"));
        item.setUrlAnh(rs.getString("url_anh"));
        item.setTenBienThe(rs.getString("ten_bien_the"));
        item.setGiaBienThe(rs.getBigDecimal("gia_bien_the"));
        item.setSoLuongTon(rs.getInt("so_luong_ton"));
        return item;
    }
}
