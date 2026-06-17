package controller;

import dao.MaGiamGiaDAO;
import model.MaGiamGia;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MaGiamGiaServlet", urlPatterns = {"/ma-giam-gia", "/MaGiamGiaServlet"})
public class MaGiamGiaServlet extends HttpServlet {

    private final MaGiamGiaDAO mggDAO = new MaGiamGiaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy hành động người dùng muốn thực hiện
        // Nếu không truyền action thì mặc định là xem danh sách mã giảm giá
        String action = request.getParameter("action");
        if (action == null) {
            action = "danh-sach";
        }

        try {
            switch (action) {

                // ===== ADMIN/STAFF — xem danh sách mã giảm giá =====
                case "danh-sach":
                case "list":
                    // Lấy danh sách mã giảm giá từ Database thông qua DAO
                    List<MaGiamGia> list = mggDAO.getAll();
                    request.setAttribute("danhSachMaGiamGia", list);

                    request.getRequestDispatcher("/staff/ma-giam-gia/danh-sach-ma-giam-gia.jsp")
                           .forward(request, response);
                    break;

                // ===== ADMIN/STAFF — xóa mã giảm giá =====
                case "xoa":
                    // Lấy ID cần xóa từ URL
                    // Ví dụ: /ma-giam-gia?action=xoa&id=1
                    int idXoa = Integer.parseInt(request.getParameter("id"));
                    mggDAO.deleteMaGiamGia(idXoa);

                    // Xóa xong thì tự động quay lại trang danh sách
                    response.sendRedirect(request.getContextPath() + "/ma-giam-gia?action=danh-sach");
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/ma-giam-gia?action=danh-sach");
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/staff/ma-giam-gia/danh-sach-ma-giam-gia.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set tiếng Việt cho request để tránh lỗi font khi nhận dữ liệu từ form
        request.setCharacterEncoding("UTF-8");

        // ===== USER — áp dụng mã giảm giá từ giỏ hàng =====
        String code = request.getParameter("voucherCode");
        MaGiamGia mgg = mggDAO.getMaGiamGiaByCode(code);

        HttpSession session = request.getSession();

        if (mgg != null) {
            session.setAttribute("discount", mgg);

            // Áp mã thành công thì quay lại trang thanh toán
            response.sendRedirect(request.getContextPath() + "/don-hang?action=checkout&status=success");
        } else {
            session.setAttribute("voucherMsg", "Mã giảm giá không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/don-hang?action=checkout&status=invalid");
        }
    }
}