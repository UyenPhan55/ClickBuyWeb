package controller;

import dao.SanPhamDAO;
import dao.SanPhamTrongGioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.NguoiDung;

@WebServlet("/TrangChuServlet")
public class TrangChuServlet extends HttpServlet {

    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final SanPhamTrongGioDAO gioDAO = new SanPhamTrongGioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ===== 1. CẬP NHẬT BADGE GIỎ HÀNG =====
        NguoiDung user = (NguoiDung) req.getSession().getAttribute("user");
        if (user != null) {
            try {
                int cartCount = gioDAO.countItems(user.getIdNguoiDung());
                req.getSession().setAttribute("soLuongGio", cartCount);
            } catch (Exception e) {
                req.getSession().setAttribute("soLuongGio", 0);
            }

            // ===== 2. THÔNG BÁO CHÀO SAU ĐĂNG NHẬP =====
            if (req.getSession().getAttribute("justLoggedIn") != null) {
                req.setAttribute("welcomeMsg",
                    "Chào mừng <strong>" + user.getTenDayDu() + "</strong> quay trở lại!");
                req.getSession().removeAttribute("justLoggedIn");
            }
        }

        // ===== 3. PHÂN TRANG =====
        int page     = 1;
        int pageSize = 9;
        try {
            String p = req.getParameter("page");
            if (p != null) page = Integer.parseInt(p);
            if (page < 1) page = 1;
        } catch (Exception ignored) {}

        java.util.List<model.SanPham> allProducts = sanPhamDAO.getAllSanPham();
        int totalProducts = allProducts.size();
        int totalPages    = (int) Math.ceil((double) totalProducts / pageSize);
        if (page > totalPages && totalPages > 0) page = totalPages;

        int fromIndex = (page - 1) * pageSize;
        int toIndex   = Math.min(fromIndex + pageSize, totalProducts);
        java.util.List<model.SanPham> pagedProducts =
            fromIndex < totalProducts
            ? allProducts.subList(fromIndex, toIndex)
            : new java.util.ArrayList<>();

        req.setAttribute("latestProducts", pagedProducts);
        req.setAttribute("currentPage",    page);
        req.setAttribute("totalPages",     totalPages);

        req.getRequestDispatcher("/user/trang-chu.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}