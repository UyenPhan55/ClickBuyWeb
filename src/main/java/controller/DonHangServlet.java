package controller;

import dao.DonHangDAO;
import dao.SanPhamTrongGioDAO;
import dao.MaGiamGiaDAO; 
import model.MaGiamGia;
import model.SanPhamTrongGio;
import java.io.IOException;
import java.util.List;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import util.SessionUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/DonHangServlet")
public class DonHangServlet extends HttpServlet {
    private final DonHangDAO donHangDAO = new DonHangDAO();
    private final SanPhamTrongGioDAO gioHangDAO = new SanPhamTrongGioDAO();
    private final MaGiamGiaDAO maGiamGiaDAO = new MaGiamGiaDAO();

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
                    // 1. Lấy danh sách sản phẩm để hiện ở trang thanh toán
                    List<SanPhamTrongGio> listItems = gioHangDAO.getItemsByUserId(idNguoiDung);
                    request.setAttribute("danhSachGioHang", listItems);
                    
                    // 2. Tính tạm tính (Dùng BigDecimal cho chính xác giống DAO)
                    BigDecimal tempTotal = BigDecimal.ZERO;
                    for (SanPhamTrongGio item : listItems) {
                        tempTotal = tempTotal.add(item.getGiaBienThe().multiply(BigDecimal.valueOf(item.getSoLuong())));
                    }
                    request.setAttribute("tempTotal", tempTotal);

                    // 3. Đổ danh sách Voucher từ MySQL ra ô chọn (Dropdown)
                    List<MaGiamGia> listVouchers = maGiamGiaDAO.getAllVouchers(); 
                    request.setAttribute("danhSachVoucher", listVouchers);

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
                    response.sendRedirect(request.getContextPath() + "/DonHangServlet?action=history");
                    break;

                case "history":
                default:
                    request.setAttribute("danhSachDonHang", donHangDAO.getOrdersByUser(idNguoiDung));
                    request.getRequestDispatcher("/user/lich-su-don-hang.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra console để bà dễ debug
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
                
                // Lấy idVoucher từ ô Select (Dropdown) gửi lên
                String voucherParam = request.getParameter("idVoucher"); 
                Integer idVoucher = null;
                if (voucherParam != null && !voucherParam.trim().isEmpty()) {
                    idVoucher = Integer.parseInt(voucherParam);
                }
                
                // Gọi DAO đặt hàng
                int idDonHang = donHangDAO.placeOrder(idNguoiDung, diaChi, sdtNguoiNhan, idVoucher, request.getRemoteAddr());
                
                // Xóa mã giảm giá đã áp dụng trong Session để không bị tính cho đơn sau
                request.getSession().removeAttribute("discount");
                
                response.sendRedirect(request.getContextPath() + "/DonHangServlet?action=success&id=" + idDonHang);
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

            response.sendRedirect(request.getContextPath() + "/DonHangServlet?action=history");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
