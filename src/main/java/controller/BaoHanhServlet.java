package controller;

import dao.BaoHanhDAO;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.BaoHanh;
import util.LogUtil;
import util.SessionUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/BaoHanhServlet") 
public class BaoHanhServlet extends HttpServlet {
    private final BaoHanhDAO dao = new BaoHanhDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "lookup";
        try {
            Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);

            switch (action) {
                case "list":
                    if (!SessionUtil.isStaffOrAdmin(request)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    request.setAttribute("danhSachBaoHanh", dao.getAllBaoHanh());
                    request.getRequestDispatcher("/staff/bao-hanh/danh-sach-bao-hanh.jsp").forward(request, response);
                    break;

                case "mine":
                    if (idNguoiDung == null) {
                        response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
                        return;
                    }
                    request.setAttribute("danhSachBaoHanh", dao.getBaoHanhByUser(idNguoiDung));
                    request.getRequestDispatcher("/user/tra-cuu-bao-hanh.jsp").forward(request, response);
                    break;

                case "lookup":
                default:
                    String code = request.getParameter("code");
                    if (code != null && !code.trim().isEmpty()) {
                        request.setAttribute("baoHanh", dao.getByCode(code.trim()));
                    }
                    request.getRequestDispatcher("/user/tra-cuu-bao-hanh.jsp").forward(request, response);
                    break;
            }
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
            if (!SessionUtil.isStaffOrAdmin(request)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            Integer idNhanVienSession = SessionUtil.getIdNguoiDung(request);

            if ("insert".equals(action)) {
                BaoHanh bh = new BaoHanh();
                bh.setIdDonHang(Integer.parseInt(request.getParameter("idDonHang")));
                bh.setIdBienThe(Integer.parseInt(request.getParameter("idBienThe")));
                bh.setIdNhanVien(idNhanVienSession);
                bh.setMaBaoHanhCode(request.getParameter("maBaoHanhCode"));
                bh.setNgayBatDau(Date.valueOf(request.getParameter("ngayBatDau")));
                bh.setNgayKetThuc(Date.valueOf(request.getParameter("ngayKetThuc")));
                bh.setTrangThai(request.getParameter("trangThai"));
                bh.setGhiChu(request.getParameter("ghiChu"));
                dao.insertBaoHanh(bh);
                LogUtil.ghiLog(request, "Thêm bảo hành", "bao_hanh", bh.getIdDonHang());
                response.sendRedirect(request.getContextPath() + "/bao-hanh?action=list");
                return;
            }

            if ("updateStatus".equals(action)) {
                int idBaoHanh = Integer.parseInt(request.getParameter("idBaoHanh"));
                String trangThai = request.getParameter("trangThai");
                String ghiChu = request.getParameter("ghiChu");
                dao.updateTrangThai(idBaoHanh, trangThai, idNhanVienSession, ghiChu);
                LogUtil.ghiLog(request, "Cập nhật bảo hành", "bao_hanh", idBaoHanh);
                response.sendRedirect(request.getContextPath() + "/bao-hanh?action=list");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/bao-hanh?action=list");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
