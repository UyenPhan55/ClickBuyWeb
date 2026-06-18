package controller;

import dao.KhieuNaiDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import util.LogUtil;
import util.SessionUtil;

@WebServlet({"/KhieuNaiServlet", "/khieu-nai"})
public class KhieuNaiServlet extends HttpServlet {
    private final KhieuNaiDAO dao = new KhieuNaiDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "mine";
        }

        try {
            Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);
            if (idNguoiDung == null) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
                return;
            }

            if ("staff-list".equals(action)) {
                if (!SessionUtil.isStaffOrAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                request.setAttribute("danhSachKhieuNai", dao.getAllKhieuNai());
                request.getRequestDispatcher(SessionUtil.isAdmin(request)
                        ? "/admin/khieu-nai/danh-sach-khieu-nai.jsp"
                        : "/staff/khieu-nai/danh-sach-khieu-nai.jsp")
                        .forward(request, response);
                return;
            }

            request.setAttribute("danhSachKhieuNai", dao.getKhieuNaiByUser(idNguoiDung));
            request.getRequestDispatcher("/user/gui-khieu-nai.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        try {
            Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);
            if (idNguoiDung == null) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
                return;
            }

            if ("add".equals(action)) {
                int idDonHang = Integer.parseInt(request.getParameter("idDonHang"));
                String noiDung = request.getParameter("noiDung");
                int yeuCauTraHang = request.getParameter("yeuCauTraHang") == null ? 0 : 1;

                dao.insertKhieuNai(idNguoiDung, idDonHang, noiDung, yeuCauTraHang);
                response.sendRedirect(request.getContextPath() + "/khieu-nai?action=mine");
                return;
            }

            if ("reply".equals(action)) {
                if (!SessionUtil.isStaffOrAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                int idKhieuNai = Integer.parseInt(request.getParameter("idKhieuNai"));
                String phanHoi = request.getParameter("phanHoi");
                String trangThai = request.getParameter("trangThai");

                dao.phanHoiKhieuNai(idKhieuNai, phanHoi, trangThai);
                LogUtil.ghiLog(request, "Xu ly khieu nai", "khieu_nai", idKhieuNai);
                response.sendRedirect(request.getContextPath() + "/KhieuNaiServlet?action=staff-list");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/khieu-nai?action=mine");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
