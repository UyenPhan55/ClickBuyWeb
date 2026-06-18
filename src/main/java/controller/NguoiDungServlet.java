package controller;

import dao.NguoiDungDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import util.SessionUtil;

@WebServlet("/NguoiDungServlet")
public class NguoiDungServlet extends HttpServlet {

    private final NguoiDungDAO dao = new NguoiDungDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        if (!SessionUtil.isLoggedIn(req)) {
            res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
            return;
        }

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

        if (SessionUtil.isAdmin(req)) {
            if ("lock".equals(action)) {
                dao.updateStatus(Integer.parseInt(req.getParameter("id")), 0);
            } else if ("unlock".equals(action)) {
                dao.updateStatus(Integer.parseInt(req.getParameter("id")), 1);
            } else if ("role".equals(action)) {
                dao.updateRole(
                        Integer.parseInt(req.getParameter("id")),
                        Integer.parseInt(req.getParameter("role")));
            }

            req.setAttribute("userList", dao.getAll());
            req.getRequestDispatcher("/admin/nguoi-dung/danh-sach-tai-khoan.jsp")
                    .forward(req, res);
            return;
        }

        if (SessionUtil.isStaffOrAdmin(req)) {
            req.setAttribute("danhSachNguoiDung", dao.getAll());
            req.getRequestDispatcher("/staff/nguoi-dung/danh-sach-nguoi-dung.jsp")
                    .forward(req, res);
            return;
        }

        res.sendError(HttpServletResponse.SC_FORBIDDEN);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}
