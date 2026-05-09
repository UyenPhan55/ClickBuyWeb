package dao;

import model.SanPham;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SanPhamDAO {
    
    // 1. Lấy tất cả sản phẩm
    public List<SanPham> getAllSanPham() {
        List<SanPham> list = new ArrayList<>();
        String query = "SELECT * FROM SanPham";
        try (Connection conn = DBConnection.getConnection(); // Dùng static đúng ý bạn nhé
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new SanPham(
                    rs.getInt("id"),
                    rs.getString("tenSanPham"),
                    rs.getString("hangSanXuat"),
                    rs.getString("moTa"),
                    rs.getString("anhDaiDien"),
                    rs.getBoolean("trangThai"),
                    rs.getDate("ngayTao")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Lấy 1 sản phẩm theo ID
    public SanPham getSanPhamById(int id) {
        String query = "SELECT * FROM SanPham WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new SanPham(
                        rs.getInt("id"), rs.getString("tenSanPham"),
                        rs.getString("hangSanXuat"), rs.getString("moTa"),
                        rs.getString("anhDaiDien"), rs.getBoolean("trangThai"), rs.getDate("ngayTao")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}