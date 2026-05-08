package dao;

import java.sql.*;
import java.util.*;
import model.KhieuNai;

public class KhieuNaiDAO {
    public boolean insertKhieuNai(int idNguoiDung, int idDonHang, String noiDung, int yeuCauTraHang) throws SQLException {
        if (!isOrderBelongsToUser(idNguoiDung, idDonHang)) throw new SQLException("Bạn chỉ được khiếu nại đơn hàng của mình");
        String sql = "INSERT INTO khieu_nai(id_don_hang, noi_dung, yeu_cau_tra_hang) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idDonHang);
            ps.setString(2, noiDung);
            ps.setInt(3, yeuCauTraHang);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean phanHoiKhieuNai(int idKhieuNai, String phanHoi, String trangThai) throws SQLException {
        String sql = "UPDATE khieu_nai SET phan_hoi = ?, trang_thai = ? WHERE id_khieu_nai = ?";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                int idNguoiDung = getOwnerByComplaint(conn, idKhieuNai);
                ps.setString(1, phanHoi);
                ps.setString(2, trangThai);
                ps.setInt(3, idKhieuNai);
                int rows = ps.executeUpdate();
                new ThongBaoDAO().insertThongBao(conn, idNguoiDung, "Phản hồi khiếu nại", "Khiếu nại #" + idKhieuNai + " đã được phản hồi.", "HE_THONG");
                conn.commit();
                return rows > 0;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally { conn.setAutoCommit(true); }
        }
    }

    public boolean updateTrangThai(int idKhieuNai, String trangThai) throws SQLException {
        String sql = "UPDATE khieu_nai SET trang_thai = ? WHERE id_khieu_nai = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trangThai);
            ps.setInt(2, idKhieuNai);
            return ps.executeUpdate() > 0;
        }
    }

    public List<KhieuNai> getAllKhieuNai() throws SQLException {
        String sql = baseSql() + " ORDER BY kn.ngay_gui DESC";
        List<KhieuNai> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<KhieuNai> getKhieuNaiByUser(int idNguoiDung) throws SQLException {
        String sql = baseSql() + " WHERE dh.id_nguoi_dung = ? ORDER BY kn.ngay_gui DESC";
        List<KhieuNai> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(map(rs)); }
        }
        return list;
    }

    private boolean isOrderBelongsToUser(int idNguoiDung, int idDonHang) throws SQLException {
        String sql = "SELECT 1 FROM don_hang WHERE id_don_hang = ? AND id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idDonHang);
            ps.setInt(2, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        }
    }

    private int getOwnerByComplaint(Connection conn, int idKhieuNai) throws SQLException {
        String sql = "SELECT dh.id_nguoi_dung FROM khieu_nai kn JOIN don_hang dh ON kn.id_don_hang = dh.id_don_hang WHERE kn.id_khieu_nai = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idKhieuNai);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("id_nguoi_dung");
            }
        }
        throw new SQLException("Không tìm thấy khiếu nại");
    }

    private String baseSql() {
        return "SELECT kn.*, dh.id_nguoi_dung, nd.ten_day_du, nd.email " +
               "FROM khieu_nai kn JOIN don_hang dh ON kn.id_don_hang = dh.id_don_hang " +
               "JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung";
    }

    private KhieuNai map(ResultSet rs) throws SQLException {
        KhieuNai kn = new KhieuNai();
        kn.setIdKhieuNai(rs.getInt("id_khieu_nai"));
        kn.setIdDonHang(rs.getInt("id_don_hang"));
        kn.setNoiDung(rs.getString("noi_dung"));
        kn.setPhanHoi(rs.getString("phan_hoi"));
        kn.setTrangThai(rs.getString("trang_thai"));
        kn.setNgayGui(rs.getTimestamp("ngay_gui"));
        kn.setYeuCauTraHang(rs.getInt("yeu_cau_tra_hang"));
        kn.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
        kn.setTenNguoiDung(rs.getString("ten_day_du"));
        kn.setEmail(rs.getString("email"));
        return kn;
    }
}
