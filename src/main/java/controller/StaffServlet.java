package controller;

import dao.SanPhamDAO;
import dao.DonHangDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException; 
@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            model.NguoiDung user = (model.NguoiDung) req.getSession().getAttribute("user");
            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
                return;
            }
            if (user.getIdVaiTro() != 1 && user.getIdVaiTro() != 2) {
                res.sendRedirect(req.getContextPath() + "/TrangChuServlet");
                return;
            }

            req.setAttribute("totalProducts", new SanPhamDAO().getAll().size());
            req.setAttribute("totalOrders",   new DonHangDAO().getAll().size());

            req.getRequestDispatcher("/staff/dashboard.jsp").forward(req, res);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}