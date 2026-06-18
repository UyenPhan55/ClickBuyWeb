package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.SanPham;

public class SanPhamDAO {

    // 1. LẤY DANH SÁCH SẢN PHẨM
    public List<SanPham> getAllSanPham() {
        List<SanPham> list = new ArrayList<>();
        String sql =
            "SELECT sp.*, " +
            "(SELECT MIN(bt.id_bien_the) FROM bien_the_san_pham bt WHERE bt.id_san_pham = sp.id_san_pham) AS id_bien_the " +
            "FROM san_pham sp " +
            "ORDER BY sp.id_san_pham DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                // Tạo object sản phẩm mới rồi gán vào biến sp
                SanPham sp = new SanPham(
                    rs.getInt("id_san_pham"),
                    rs.getString("ten_san_pham"),
                    rs.getString("mo_ta"),
                    rs.getString("url_anh"),
                    rs.getString("nha_san_xuat"),
                    rs.getDouble("gia_co_ban"),
                    rs.getInt("trang_thai")
                );

                // Lấy id_bien_the từ database rồi gán vào object sản phẩm sp
                int idBT = rs.getInt("id_bien_the");
                if (idBT == 0) {
                    idBT = createDefaultVariant(sp.getIdSanPham(), sp.getGiaCoBan());
                }
                sp.setIdBienThe(idBT);

                // Cho object sp vào list
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

    // 2. LẤY CHI TIẾT 1 SẢN PHẨM
    public SanPham getSanPhamById(int id) {
        String sql =
            "SELECT sp.*, " +
            "(SELECT MIN(bt.id_bien_the) FROM bien_the_san_pham bt WHERE bt.id_san_pham = sp.id_san_pham) AS id_bien_the " +
            "FROM san_pham sp " +
            "WHERE sp.id_san_pham = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    SanPham sp = new SanPham(
                        rs.getInt("id_san_pham"),
                        rs.getString("ten_san_pham"),
                        rs.getString("mo_ta"),
                        rs.getString("url_anh"),
                        rs.getString("nha_san_xuat"),
                        rs.getDouble("gia_co_ban"),
                        rs.getInt("trang_thai")
                    );

                    int idBT = rs.getInt("id_bien_the");
                    if (idBT == 0) {
                        idBT = createDefaultVariant(sp.getIdSanPham(), sp.getGiaCoBan());
                    }
                    sp.setIdBienThe(idBT);

                    return sp;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // 3. THÊM SẢN PHẨM MỚI
    public boolean addSanPham(SanPham sp) {
        String sql = "INSERT INTO san_pham (ten_san_pham, mo_ta, url_anh, nha_san_xuat, gia_co_ban, trang_thai) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, sp.getTenSanPham());
            ps.setString(2, sp.getMoTa());
            ps.setString(3, sp.getUrlAnh());
            ps.setString(4, sp.getNhaSanXuat());
            ps.setDouble(5, sp.getGiaCoBan());
            ps.setInt(6, sp.getTrangThai());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        sp.setIdSanPham(keys.getInt(1));
                    }
                }
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // 4. CẬP NHẬT SẢN PHẨM
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

    // 5. XÓA SẢN PHẨM
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

    // 6. TÌM KIẾM SẢN PHẨM THEO TÊN
    public List<SanPham> searchSanPhamByName(String keyword) {
        List<SanPham> list = new ArrayList<>();

        String sql =
            "SELECT sp.*, " +
            "(SELECT MIN(bt.id_bien_the) FROM bien_the_san_pham bt WHERE bt.id_san_pham = sp.id_san_pham) AS id_bien_the " +
            "FROM san_pham sp " +
            "WHERE sp.ten_san_pham LIKE ? " +
            "ORDER BY sp.id_san_pham DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham sp = new SanPham(
                        rs.getInt("id_san_pham"),
                        rs.getString("ten_san_pham"),
                        rs.getString("mo_ta"),
                        rs.getString("url_anh"),
                        rs.getString("nha_san_xuat"),
                        rs.getDouble("gia_co_ban"),
                        rs.getInt("trang_thai")
                    );

                    int idBT = rs.getInt("id_bien_the");
                    if (idBT == 0) {
                        idBT = createDefaultVariant(sp.getIdSanPham(), sp.getGiaCoBan());
                    }
                    sp.setIdBienThe(idBT);

                    list.add(sp);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    private int createDefaultVariant(int idSanPham, double giaCoBan) {
        String sql = "INSERT INTO bien_the_san_pham (id_san_pham, ten_bien_the, gia_bien_the, so_luong_ton) VALUES (?, 'Tiêu chuẩn', ?, 100)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, idSanPham);
            ps.setBigDecimal(2, java.math.BigDecimal.valueOf(giaCoBan));
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}