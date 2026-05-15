package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.MaGiamGia;

public class MaGiamGiaDAO {

    // 1. Hàm lấy 1 mã giảm giá theo Code (Để check khi bấm nút Áp Dụng)
    public MaGiamGia getMaGiamGiaByCode(String code) {
        String sql = "SELECT * FROM ma_giam_gia WHERE ma_code = ? AND trang_thai = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapVoucher(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 2. HÀM MỚI: Lấy tất cả mã giảm giá (Để hiện lên ô chọn ở trang Thanh Toán)
    public List<MaGiamGia> getAllVouchers() {
        List<MaGiamGia> list = new ArrayList<>();
        // Chỉ lấy những mã đang hoạt động và còn lượt sử dụng
        String sql = "SELECT * FROM ma_giam_gia WHERE trang_thai = 1 AND so_luong_gioi_han > 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapVoucher(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Hàm phụ để chuyển dữ liệu từ ResultSet sang Object MaGiamGia
    // Giúp bà đỡ phải viết lại đoạn code khởi tạo dài dòng
    private MaGiamGia mapVoucher(ResultSet rs) throws Exception {
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
