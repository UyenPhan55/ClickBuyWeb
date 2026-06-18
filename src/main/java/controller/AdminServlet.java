package controller;

import dao.BaoHanhDAO;
import dao.DonHangDAO;
import dao.KhieuNaiDAO;
import dao.LichSuHoatDongDAO;
import dao.MaGiamGiaDAO;
import dao.NguoiDungDAO;
import dao.SanPhamDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.DonHang;
import model.LichSuHoatDong;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final DonHangDAO donHangDAO = new DonHangDAO();
    private final MaGiamGiaDAO maGiamGiaDAO = new MaGiamGiaDAO();
    private final BaoHanhDAO baoHanhDAO = new BaoHanhDAO();
    private final KhieuNaiDAO khieuNaiDAO = new KhieuNaiDAO();
    private final LichSuHoatDongDAO lichSuHoatDongDAO = new LichSuHoatDongDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            model.NguoiDung user = (model.NguoiDung) req.getSession().getAttribute("user");
            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
                return;
            }
            if (user.getIdVaiTro() != 1) {
                res.sendRedirect(req.getContextPath() + "/TrangChuServlet");
                return;
            }

            List<DonHang> allOrders = donHangDAO.getAllOrders();
            List<LichSuHoatDong> allLogs = lichSuHoatDongDAO.getAllLogs();

            req.setAttribute("totalProducts", sanPhamDAO.getAllSanPham().size());
            req.setAttribute("totalUsers", nguoiDungDAO.getAll().size());
            req.setAttribute("totalOrders", allOrders.size());
            req.setAttribute("totalVouchers", maGiamGiaDAO.getAll().size());
            req.setAttribute("totalWarranties", baoHanhDAO.getAllBaoHanh().size());
            req.setAttribute("totalComplaints", khieuNaiDAO.getAllKhieuNai().size());
            req.setAttribute("totalLogs", allLogs.size());
            req.setAttribute("recentOrders", allOrders);
            req.setAttribute("recentLogs", allLogs);

            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
