package dao;

import model.MaGiamGia;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MaGiamGiaDAO {

    // Chức năng quan trọng nhất: Lấy và kiểm tra mã giảm giá khi USER nhập vào
    public MaGiamGia getMaGiamGiaByCode(String maCode) {
        // Query kiểm tra mã còn hạn và còn số lượng sử dụng không
        String query = "SELECT * FROM MaGiamGia WHERE maCode = ? AND ngayKetThuc >= NOW() AND soLuongDaDung < soLuongToiDa";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, maCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    MaGiamGia mgg = new MaGiamGia();
                    mgg.setId(rs.getInt("id"));
                    mgg.setMaCode(rs.getString("maCode"));
                    mgg.setGiaTriGiam(rs.getDouble("giaTriGiam"));
                    mgg.setLoaiGiam(rs.getString("loaiGiam"));
                    mgg.setDonToiThieu(rs.getDouble("donToiThieu"));
                    return mgg;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu mã sai, hết hạn hoặc hết lượt
    }
    
    // STAFF/ADMIN có thể cần thêm các hàm getList, insert, update... Bạn có thể bổ sung tương tự SanPhamDAO
}