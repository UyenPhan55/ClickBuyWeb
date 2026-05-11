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

            req.setAttribute("totalProducts", new SanPhamDAO().getAllSanPham().size());
            req.setAttribute("totalUsers",    new NguoiDungDAO().getAll().size());
            req.setAttribute("totalOrders",   new DonHangDAO().getAllOrders().size());

            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, res);
            
        } catch (SQLException e) {
            // Bọc lỗi SQL thành RuntimeException để Java không bắt bẻ ở dòng doGet nữa
            throw new ServletException(e); 
        }
    }
}