package dao;

import java.sql.*;
import java.util.*;
import model.BaoHanh;

public class BaoHanhDAO {
    public boolean insertBaoHanh(BaoHanh bh) throws SQLException {
        String sql = "INSERT INTO bao_hanh(id_don_hang, id_bien_the, id_nhan_vien, ma_bao_hanh_code, ngay_bat_dau, ngay_ket_thuc, trang_thai, ghi_chu) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bh.getIdDonHang());
            ps.setInt(2, bh.getIdBienThe());
            if (bh.getIdNhanVien() == null) ps.setNull(3, Types.INTEGER); else ps.setInt(3, bh.getIdNhanVien());
            ps.setString(4, bh.getMaBaoHanhCode());
            ps.setDate(5, bh.getNgayBatDau());
            ps.setDate(6, bh.getNgayKetThuc());
            ps.setString(7, bh.getTrangThai() == null ? "CON_HAN" : bh.getTrangThai());
            ps.setString(8, bh.getGhiChu());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateBaoHanh(BaoHanh bh) throws SQLException {
        String sql = "UPDATE bao_hanh SET id_nhan_vien = ?, ngay_bat_dau = ?, ngay_ket_thuc = ?, trang_thai = ?, ghi_chu = ? WHERE id_bao_hanh = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            if (bh.getIdNhanVien() == null) ps.setNull(1, Types.INTEGER); else ps.setInt(1, bh.getIdNhanVien());
            ps.setDate(2, bh.getNgayBatDau());
            ps.setDate(3, bh.getNgayKetThuc());
            ps.setString(4, bh.getTrangThai());
            ps.setString(5, bh.getGhiChu());
            ps.setInt(6, bh.getIdBaoHanh());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateTrangThai(int idBaoHanh, String trangThai, Integer idNhanVien, String ghiChu) throws SQLException {
        String sql = "UPDATE bao_hanh SET trang_thai = ?, id_nhan_vien = ?, ghi_chu = ? WHERE id_bao_hanh = ?";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                BaoHanh old = getById(conn, idBaoHanh);
                ps.setString(1, trangThai);
                if (idNhanVien == null) ps.setNull(2, Types.INTEGER); else ps.setInt(2, idNhanVien);
                ps.setString(3, ghiChu);
                ps.setInt(4, idBaoHanh);
                int rows = ps.executeUpdate();
                if (old != null) {
                    new ThongBaoDAO().insertThongBao(conn, old.getIdNguoiDung(), "Cập nhật bảo hành", "Bảo hành " + old.getMaBaoHanhCode() + " đã chuyển sang trạng thái " + trangThai + ".", "HE_THONG");
                }
                conn.commit();
                return rows > 0;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally { conn.setAutoCommit(true); }
        }
    }

    public BaoHanh getByCode(String maBaoHanhCode) throws SQLException {
        String sql = baseSql() + " WHERE bh.ma_bao_hanh_code = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maBaoHanhCode);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return map(rs); }
        }
        return null;
    }

    public List<BaoHanh> getAllBaoHanh() throws SQLException {
        String sql = baseSql() + " ORDER BY bh.id_bao_hanh DESC";
        List<BaoHanh> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<BaoHanh> getBaoHanhByUser(int idNguoiDung) throws SQLException {
        String sql = baseSql() + " WHERE dh.id_nguoi_dung = ? ORDER BY bh.id_bao_hanh DESC";
        List<BaoHanh> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(map(rs)); }
        }
        return list;
    }

    private BaoHanh getById(Connection conn, int idBaoHanh) throws SQLException {
        String sql = baseSql() + " WHERE bh.id_bao_hanh = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idBaoHanh);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return map(rs); }
        }
        return null;
    }

    private String baseSql() {
        return "SELECT bh.*, sp.ten_san_pham, bt.ten_bien_the, dh.id_nguoi_dung, nd.ten_day_du AS ten_nguoi_dung, nv.ten_day_du AS ten_nhan_vien " +
               "FROM bao_hanh bh " +
               "JOIN don_hang dh ON bh.id_don_hang = dh.id_don_hang " +
               "JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung " +
               "JOIN bien_the_san_pham bt ON bh.id_bien_the = bt.id_bien_the " +
               "JOIN san_pham sp ON bt.id_san_pham = sp.id_san_pham " +
               "LEFT JOIN nguoi_dung nv ON bh.id_nhan_vien = nv.id_nguoi_dung";
    }

    private BaoHanh map(ResultSet rs) throws SQLException {
        BaoHanh bh = new BaoHanh();
        bh.setIdBaoHanh(rs.getInt("id_bao_hanh"));
        bh.setIdDonHang(rs.getInt("id_don_hang"));
        bh.setIdBienThe(rs.getInt("id_bien_the"));
        int idNV = rs.getInt("id_nhan_vien");
        bh.setIdNhanVien(rs.wasNull() ? null : idNV);
        bh.setMaBaoHanhCode(rs.getString("ma_bao_hanh_code"));
        bh.setNgayBatDau(rs.getDate("ngay_bat_dau"));
        bh.setNgayKetThuc(rs.getDate("ngay_ket_thuc"));
        bh.setTrangThai(rs.getString("trang_thai"));
        bh.setGhiChu(rs.getString("ghi_chu"));
        bh.setTenSanPham(rs.getString("ten_san_pham"));
        bh.setTenBienThe(rs.getString("ten_bien_the"));
        bh.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
        bh.setTenNguoiDung(rs.getString("ten_nguoi_dung"));
        bh.setTenNhanVien(rs.getString("ten_nhan_vien"));
        return bh;
    }
}
