package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.MaGiamGia;

public class MaGiamGiaDAO {

    // 1. Lấy tất cả mã giảm giá
    public List<MaGiamGia> getAllMaGiamGia() {
        List<MaGiamGia> list = new ArrayList<>();
        String sql = "SELECT * FROM ma_giam_gia ORDER BY id_voucher DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapMaGiamGia(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm bí danh để khớp với Admin/Staff Servlet
    public List<MaGiamGia> getAll() {
        return getAllMaGiamGia();
    }

    // 2. Lấy mã giảm giá theo ID
    public MaGiamGia getById(int id) {
        String sql = "SELECT * FROM ma_giam_gia WHERE id_voucher = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapMaGiamGia(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Lấy mã giảm giá theo Code (Dùng khi khách hàng nhập mã ở giỏ hàng)
    public MaGiamGia getByCode(String code) {
        String sql = "SELECT * FROM ma_giam_gia WHERE ma_code = ? AND trang_thai = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapMaGiamGia(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Thêm mã giảm giá mới
    public boolean addMaGiamGia(MaGiamGia mgg) {
        String sql = "INSERT INTO ma_giam_gia (ma_code, loai_giam, gia_tri_giam, don_toi_thieu, "
                   + "giam_toi_da, so_luong_gioi_han, ngay_bat_dau, ngay_het_han, trang_thai) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, mgg.getMaCode());
            ps.setString(2, mgg.getLoaiGiam());
            ps.setBigDecimal(3, mgg.getGiaTriGiam());
            ps.setBigDecimal(4, mgg.getDonToiThieu());
            ps.setBigDecimal(5, mgg.getGiamToiDa());
            ps.setInt(6, mgg.getSoLuongGioiHan());
            ps.setTimestamp(7, new Timestamp(mgg.getNgayBatDau().getTime()));
            ps.setTimestamp(8, new Timestamp(mgg.getNgayHetHan().getTime()));
            ps.setInt(9, mgg.getTrangThai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 5. Xóa mã giảm giá
    public boolean deleteMaGiamGia(int id) {
        String sql = "DELETE FROM ma_giam_gia WHERE id_voucher = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hàm phụ để map dữ liệu từ ResultSet sang Object
    private MaGiamGia mapMaGiamGia(ResultSet rs) throws Exception {
        MaGiamGia mgg = new MaGiamGia();
        mgg.setIdVoucher(rs.getInt("id_voucher"));
        mgg.setMaCode(rs.getString("ma_code"));
        mgg.setLoaiGiam(rs.getString("loai_giam"));
        mgg.setGiaTriGiam(rs.getBigDecimal("gia_tri_giam"));
        mgg.setDonToiThieu(rs.getBigDecimal("don_toi_thieu"));
        mgg.setGiamToiDa(rs.getBigDecimal("giam_toi_da"));
        mgg.setSoLuongGioiHan(rs.getInt("so_luong_gioi_han"));
        mgg.setNgayBatDau(rs.getTimestamp("ngay_bat_dau"));
        mgg.setNgayHetHan(rs.getTimestamp("ngay_het_han"));
        mgg.setTrangThai(rs.getInt("trang_thai"));
        return mgg;
    }
}
