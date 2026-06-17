package controller;

import dao.ThongBaoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import util.SessionUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/ThongBaoServlet", "/thong-bao"}) 

public class ThongBaoServlet extends HttpServlet {
    private final ThongBaoDAO dao = new ThongBaoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "list";
        try {
            Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);
            if (idNguoiDung == null) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
                return;
            }

            if ("read".equals(action)) {
                int idThongBao = Integer.parseInt(request.getParameter("id"));
                dao.markAsRead(idThongBao, idNguoiDung);
                response.sendRedirect(request.getContextPath() + "/thong-bao?action=list");
                return;
            }

            if ("readAll".equals(action)) {
                dao.markAllAsRead(idNguoiDung);
                response.sendRedirect(request.getContextPath() + "/thong-bao?action=list");
                return;
            }

            request.setAttribute("danhSachThongBao", dao.getThongBaoByUser(idNguoiDung));
            int unreadCount = dao.countUnread(idNguoiDung);
            request.setAttribute("soThongBaoChuaDoc", unreadCount);
            request.getSession().setAttribute("totalNoti", unreadCount);
            request.getRequestDispatcher("/user/danh-sach-thong-bao.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
