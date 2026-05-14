package controller;

import dao.SanPhamDAO;
import dao.DonHangDAO;
import dao.NguoiDungDAO;
import dao.KhieuNaiDAO; 
import dao.BaoHanhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;          
import model.KhieuNai;         
import model.BaoHanh;          

@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {

    private final SanPhamDAO   sanPhamDAO   = new SanPhamDAO();
    private final DonHangDAO   donHangDAO   = new DonHangDAO();
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final KhieuNaiDAO  khieuNaiDAO  = new KhieuNaiDAO(); 
    private final BaoHanhDAO   baoHanhDAO   = new BaoHanhDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            model.NguoiDung user = (model.NguoiDung) req.getSession().getAttribute("user");
            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
                return;
            }
            if (user.getIdVaiTro() != 1 && user.getIdVaiTro() != 2) {
                res.sendRedirect(req.getContextPath() + "/TrangChuServlet");
                return;
            }

            req.setAttribute("totalProducts", sanPhamDAO.getAllSanPham().size());
            req.setAttribute("totalOrders",   donHangDAO.getAllOrders().size());
            req.setAttribute("totalUsers",    nguoiDungDAO.getAll().size());
            // 2. Xử lý Khiếu nại: Lấy toàn bộ rồi lọc theo trạng thái 'CHO_XU_LY'
            List<KhieuNai> allKhieuNai = khieuNaiDAO.getAllKhieuNai(); // Dùng hàm có sẵn trong DAO
            long pendingCount = allKhieuNai.stream()
                .filter(kn -> "CHO_XU_LY".equals(kn.getTrangThai()))
                .count();
            req.setAttribute("pendingComplaintsCount", pendingCount);

            // 3. Xử lý Bảo hành: Lấy toàn bộ rồi lọc theo trạng thái 'Đang xử lý'
            List<BaoHanh> allBaoHanh = baoHanhDAO.getAllBaoHanh(); // Dùng hàm có sẵn trong DAO
            long processingCount = allBaoHanh.stream()
                .filter(bh -> "Đang xử lý".equals(bh.getTrangThai()))
                .count();
            req.setAttribute("processingWarrantyCount", processingCount);

            // 4. Đổ danh sách ra các bảng (nếu Dashboard có dùng)
            req.setAttribute("recentOrders", donHangDAO.getAllOrders());
            req.setAttribute("listKhieuNai", allKhieuNai);
            req.getRequestDispatcher("/staff/dashboard.jsp").forward(req, res);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}