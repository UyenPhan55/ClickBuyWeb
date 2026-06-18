package controller;

import dao.BaoHanhDAO;
import dao.DonHangDAO;
import dao.KhieuNaiDAO;
import dao.NguoiDungDAO;
import dao.SanPhamDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import java.time.LocalDate;
import java.time.ZoneId;

import java.util.List;
import model.BaoHanh;
import model.DonHang;
import model.KhieuNai;

@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {


private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
private final DonHangDAO donHangDAO = new DonHangDAO();
private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();

private final KhieuNaiDAO khieuNaiDAO = new KhieuNaiDAO();
private final BaoHanhDAO baoHanhDAO = new BaoHanhDAO();

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

        List<DonHang> allOrders = donHangDAO.getAllOrders();
        List<KhieuNai> allKhieuNai = khieuNaiDAO.getAllKhieuNai();
        List<BaoHanh> allBaoHanh = baoHanhDAO.getAllBaoHanh();

        req.setAttribute("totalProducts", sanPhamDAO.getAllSanPham().size());

        req.setAttribute("totalOrders", donHangDAO.getAllOrders().size());
        req.setAttribute("totalUsers", nguoiDungDAO.getAll().size());

        long pendingCount = allKhieuNai.stream()
            .filter(kn -> "CHO_XU_LY".equals(kn.getTrangThai()))
            .count();
        req.setAttribute("khieuNaiCho", pendingCount);
        req.setAttribute("pendingComplaintsCount", pendingCount);

        long processingCount = allBaoHanh.stream()
            .filter(bh -> "DANG_XU_LY".equals(bh.getTrangThai()))
            .count();
        req.setAttribute("baoHanhCho", processingCount);
        req.setAttribute("processingWarrantyCount", processingCount);

        LocalDate today = LocalDate.now(ZoneId.of("Asia/Ho_Chi_Minh"));
        long todayCount = allOrders.stream()
            .filter(dh -> dh.getNgayDat() != null
                && dh.getNgayDat().toInstant().atZone(ZoneId.of("Asia/Ho_Chi_Minh")).toLocalDate().equals(today))
            .count();
        req.setAttribute("donHangMoi", todayCount);

        long choXacNhan = allOrders.stream()
            .filter(dh -> "CHO_XAC_NHAN".equals(dh.getTrangThai()))
            .count();
        req.setAttribute("donHangChoXacNhan", choXacNhan);

        req.setAttribute("danhSachDonHang", allOrders);

        req.setAttribute("totalOrders", allOrders.size());
        req.setAttribute("totalUsers", nguoiDungDAO.getAll().size());
        req.setAttribute("pendingOrdersCount", allOrders.stream()
                .filter(dh -> "CHO_XAC_NHAN".equals(dh.getTrangThai()))
                .count());
        req.setAttribute("pendingComplaintsCount", allKhieuNai.stream()
                .filter(kn -> "CHO_XU_LY".equals(kn.getTrangThai()))
                .count());
        req.setAttribute("processingWarrantyCount", allBaoHanh.stream()
                .filter(bh -> "DANG_XU_LY".equals(bh.getTrangThai()))
                .count());

        req.setAttribute("recentOrders", allOrders);
        req.setAttribute("listKhieuNai", allKhieuNai);

        req.getRequestDispatcher("/staff/dashboard.jsp").forward(req, res);
    } catch (SQLException e) {
        throw new ServletException(e);
    }
}


}
