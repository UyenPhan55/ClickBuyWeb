package dao;

import java.sql.*;
import java.util.*;
import model.ThongBao;

public class ThongBaoDAO {
    public boolean insertThongBao(int idNguoiDung, String tieuDe, String noiDung, String loaiThongBao) throws SQLException {
        String sql = "INSERT INTO thong_bao(id_nguoi_dung, tieu_de, noi_dung, loai_thong_bao) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            ps.setString(2, tieuDe);
            ps.setString(3, noiDung);
            ps.setString(4, loaiThongBao);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean insertThongBao(Connection conn, int idNguoiDung, String tieuDe, String noiDung, String loaiThongBao) throws SQLException {
        String sql = "INSERT INTO thong_bao(id_nguoi_dung, tieu_de, noi_dung, loai_thong_bao) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            ps.setString(2, tieuDe);
            ps.setString(3, noiDung);
            ps.setString(4, loaiThongBao);
            return ps.executeUpdate() > 0;
        }
    }

    public List<ThongBao> getThongBaoByUser(int idNguoiDung) throws SQLException {
        String sql = "SELECT * FROM thong_bao WHERE id_nguoi_dung = ? ORDER BY ngay_tao DESC";
        List<ThongBao> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public int countUnread(int idNguoiDung) throws SQLException {
        String sql = "SELECT COUNT(*) FROM thong_bao WHERE id_nguoi_dung = ? AND da_doc = 0";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public boolean markAsRead(int idThongBao, int idNguoiDung) throws SQLException {
        String sql = "UPDATE thong_bao SET da_doc = 1 WHERE id_thong_bao = ? AND id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idThongBao);
            ps.setInt(2, idNguoiDung);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean markAllAsRead(int idNguoiDung) throws SQLException {
        String sql = "UPDATE thong_bao SET da_doc = 1 WHERE id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            return ps.executeUpdate() >= 0;
        }
    }

    private ThongBao map(ResultSet rs) throws SQLException {
        ThongBao tb = new ThongBao();
        tb.setIdThongBao(rs.getInt("id_thong_bao"));
        tb.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
        tb.setTieuDe(rs.getString("tieu_de"));
        tb.setNoiDung(rs.getString("noi_dung"));
        tb.setLoaiThongBao(rs.getString("loai_thong_bao"));
        tb.setDaDoc(rs.getInt("da_doc"));
        tb.setNgayTao(rs.getTimestamp("ngay_tao"));
        return tb;
    }
}
