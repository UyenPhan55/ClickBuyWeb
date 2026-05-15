package controller;

import dao.DanhGiaDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import util.LogUtil;
import util.SessionUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "DanhGiaServlet", urlPatterns = {"/DanhGiaServlet", "/danh-gia"})

public class DanhGiaServlet extends HttpServlet {
    private final DanhGiaDAO dao = new DanhGiaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "manage";
        try {
            if ("manage".equals(action)) {
                if (!SessionUtil.isStaffOrAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                request.setAttribute("danhSachDanhGia", dao.getAllDanhGia());
                request.getRequestDispatcher("/staff/danh-gia/quan-ly-danh-gia.jsp").forward(request, response);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/trang-chu");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                int idBienThe = Integer.parseInt(request.getParameter("idBienThe"));
                int soSao = Integer.parseInt(request.getParameter("soSao"));
                String noiDung = request.getParameter("noiDung");
                dao.insertDanhGia(idNguoiDung, idDonHang, idBienThe, soSao, noiDung);
                response.sendRedirect(request.getContextPath() + "/don-hang?action=detail&id=" + idDonHang);
                return;
            }

            if ("reply".equals(action)) {
                if (!SessionUtil.isStaffOrAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                int idDanhGia = Integer.parseInt(request.getParameter("idDanhGia"));
                dao.updateTraLoi(idDanhGia, request.getParameter("traLoi"));
                LogUtil.ghiLog(request, "Trả lời đánh giá", "danh_gia", idDanhGia);
                response.sendRedirect(request.getContextPath() + "/danh-gia?action=manage");
                return;
            }

            if ("updateStatus".equals(action)) {
                if (!SessionUtil.isStaffOrAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                int idDanhGia = Integer.parseInt(request.getParameter("idDanhGia"));
                int trangThai = Integer.parseInt(request.getParameter("trangThai"));
                dao.updateTrangThai(idDanhGia, trangThai);
                LogUtil.ghiLog(request, "Cập nhật trạng thái đánh giá", "danh_gia", idDanhGia);
                response.sendRedirect(request.getContextPath() + "/danh-gia?action=manage");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/trang-chu");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
