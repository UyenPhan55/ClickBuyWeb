package dao;

import java.sql.*;
import model.GioHang;

public class GioHangDAO {
    public int getOrCreateCartId(int idNguoiDung) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            return getOrCreateCartId(conn, idNguoiDung);
        }
    }

    public int getOrCreateCartId(Connection conn, int idNguoiDung) throws SQLException {
        String selectSql = "SELECT id_gio_hang FROM gio_hang WHERE id_nguoi_dung = ?";
        try (PreparedStatement ps = conn.prepareStatement(selectSql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("id_gio_hang");
            }
        }

        String insertSql = "INSERT INTO gio_hang(id_nguoi_dung) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, idNguoiDung);
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        throw new SQLException("Không tạo được giỏ hàng");
    }

    public GioHang getCartByUserId(int idNguoiDung) throws SQLException {
        String sql = "SELECT * FROM gio_hang WHERE id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new GioHang(rs.getInt("id_gio_hang"), rs.getInt("id_nguoi_dung"), rs.getTimestamp("ngay_tao"));
                }
            }
        }
        return null;
    }
}
