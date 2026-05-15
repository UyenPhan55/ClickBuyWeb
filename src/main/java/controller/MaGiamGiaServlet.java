package controller;

import dao.MaGiamGiaDAO;
import dao.DBConnection;
import model.MaGiamGia;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/MaGiamGiaServlet")
public class MaGiamGiaServlet extends HttpServlet {

    private final MaGiamGiaDAO dao = new MaGiamGiaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Giữ nguyên phần GET của bà để Staff xem danh sách
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                default:
                    List<Map<String, Object>> list = new ArrayList<>();
                    String sql = "SELECT * FROM ma_giam_gia ORDER BY id_voucher DESC";
                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement ps = conn.prepareStatement(sql);
                         ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Map<String, Object> row = new LinkedHashMap<>();
                            row.put("idVoucher",      rs.getInt("id_voucher"));
                            row.put("maCode",         rs.getString("ma_code"));
                            row.put("loaiGiam",       rs.getString("loai_giam"));
                            row.put("giaTriGiam",     rs.getDouble("gia_tri_giam"));
                            row.put("donToiThieu",    rs.getDouble("don_toi_thieu"));
                            row.put("giamToiDa",      rs.getDouble("giam_toi_da"));
                            row.put("soLuongGioiHan", rs.getInt("so_luong_gioi_han"));
                            row.put("ngayBatDau",     rs.getDate("ngay_bat_dau"));
                            row.put("ngayHetHan",     rs.getDate("ngay_het_han"));
                            row.put("trangThai",      rs.getInt("trang_thai"));
                            list.add(row);
                        }
                    }
                    req.setAttribute("danhSachMaGiamGia", list);
                    req.getRequestDispatcher("/staff/ma-giam-gia/danh-sach-ma-giam-gia.jsp").forward(req, res);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // 1. Lấy mã voucher từ JSP gửi lên
        String code = req.getParameter("voucherCode");
        MaGiamGia mgg = dao.getMaGiamGiaByCode(code);

        HttpSession session = req.getSession();
        
        if (mgg != null) {
            // Trường hợp mã hợp lệ
            session.setAttribute("discount", mgg);
            session.setAttribute("voucherMsg", "Áp dụng mã " + code + " thành công!");
            
            // QUAN TRỌNG: Điều hướng quay lại DonHangServlet (trang thanh toán)
            res.sendRedirect(req.getContextPath() + "/DonHangServlet?action=checkout&status=success");
        } else {
            // Trường hợp mã sai hoặc hết hạn
            session.removeAttribute("discount"); // Xóa giảm giá cũ nếu có
            session.setAttribute("voucherMsg", "Mã giảm giá '" + code + "' không tồn tại hoặc đã hết hạn!");
            
            // QUAN TRỌNG: Vẫn quay lại trang thanh toán để khách nhập mã khác
            res.sendRedirect(req.getContextPath() + "/DonHangServlet?action=checkout&status=invalid");
        }
    }
}
