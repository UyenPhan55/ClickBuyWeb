package controller;

import dao.LichSuHoatDongDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import util.SessionUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/LichSuHoatDongServlet") 

public class LichSuHoatDongServlet extends HttpServlet {
    private final LichSuHoatDongDAO dao = new LichSuHoatDongDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try {
            if (!SessionUtil.isAdmin(request)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            request.setAttribute("danhSachLichSu", dao.getAllLogs());
            request.getRequestDispatcher("/admin/lich-su-hoat-dong/danh-sach-lich-su.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
