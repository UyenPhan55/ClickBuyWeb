package dao;

import java.sql.*;
import java.util.*;
import model.NguoiDung;
import util.PasswordUtil;

public class NguoiDungDAO {

    // ===== ĐĂNG NHẬP =====
    // Nhận email hoặc SĐT + mật khẩu thô, trả về NguoiDung nếu hợp lệ
    public NguoiDung login(String input, String rawPassword) {
        String sql = "SELECT * FROM nguoi_dung WHERE (email = ? OR sdt = ?) AND trang_thai = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, input);
            ps.setString(2, input);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("mat_khau");
                if (PasswordUtil.check(rawPassword, storedHash)) {
                    return mapRow(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ===== ĐĂNG KÝ =====
    public boolean register(NguoiDung u) {
        String sql = "INSERT INTO nguoi_dung(ten_day_du, email, mat_khau, sdt, id_vai_tro, trang_thai) " +
                     "VALUES (?, ?, ?, ?, 3, 1)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getTenDayDu());
            ps.setString(2, u.getEmail());
            ps.setString(3, PasswordUtil.hash(u.getMatKhau())); // Hash trước khi lưu
            ps.setString(4, u.getSdt());
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ===== KIỂM TRA EMAIL ĐÃ TỒN TẠI =====
    public boolean emailExists(String email) {
        String sql = "SELECT id_nguoi_dung FROM nguoi_dung WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            return ps.executeQuery().next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ===== LẤY TẤT CẢ NGƯỜI DÙNG (cho Admin) =====
    public List<NguoiDung> getAll() {
        List<NguoiDung> list = new ArrayList<>();
        String sql = "SELECT * FROM nguoi_dung ORDER BY id_nguoi_dung DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ===== LẤY 1 NGƯỜI DÙNG THEO ID =====
    public NguoiDung getById(int id) {
        String sql = "SELECT * FROM nguoi_dung WHERE id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ===== KHÓA / MỞ TÀI KHOẢN =====
    public void updateStatus(int id, int trangThai) {
        String sql = "UPDATE nguoi_dung SET trang_thai = ? WHERE id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, trangThai);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===== PHÂN QUYỀN =====
    public void updateRole(int id, int idVaiTro) {
        String sql = "UPDATE nguoi_dung SET id_vai_tro = ? WHERE id_nguoi_dung = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idVaiTro);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===== MAP ResultSet → NguoiDung =====
    private NguoiDung mapRow(ResultSet rs) throws SQLException {
        NguoiDung u = new NguoiDung();
        u.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
        u.setTenDayDu(rs.getString("ten_day_du"));
        u.setEmail(rs.getString("email"));
        u.setMatKhau(rs.getString("mat_khau"));
        u.setSdt(rs.getString("sdt"));
        u.setIdVaiTro(rs.getInt("id_vai_tro"));
        u.setTrangThai(rs.getInt("trang_thai"));
        try { u.setDiaChi(rs.getString("dia_chi")); } catch (Exception ignored) {}
        return u;
    }
}