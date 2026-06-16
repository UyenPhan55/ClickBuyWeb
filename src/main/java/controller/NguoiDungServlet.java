package controller;

import dao.NguoiDungDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import util.SessionUtil;

@WebServlet("/NguoiDungServlet")
public class NguoiDungServlet extends HttpServlet {

    private final NguoiDungDAO dao = new NguoiDungDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!SessionUtil.isAdmin(req)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = req.getParameter("action");

        if ("lock".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.updateStatus(id, 0);
        } else if ("unlock".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.updateStatus(id, 1);
        } else if ("role".equals(action)) {
            int id   = Integer.parseInt(req.getParameter("id"));
            int role = Integer.parseInt(req.getParameter("role"));
            dao.updateRole(id, role);
        }

        req.setAttribute("userList", dao.getAll());
        req.getRequestDispatcher("/admin/nguoi-dung/danh-sach-tai-khoan.jsp")
           .forward(req, res);
    }
}
