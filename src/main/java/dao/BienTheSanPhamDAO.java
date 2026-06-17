package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.BienTheSanPham;

public class BienTheSanPhamDAO {

    public List<BienTheSanPham> getBienTheBySanPhamId(int idSanPham) {
        List<BienTheSanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM bien_the_san_pham WHERE id_san_pham = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSanPham);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new BienTheSanPham(
                        rs.getInt("id_bien_the"),
                        rs.getInt("id_san_pham"),
                        rs.getString("ten_bien_the"),
                        rs.getBigDecimal("gia_bien_the"),
                        rs.getInt("so_luong_ton")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}