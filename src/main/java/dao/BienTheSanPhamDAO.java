package dao;

import model.BienTheSanPham;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BienTheSanPhamDAO {

    public List<BienTheSanPham> getBienTheBySanPhamId(int sanPhamId) {
        List<BienTheSanPham> list = new ArrayList<>();
        String query = "SELECT * FROM BienTheSanPham WHERE sanPhamId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, sanPhamId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new BienTheSanPham(
                        rs.getInt("id"), rs.getInt("sanPhamId"),
                        rs.getString("mauSac"), rs.getString("dungLuong"),
                        rs.getDouble("giaBan"), rs.getInt("soLuongTon")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}