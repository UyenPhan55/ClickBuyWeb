package dao;

import java.sql.*;
import java.util.*;
import model.LichSuHoatDong;

public class LichSuHoatDongDAO {
    public boolean insertLog(int idNguoiDung, String hanhDong, String bangTacDong, int idDoiTuong, String diaChiIp) throws SQLException {
        String sql = "INSERT INTO lich_su_hoat_dong(id_nguoi_dung, hanh_dong, bang_tac_dong, id_doi_tuong, dia_chi_ip) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            ps.setString(2, hanhDong);
            ps.setString(3, bangTacDong);
            ps.setInt(4, idDoiTuong);
            ps.setString(5, diaChiIp);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean insertLog(Connection conn, int idNguoiDung, String hanhDong, String bangTacDong, int idDoiTuong, String diaChiIp) throws SQLException {
        String sql = "INSERT INTO lich_su_hoat_dong(id_nguoi_dung, hanh_dong, bang_tac_dong, id_doi_tuong, dia_chi_ip) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            ps.setString(2, hanhDong);
            ps.setString(3, bangTacDong);
            ps.setInt(4, idDoiTuong);
            ps.setString(5, diaChiIp);
            return ps.executeUpdate() > 0;
        }
    }

    public List<LichSuHoatDong> getAllLogs() throws SQLException {
        String sql = "SELECT l.*, n.ten_day_du, n.email FROM lich_su_hoat_dong l JOIN nguoi_dung n ON l.id_nguoi_dung = n.id_nguoi_dung ORDER BY l.thoi_gian DESC";
        List<LichSuHoatDong> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<LichSuHoatDong> getLogsByUser(int idNguoiDung) throws SQLException {
        String sql = "SELECT l.*, n.ten_day_du, n.email FROM lich_su_hoat_dong l JOIN nguoi_dung n ON l.id_nguoi_dung = n.id_nguoi_dung WHERE l.id_nguoi_dung = ? ORDER BY l.thoi_gian DESC";
        List<LichSuHoatDong> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    private LichSuHoatDong map(ResultSet rs) throws SQLException {
        LichSuHoatDong log = new LichSuHoatDong();
        log.setIdLog(rs.getInt("id_log"));
        log.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
        log.setHanhDong(rs.getString("hanh_dong"));
        log.setBangTacDong(rs.getString("bang_tac_dong"));
        log.setIdDoiTuong(rs.getInt("id_doi_tuong"));
        log.setThoiGian(rs.getTimestamp("thoi_gian"));
        log.setDiaChiIp(rs.getString("dia_chi_ip"));
        try { log.setTenNguoiDung(rs.getString("ten_day_du")); } catch (SQLException ignored) {}
        try { log.setEmail(rs.getString("email")); } catch (SQLException ignored) {}
        return log;
    }
}
