package controller;

import dao.NguoiDungDAO;
import dao.SanPhamDAO;
import dao.DonHangDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    private final SanPhamDAO   sanPhamDAO   = new SanPhamDAO();
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final DonHangDAO   donHangDAO   = new DonHangDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            model.NguoiDung user = (model.NguoiDung) req.getSession().getAttribute("user");
            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
                return;
            }
            if (user.getIdVaiTro() != 1) {
                res.sendRedirect(req.getContextPath() + "/TrangChuServlet");
                return;
            }

            req.setAttribute("totalProducts", sanPhamDAO.getAllSanPham().size());
            req.setAttribute("totalUsers",    nguoiDungDAO.getAll().size());
            req.setAttribute("totalOrders",   donHangDAO.getAllOrders().size());
            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, res);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}