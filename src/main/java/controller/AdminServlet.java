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
            throws ServletException, IOException { // Bỏ SQLException ở đây đi để hết lỗi đỏ ở dòng 16

        try {
            // Giữ nguyên toàn bộ logic của bạn ở đây
            model.NguoiDung user = (model.NguoiDung) req.getSession().getAttribute("user");
            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
                return;
            }
            if (user.getIdVaiTro() != 1) {
                res.sendRedirect(req.getContextPath() + "/TrangChuServlet");
                return;
            }

            req.setAttribute("totalProducts", new SanPhamDAO().getAll().size());
            req.setAttribute("totalUsers",    new NguoiDungDAO().getAll().size());
            req.setAttribute("totalOrders",   new DonHangDAO().getAll().size());

            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, res);
            
        } catch (SQLException e) {
            // Bọc lỗi SQL thành RuntimeException để Java không bắt bẻ ở dòng doGet nữa
            throw new ServletException(e); 
        }
    }
}