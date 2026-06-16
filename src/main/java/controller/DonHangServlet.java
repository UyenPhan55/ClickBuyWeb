package controller;

import model.DonHang;
import dao.DonHangDAO;
import dao.SanPhamTrongGioDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import util.SessionUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/DonHangServlet", "/don-hang"})
public class DonHangServlet extends HttpServlet {
private final DonHangDAO donHangDAO = new DonHangDAO();
private final SanPhamTrongGioDAO gioHangDAO = new SanPhamTrongGioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "history";
        try {
            Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);
            if (idNguoiDung == null) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
                return;
            }
            switch (action) {
                case "checkout":
                    request.setAttribute("danhSachGioHang", gioHangDAO.getItemsByUserId(idNguoiDung));
                    request.getRequestDispatcher("/user/thanh-toan.jsp").forward(request, response);
                    break;
                case "success":
                    request.getRequestDispatcher("/user/dat-hang-thanh-cong.jsp").forward(request, response);
                    break;
                case "detail":
                    int idDetail = Integer.parseInt(request.getParameter("id"));
                    DonHang donHang;
                    if (SessionUtil.isStaffOrAdmin(request)) {
                        donHang = donHangDAO.getOrderById(idDetail);
                    } else {
                        donHang = donHangDAO.getOrderByIdAndUser(idDetail, idNguoiDung);
                    }
                    request.setAttribute("donHang", donHang);
                    request.setAttribute("order", donHang);
                    request.setAttribute("chiTietDonHang", donHangDAO.getOrderItems(idDetail));
                    request.getRequestDispatcher(SessionUtil.isStaffOrAdmin(request) ? "/staff/don-hang/chi-tiet-don-hang.jsp" : "/user/chi-tiet-don-hang.jsp").forward(request, response);
                    break;
                    
                case "staff-list":
                    if (!SessionUtil.isStaffOrAdmin(request)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    request.setAttribute("danhSachDonHang", donHangDAO.getAllOrders());
                    request.getRequestDispatcher("/staff/don-hang/danh-sach-don-hang.jsp").forward(request, response);
                    break;
                case "cancel":
                    int idCancel = Integer.parseInt(request.getParameter("id"));
                    donHangDAO.cancelOrderByUser(idCancel, idNguoiDung, request.getRemoteAddr());
                    response.sendRedirect(request.getContextPath() + "/don-hang?action=history");
                    break;
                case "history":
                default:
                    request.setAttribute("danhSachDonHang", donHangDAO.getOrdersByUser(idNguoiDung));
                    request.getRequestDispatcher("/user/lich-su-don-hang.jsp").forward(request, response);
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
            Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);
            if (idNguoiDung == null) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
                return;
            }
            if ("place".equals(action)) {
                String diaChi = request.getParameter("diaChi");
                String sdtNguoiNhan = request.getParameter("sdtNguoiNhan");
                String voucherParam = request.getParameter("idVoucher");
                Integer idVoucher = (voucherParam == null || voucherParam.trim().isEmpty()) ? null : Integer.parseInt(voucherParam);
                int idDonHang = donHangDAO.placeOrder(idNguoiDung, diaChi, sdtNguoiNhan, idVoucher, request.getRemoteAddr());
                response.sendRedirect(request.getContextPath() + "/don-hang?action=success&id=" + idDonHang);
                return;
            }
            if ("updateStatus".equals(action)) {
                if (!SessionUtil.isStaffOrAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                int idDonHang = Integer.parseInt(request.getParameter("idDonHang"));
                String trangThai = request.getParameter("trangThai");
                donHangDAO.updateStatus(idDonHang, trangThai, idNguoiDung, request.getRemoteAddr());
                response.sendRedirect(request.getContextPath() + "/DonHangServlet?action=staff-list");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/don-hang?action=history");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
