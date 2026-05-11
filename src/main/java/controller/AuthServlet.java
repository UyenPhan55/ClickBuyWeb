package controller;

import dao.NguoiDungDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.NguoiDung;
import util.SessionUtil;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {

    private final NguoiDungDAO dao = new NguoiDungDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ===== ĐĂNG NHẬP =====
        if ("login".equals(action)) {
            String input    = req.getParameter("user_input");  // email hoặc SĐT
            String password = req.getParameter("mat_khau");

            // Validate trống
            if (input == null || input.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
                req.getRequestDispatcher("/dang-nhap.jsp").forward(req, res);
                return;
            }

            NguoiDung user = dao.login(input.trim(), password);

            if (user == null) {
                req.setAttribute("error", "Email/SĐT hoặc mật khẩu không đúng!");
                req.getRequestDispatcher("/dang-nhap.jsp").forward(req, res);
                return;
            }

            // Lưu vào session
            SessionUtil.saveUser(req, user);

            // Điều hướng theo vai trò
            String ctx = req.getContextPath();
            if (user.getIdVaiTro() == 1) {
                res.sendRedirect(ctx + "/AdminServlet");       // Admin
            } else if (user.getIdVaiTro() == 2) {
                res.sendRedirect(ctx + "/StaffServlet");       // Nhân viên
            } else {
                res.sendRedirect(ctx + "/TrangChuServlet");    // Khách hàng
            }

        // ===== ĐĂNG KÝ =====
        } else if ("register".equals(action)) {
            String ten      = req.getParameter("ten_day_du");
            String email    = req.getParameter("email");
            String password = req.getParameter("mat_khau");
            String confirm  = req.getParameter("confirmPassword");
            String sdt      = req.getParameter("sdt");

            // Validate trống
            if (ten == null || ten.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
                req.getRequestDispatcher("/dang-ky.jsp").forward(req, res);
                return;
            }

            // Validate mật khẩu xác nhận
            if (!password.equals(confirm)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                req.getRequestDispatcher("/dang-ky.jsp").forward(req, res);
                return;
            }

            // Validate độ dài mật khẩu
            if (password.length() < 6) {
                req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
                req.getRequestDispatcher("/dang-ky.jsp").forward(req, res);
                return;
            }

            // Kiểm tra email đã tồn tại
            if (dao.emailExists(email.trim())) {
                req.setAttribute("error", "Email này đã được đăng ký!");
                req.getRequestDispatcher("/dang-ky.jsp").forward(req, res);
                return;
            }

            // Tạo object và đăng ký
            NguoiDung u = new NguoiDung();
            u.setTenDayDu(ten.trim());
            u.setEmail(email.trim());
            u.setMatKhau(password);   
            u.setSdt(sdt != null ? sdt.trim() : "");

            boolean ok = dao.register(u);

            if (ok) {
                req.getSession().setAttribute("successMessage",
                    "Đăng ký thành công! Hãy đăng nhập.");
                res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
            } else {
                req.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
                req.getRequestDispatcher("/dang-ky.jsp").forward(req, res);
            }

        // ===== ĐĂNG XUẤT =====
        } else if ("logout".equals(action)) {
            SessionUtil.logout(req);
            res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equals(action)) {
            SessionUtil.logout(req);
        }
        res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
    }
}