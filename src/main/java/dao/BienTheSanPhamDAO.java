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
            
            // Nếu sản phẩm chưa có biến thể, tự động tạo biến thể mặc định
            if (list.isEmpty()) {
                double giaCoBan = 0.0;
                String getPriceSql = "SELECT gia_co_ban FROM san_pham WHERE id_san_pham = ?";
                try (PreparedStatement pricePs = conn.prepareStatement(getPriceSql)) {
                    pricePs.setInt(1, idSanPham);
                    try (ResultSet priceRs = pricePs.executeQuery()) {
                        if (priceRs.next()) {
                            giaCoBan = priceRs.getDouble("gia_co_ban");
                        }
                    }
                }
                
                String insertSql = "INSERT INTO bien_the_san_pham (id_san_pham, ten_bien_the, gia_bien_the, so_luong_ton) VALUES (?, 'Tiêu chuẩn', ?, 100)";
                try (PreparedStatement insertPs = conn.prepareStatement(insertSql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                    insertPs.setInt(1, idSanPham);
                    insertPs.setBigDecimal(2, java.math.BigDecimal.valueOf(giaCoBan));
                    insertPs.executeUpdate();
                    
                    try (ResultSet keys = insertPs.getGeneratedKeys()) {
                        if (keys.next()) {
                            int newId = keys.getInt(1);
                            list.add(new BienTheSanPham(
                                newId,
                                idSanPham,
                                "Tiêu chuẩn",
                                java.math.BigDecimal.valueOf(giaCoBan),
                                100
                            ));
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
