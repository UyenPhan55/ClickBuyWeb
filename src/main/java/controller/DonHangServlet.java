package controller;

import dao.DonHangDAO;
import dao.SanPhamTrongGioDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import util.SessionUtil;
import jakarta.servlet.annotation.WebServlet; // Thêm import này

@WebServlet("/DonHangServlet") 
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
                    // Đừng quên forward sang đúng thư mục của bà
                    request.getRequestDispatcher("/user/thanh-toan.jsp").forward(request, response);
                    break;

                case "success":
                    request.getRequestDispatcher("/user/dat-hang-thanh-cong.jsp").forward(request, response);
                    break;

                case "detail":
                    int idDetail = Integer.parseInt(request.getParameter("id"));
                    if (SessionUtil.isStaffOrAdmin(request)) {
                        request.setAttribute("donHang", donHangDAO.getOrderById(idDetail));
                    } else {
                        request.setAttribute("donHang", donHangDAO.getOrderByIdAndUser(idDetail, idNguoiDung));
                    }
                    request.setAttribute("chiTietDonHang", donHangDAO.getOrderItems(idDetail));
                    request.getRequestDispatcher(SessionUtil.isStaffOrAdmin(request) ? "/staff/don-hang/chi-tiet-don-hang.jsp" : "/user/chi-tiet-don-hang.jsp").forward(request, response);
                    break;

                case "list":
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
                    // Sửa lại redirect cho khớp tên Servlet
                    response.sendRedirect(request.getContextPath() + "/DonHangServlet?action=history");
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
                // Sửa lại redirect
                response.sendRedirect(request.getContextPath() + "/DonHangServlet?action=success&id=" + idDonHang);
                return;
            }
            // ... (các phần updateStatus giữ nguyên nhưng sửa redirect tương tự)
            response.sendRedirect(request.getContextPath() + "/DonHangServlet?action=history");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
