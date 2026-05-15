package controller;

import dao.SanPhamDAO;
import dao.BienTheSanPhamDAO;
import model.SanPham;
import model.BienTheSanPham; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.SanPhamTrongGioDAO;
import util.SessionUtil;

@WebServlet(name = "SanPhamServlet", urlPatterns = {"/san-pham"})
public class SanPhamServlet extends HttpServlet {

    private final SanPhamDAO spDAO = new SanPhamDAO();
    private final BienTheSanPhamDAO btDAO = new BienTheSanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "danh-sach";

        try {
            switch (action) {

                // ===== USER — trang danh sách sản phẩm =====            
                case "danh-sach":

                    req.setAttribute("listSP", spDAO.getAllSanPham());

                    SanPhamTrongGioDAO gioDAO = new SanPhamTrongGioDAO();

                    Integer idNguoiDung = SessionUtil.getIdNguoiDung(req);

                    int soLuongGio = 0;

                    if (idNguoiDung != null) {
                    soLuongGio = gioDAO.countItems(idNguoiDung);
                    }

                    req.setAttribute("soLuongGio", soLuongGio);

                    req.getRequestDispatcher("/user/danh-sach-san-pham.jsp")
                    .forward(req, res);

                // ===== USER — chi tiết sản phẩm =====
                case "chi-tiet":
                    int id = Integer.parseInt(req.getParameter("id"));
                    // Lấy thông tin sản phẩm chính
                    req.setAttribute("detail", spDAO.getSanPhamById(id));
                    // SỬA TẠI ĐÂY: Gọi phương thức lấy danh sách biến thể
                    List<BienTheSanPham> variants = btDAO.getBienTheBySanPhamId(id);
                    req.setAttribute("variants", variants);
                    
                    req.getRequestDispatcher("/user/chi-tiet-san-pham.jsp")
                       .forward(req, res);
                    break;

                // ===== STAFF/ADMIN — danh sách sản phẩm =====
                case "list":
                    req.setAttribute("listSanPham", spDAO.getAllSanPham());
                    req.getRequestDispatcher("/staff/san-pham/danh-sach-san-pham.jsp")
                       .forward(req, res);
                    break;

                // ===== ADMIN — form thêm sản phẩm =====
                case "add":
                    req.getRequestDispatcher("/staff/san-pham/them-san-pham.jsp")
                       .forward(req, res);
                    break;

                // ===== ADMIN — form sửa sản phẩm =====
                case "edit":
                    int idEdit = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("sanPham", spDAO.getSanPhamById(idEdit));
                    req.getRequestDispatcher("/staff/san-pham/sua-san-pham.jsp")
                       .forward(req, res);
                    break;

                // ===== ADMIN — xóa mềm sản phẩm =====
                case "delete":
                    int idXoa = Integer.parseInt(req.getParameter("id"));
                    spDAO.deleteSanPham(idXoa);
                    res.sendRedirect(req.getContextPath() + "/SanPhamServlet?action=list");
                    break;

                // ===== USER — tìm kiếm =====
                case "search":
                    String keyword = req.getParameter("keyword");
                    req.setAttribute("listSP", spDAO.searchSanPhamByName(keyword));
                    req.setAttribute("keyword", keyword);
                    req.getRequestDispatcher("/user/danh-sach-san-pham.jsp")
                       .forward(req, res);
                    break;

                default:
                    req.setAttribute("listSP", spDAO.getAllSanPham());
                    req.getRequestDispatcher("/user/danh-sach-san-pham.jsp")
                       .forward(req, res);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/user/danh-sach-san-pham.jsp")
               .forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {

                // ===== ADMIN — thêm sản phẩm =====
                case "add":
                    SanPham spAdd = new SanPham();
                    spAdd.setTenSanPham(req.getParameter("ten_san_pham"));
                    spAdd.setMoTa(req.getParameter("mo_ta"));
                    spAdd.setUrlAnh(req.getParameter("url_anh"));
                    spAdd.setNhaSanXuat(req.getParameter("nha_san_xuat"));
                    spAdd.setGiaCoBan(Double.parseDouble(req.getParameter("gia_co_ban")));
                    spAdd.setTrangThai(Integer.parseInt(req.getParameter("trang_thai")));
                    spDAO.addSanPham(spAdd);
                    res.sendRedirect(req.getContextPath() + "/SanPhamServlet?action=list");
                    break;

                // ===== ADMIN — sửa sản phẩm =====
                case "update":
                    SanPham spSua = new SanPham();
                    spSua.setIdSanPham(Integer.parseInt(req.getParameter("id_san_pham")));
                    spSua.setTenSanPham(req.getParameter("ten_san_pham"));
                    spSua.setMoTa(req.getParameter("mo_ta"));
                    spSua.setUrlAnh(req.getParameter("url_anh"));
                    spSua.setNhaSanXuat(req.getParameter("nha_san_xuat"));
                    spSua.setGiaCoBan(Double.parseDouble(req.getParameter("gia_co_ban")));
                    spSua.setTrangThai(Integer.parseInt(req.getParameter("trang_thai")));
                    spDAO.updateSanPham(spSua);
                    res.sendRedirect(req.getContextPath() + "/SanPhamServlet?action=list");
                    break;

                default:
                    doGet(req, res);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/staff/san-pham/danh-sach-san-pham.jsp")
               .forward(req, res);
        }
    }
}
