<<<<<<< HEAD
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
=======
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.SanPham;

public class SanPhamDAO {
    public List<SanPham> getAllSanPham() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM san_pham";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(new SanPham(
                    rs.getInt("id_san_pham"),
                    rs.getString("ten_san_pham"),
                    rs.getDouble("gia_goc"),
                    rs.getString("hinh_anh"),
                    rs.getString("mo_ta"),
                    rs.getInt("id_danh_muc")
                ));
            }
        } catch (Exception e) {
            System.out.println("Lỗi lấy danh sách SP: " + e.getMessage());
        }
        return list;
    }
    
    // Test nhanh xem DB có chạy không (Chạy bằng Shift + F6)
    public static void main(String[] args) {
        SanPhamDAO dao = new SanPhamDAO();
        List<SanPham> list = dao.getAllSanPham();
        for (SanPham sp : list) {
            System.out.println(sp.getTenSanPham() + " - " + sp.getGiaGoc());
        }
    }
>>>>>>> 66e75cedbca2796cc48db838e4062f55d94b85ec
}