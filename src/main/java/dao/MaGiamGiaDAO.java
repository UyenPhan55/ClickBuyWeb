package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.MaGiamGia;

public class MaGiamGiaDAO {

    public MaGiamGia getMaGiamGiaByCode(String code) {
        String sql = "SELECT * FROM ma_giam_gia WHERE ma_code = ? AND trang_thai = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new MaGiamGia(
                        rs.getInt("id_voucher"),
                        rs.getString("ma_code"),
                        rs.getString("loai_giam"),
                        rs.getDouble("gia_tri_giam"),
                        rs.getDouble("don_toi_thieu"),
                        rs.getDouble("giam_toi_da"),
                        rs.getInt("so_luong_gioi_han"),
                        rs.getTimestamp("ngay_bat_dau"),
                        rs.getTimestamp("ngay_het_han"),
                        rs.getInt("trang_thai")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}