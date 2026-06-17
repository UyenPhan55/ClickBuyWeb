package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.NguoiDung;

public class SessionUtil {

    // Lưu user vào session sau khi đăng nhập
    public static void saveUser(HttpServletRequest req, NguoiDung user) {
        req.getSession().setAttribute("user", user);
    }

    // Lấy user từ session
    public static NguoiDung getUser(HttpServletRequest req) {
        return (NguoiDung) req.getSession().getAttribute("user");
    }

    // Đăng xuất — hủy toàn bộ session
    public static void logout(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
    }

    // Kiểm tra đã đăng nhập chưa
    public static boolean isLoggedIn(HttpServletRequest req) {
        return getUser(req) != null;
    }

    // Kiểm tra là admin
    public static boolean isAdmin(HttpServletRequest req) {
        NguoiDung u = getUser(req);
        return u != null && u.getIdVaiTro() == 1;
    }

    // Kiểm tra là nhân viên hoặc admin
    public static boolean isStaff(HttpServletRequest req) {
        NguoiDung u = getUser(req);
        return u != null && (u.getIdVaiTro() == 1 || u.getIdVaiTro() == 2);
    }

    // Lấy ID người dùng từ session
    public static Integer getIdNguoiDung(HttpServletRequest req) {
        NguoiDung user = (NguoiDung) req.getSession().getAttribute("user");
        return (user != null) ? user.getIdNguoiDung() : null;
    }

    // Kiểm tra là nhân viên hoặc admin (Dùng hàm này cho phân quyền)
    public static boolean isStaffOrAdmin(HttpServletRequest req) {
        NguoiDung u = getUser(req);
        return u != null && (u.getIdVaiTro() == 1 || u.getIdVaiTro() == 2);
    }
}