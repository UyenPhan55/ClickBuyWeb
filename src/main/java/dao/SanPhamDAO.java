package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.SanPham;

public class SanPhamDAO {

    // 1. LẤY DANH SÁCH SẢN PHẨM (Thêm rs.getInt("so_luong_ton"))
    public List<SanPham> getAllSanPham() {
        List<SanPham> list = new ArrayList<>();
        String sql =
            "SELECT sp.*, " +
            "MIN(bt.id_bien_the) AS id_bien_the " +
            "FROM san_pham sp " +
            "LEFT JOIN bien_the_san_pham bt " +
            "ON sp.id_san_pham = bt.id_san_pham " +
            "GROUP BY sp.id_san_pham " +
            "ORDER BY sp.id_san_pham DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {

        // Tạo tên biến là "sp"; new SanPham (...) là tạo object mới trong bộ nhớ
        // => Tạo object sản phẩm mới rồi gán vào biến "sp"
                SanPham sp = new SanPham(
                    rs.getInt("id_san_pham"),
                    rs.getString("ten_san_pham"),
                    rs.getString("mo_ta"),
                    rs.getString("url_anh"),
                    rs.getString("nha_san_xuat"),
                    rs.getDouble("gia_co_ban"),
                    rs.getInt("trang_thai")
                );
                
                //Lấy id_bien_the từ database rồi gán vào object sản phẩm sp.
                sp.setIdBienThe(rs.getInt("id_bien_the"));
                
                // Cho object "sp" vào list
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Bổ sung hàm getAll() để khớp với Admin/Staff Servlet nếu cần
    public List<SanPham> getAll() {
        return getAllSanPham();
    }

    // 2. LẤY CHI TIẾT 1 SẢN PHẨM (Thêm rs.getInt("so_luong_ton"))
    public SanPham getSanPhamById(int id) {
        String sql = "SELECT * FROM san_pham WHERE id_san_pham = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new SanPham(
                        rs.getInt("id_san_pham"), rs.getString("ten_san_pham"),
                        rs.getString("mo_ta"), rs.getString("url_anh"),
                        rs.getString("nha_san_xuat"), rs.getDouble("gia_co_ban"),
                        rs.getInt("trang_thai")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. THÊM SẢN PHẨM MỚI (Thêm cột so_luong_ton vào câu INSERT)
    public boolean addSanPham(SanPham sp) {
        String sql = "INSERT INTO san_pham (ten_san_pham, mo_ta, url_anh, nha_san_xuat, gia_co_ban, trang_thai) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sp.getTenSanPham());
            ps.setString(2, sp.getMoTa());
            ps.setString(3, sp.getUrlAnh());
            ps.setString(4, sp.getNhaSanXuat());
            ps.setDouble(5, sp.getGiaCoBan());
            ps.setInt(6, sp.getTrangThai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 4. CẬP NHẬT SẢN PHẨM (Thêm so_luong_ton=? vào câu UPDATE)
    public boolean updateSanPham(SanPham sp) {
        String sql = "UPDATE san_pham SET ten_san_pham=?, mo_ta=?, url_anh=?, nha_san_xuat=?, gia_co_ban=?, trang_thai=? WHERE id_san_pham=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sp.getTenSanPham());
            ps.setString(2, sp.getMoTa());
            ps.setString(3, sp.getUrlAnh());
            ps.setString(4, sp.getNhaSanXuat());
            ps.setDouble(5, sp.getGiaCoBan());
            ps.setInt(6, sp.getTrangThai());
            ps.setInt(7, sp.getIdSanPham());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 5. XÓA SẢN PHẨM (Không đổi)
    public boolean deleteSanPham(int id) {
        String sql = "DELETE FROM san_pham WHERE id_san_pham = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 6. TÌM KIẾM SẢN PHẨM THEO TÊN (Thêm rs.getInt("so_luong_ton"))
    public List<SanPham> searchSanPhamByName(String keyword) {
        List<SanPham> list = new ArrayList<>();
        String sql =
            "SELECT sp.*, MIN(bt.id_bien_the) AS id_bien_the " +
            "FROM san_pham sp " +
            "LEFT JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham " +
            "WHERE sp.ten_san_pham LIKE ? " +
            "GROUP BY sp.id_san_pham " +
            "ORDER BY sp.id_san_pham DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham sp = new SanPham(
                        rs.getInt("id_san_pham"), rs.getString("ten_san_pham"),
                        rs.getString("mo_ta"), rs.getString("url_anh"),
                        rs.getString("nha_san_xuat"), rs.getDouble("gia_co_ban"),
                        rs.getInt("trang_thai")
                    );
                    sp.setIdBienThe(rs.getInt("id_bien_the"));
                    list.add(sp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
