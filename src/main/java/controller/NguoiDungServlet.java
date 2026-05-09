package controller;

import dao.NguoiDungDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/NguoiDungServlet")
public class NguoiDungServlet extends HttpServlet {

    private final NguoiDungDAO dao = new NguoiDungDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // Khóa tài khoản
        if ("lock".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.updateStatus(id, 0);

        // Mở tài khoản
        } else if ("unlock".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.updateStatus(id, 1);

        // Đổi vai trò
        } else if ("role".equals(action)) {
            int id   = Integer.parseInt(req.getParameter("id"));
            int role = Integer.parseInt(req.getParameter("role"));
            dao.updateRole(id, role);
        }

        // Luôn load lại danh sách sau khi thực hiện action
        req.setAttribute("userList", dao.getAll());
        req.getRequestDispatcher("/admin/nguoi-dung/danh-sach-tai-khoan.jsp")
           .forward(req, res);
    }
}