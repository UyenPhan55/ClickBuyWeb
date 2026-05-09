package dao;

import java.sql.*;
import java.util.*;
import model.DanhGia;

public class DanhGiaDAO {
    public boolean insertDanhGia(int idNguoiDung, int idDonHang, int idBienThe, int soSao, String noiDung) throws SQLException {
        if (soSao < 1 || soSao > 5) throw new SQLException("Số sao phải từ 1 đến 5");
        if (!isOrderItemBelongsToUser(idNguoiDung, idDonHang, idBienThe)) throw new SQLException("Bạn chỉ được đánh giá sản phẩm đã mua");
        String sql = "INSERT INTO danh_gia(id_don_hang, id_bien_the, so_sao, noi_dung) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idDonHang);
            ps.setInt(2, idBienThe);
            ps.setInt(3, soSao);
            ps.setString(4, noiDung);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateTraLoi(int idDanhGia, String traLoi) throws SQLException {
        String sql = "UPDATE danh_gia SET tra_loi = ? WHERE id_danh_gia = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, traLoi);
            ps.setInt(2, idDanhGia);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateTrangThai(int idDanhGia, int trangThai) throws SQLException {
        String sql = "UPDATE danh_gia SET trang_thai = ? WHERE id_danh_gia = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, trangThai);
            ps.setInt(2, idDanhGia);
            return ps.executeUpdate() > 0;
        }
    }

    public List<DanhGia> getAllDanhGia() throws SQLException {
        String sql = baseSql() + " ORDER BY dg.ngay_danh_gia DESC";
        List<DanhGia> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<DanhGia> getDanhGiaByBienThe(int idBienThe) throws SQLException {
        String sql = baseSql() + " WHERE dg.id_bien_the = ? AND dg.trang_thai = 1 ORDER BY dg.ngay_danh_gia DESC";
        List<DanhGia> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idBienThe);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public boolean hasReviewed(int idDonHang, int idBienThe) throws SQLException {
        String sql = "SELECT 1 FROM danh_gia WHERE id_don_hang = ? AND id_bien_the = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idDonHang);
            ps.setInt(2, idBienThe);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        }
    }

    private boolean isOrderItemBelongsToUser(int idNguoiDung, int idDonHang, int idBienThe) throws SQLException {
        String sql = "SELECT 1 FROM don_hang dh JOIN san_pham_trong_don ct ON dh.id_don_hang = ct.id_don_hang " +
                     "WHERE dh.id_nguoi_dung = ? AND dh.id_don_hang = ? AND ct.id_bien_the = ? AND dh.trang_thai IN ('DA_GIAO','HOAN_THANH')";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            ps.setInt(2, idDonHang);
            ps.setInt(3, idBienThe);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        }
    }

    private String baseSql() {
        return "SELECT dg.*, nd.ten_day_du, sp.ten_san_pham, bt.ten_bien_the " +
               "FROM danh_gia dg " +
               "JOIN don_hang dh ON dg.id_don_hang = dh.id_don_hang " +
               "JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung " +
               "JOIN bien_the_san_pham bt ON dg.id_bien_the = bt.id_bien_the " +
               "JOIN san_pham sp ON bt.id_san_pham = sp.id_san_pham";
    }

    private DanhGia map(ResultSet rs) throws SQLException {
        DanhGia dg = new DanhGia();
        dg.setIdDanhGia(rs.getInt("id_danh_gia"));
        dg.setIdDonHang(rs.getInt("id_don_hang"));
        dg.setIdBienThe(rs.getInt("id_bien_the"));
        dg.setSoSao(rs.getInt("so_sao"));
        dg.setNoiDung(rs.getString("noi_dung"));
        dg.setTraLoi(rs.getString("tra_loi"));
        dg.setNgayDanhGia(rs.getTimestamp("ngay_danh_gia"));
        dg.setTrangThai(rs.getInt("trang_thai"));
        dg.setTenNguoiDung(rs.getString("ten_day_du"));
        dg.setTenSanPham(rs.getString("ten_san_pham"));
        dg.setTenBienThe(rs.getString("ten_bien_the"));
        return dg;
    }
}
