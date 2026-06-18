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
import util.LogUtil;
import util.SessionUtil;

@WebServlet(name = "SanPhamServlet", urlPatterns = {"/san-pham", "/SanPhamServlet"})
public class SanPhamServlet extends HttpServlet {

    private final SanPhamDAO spDAO = new SanPhamDAO();
    private final BienTheSanPhamDAO btDAO = new BienTheSanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

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
                    break;

                // ===== USER — chi tiết sản phẩm =====
                    break;

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
                    if (!SessionUtil.isStaffOrAdmin(req)) {
                        res.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }

                    String keywordList = req.getParameter("keyword");

                    req.setAttribute("listSanPham",
                            keywordList == null || keywordList.trim().isEmpty()
                            ? spDAO.getAllSanPham()
                            : spDAO.searchSanPhamByName(keywordList.trim()));

                    req.setAttribute("keyword", keywordList);

                    req.getRequestDispatcher(SessionUtil.isAdmin(req)
                            ? "/admin/san-pham/danh-sach-san-pham.jsp"
                            : "/staff/san-pham/danh-sach-san-pham.jsp")
                            .forward(req, res);
                    break;

                // ===== ADMIN — form thêm sản phẩm =====
                case "add":
<<<<<<< HEAD
=======
                    if (!SessionUtil.isAdmin(req)) {
                        res.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
                    req.getRequestDispatcher("/admin/san-pham/them-san-pham.jsp")
                       .forward(req, res);
                    break;

                // ===== ADMIN — form sửa sản phẩm =====
                case "edit":
                    if (!SessionUtil.isAdmin(req)) {
                        res.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    int idEdit = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("sanPham", spDAO.getSanPhamById(idEdit));
                    req.getRequestDispatcher("/admin/san-pham/sua-san-pham.jsp")
                       .forward(req, res);
                    break;

                // ===== ADMIN — xóa mềm sản phẩm =====
                case "delete":
<<<<<<< HEAD
                    int idXoa = Integer.parseInt(req.getParameter("id"));
                    spDAO.deleteSanPham(idXoa);
                    res.sendRedirect(req.getContextPath() + "/san-pham?action=list");
=======
                    res.sendRedirect(req.getContextPath() + "//san-pham?action=list");
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
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
            req.getRequestDispatcher(SessionUtil.isStaffOrAdmin(req)
                    ? (SessionUtil.isAdmin(req)
                            ? "/admin/san-pham/danh-sach-san-pham.jsp"
                            : "/staff/san-pham/danh-sach-san-pham.jsp")
                    : "/user/danh-sach-san-pham.jsp")
               .forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {

                // ===== ADMIN — thêm sản phẩm =====
                case "add":
                    if (!SessionUtil.isAdmin(req)) {
                        res.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    SanPham spAdd = new SanPham();
                    spAdd.setTenSanPham(req.getParameter("ten_san_pham"));
                    spAdd.setMoTa(req.getParameter("mo_ta"));
                    spAdd.setUrlAnh(req.getParameter("url_anh"));
                    spAdd.setNhaSanXuat(req.getParameter("nha_san_xuat"));
                    spAdd.setGiaCoBan(Double.parseDouble(req.getParameter("gia_co_ban")));
                    spAdd.setTrangThai(Integer.parseInt(req.getParameter("trang_thai")));
<<<<<<< HEAD
                    spDAO.addSanPham(spAdd);
=======
                    if (!spDAO.addSanPham(spAdd)) {
                        throw new Exception("Khong them duoc san pham");
                    }
                    LogUtil.ghiLog(req, "Them san pham", "san_pham", spAdd.getIdSanPham());
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
                    res.sendRedirect(req.getContextPath() + "/san-pham?action=list");
                    break;

                // ===== ADMIN — sửa sản phẩm =====
                case "update":
                    if (!SessionUtil.isAdmin(req)) {
                        res.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    SanPham spSua = new SanPham();
                    spSua.setIdSanPham(Integer.parseInt(req.getParameter("id_san_pham")));
                    spSua.setTenSanPham(req.getParameter("ten_san_pham"));
                    spSua.setMoTa(req.getParameter("mo_ta"));
                    spSua.setUrlAnh(req.getParameter("url_anh"));
                    spSua.setNhaSanXuat(req.getParameter("nha_san_xuat"));
                    spSua.setGiaCoBan(Double.parseDouble(req.getParameter("gia_co_ban")));
                    spSua.setTrangThai(Integer.parseInt(req.getParameter("trang_thai")));
<<<<<<< HEAD
                    spDAO.updateSanPham(spSua);
=======
                    if (!spDAO.updateSanPham(spSua)) {
                        throw new Exception("Khong cap nhat duoc san pham");
                    }
                    LogUtil.ghiLog(req, "Cap nhat san pham", "san_pham", spSua.getIdSanPham());
                    res.sendRedirect(req.getContextPath() + "/san-pham?action=list");
                    break;

                case "delete":
                    if (!SessionUtil.isAdmin(req)) {
                        res.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    int idXoa = Integer.parseInt(req.getParameter("id"));
                    if (!spDAO.deleteSanPham(idXoa)) {
                        throw new Exception("Khong xoa duoc san pham");
                    }
                    LogUtil.ghiLog(req, "Xoa san pham", "san_pham", idXoa);
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
                    res.sendRedirect(req.getContextPath() + "/san-pham?action=list");
                    break;

                default:
                    doGet(req, res);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            req.setAttribute("listSanPham", spDAO.getAllSanPham());
            req.getRequestDispatcher(SessionUtil.isAdmin(req)
                    ? "/admin/san-pham/danh-sach-san-pham.jsp"
                    : "/staff/san-pham/danh-sach-san-pham.jsp")
               .forward(req, res);
        }
    }
}
