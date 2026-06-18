package controller;

import dao.SanPhamDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.NguoiDung;
import model.SanPham;
import util.SessionUtil;

@WebServlet(
    name = "AdminSanPhamServlet",
    urlPatterns = {"/san-pham-ad"}
)
public class AdminSanPhamServlet extends HttpServlet {

    private final SanPhamDAO spDAO = new SanPhamDAO();

    private boolean isAdmin(HttpServletRequest req) {
        NguoiDung user = (NguoiDung) req.getSession().getAttribute("user");
        return user != null && user.getIdVaiTro() == 1;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req)) {
            res.sendRedirect(req.getContextPath() + "/TrangChuServlet");
            return;
        }

        String action = req.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        try {
            switch (action) {

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

                case "add": {
                    req.getRequestDispatcher("/admin/san-pham/them-san-pham.jsp")
                       .forward(req, res);
                    return;
                }

                case "edit": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("sanPham", 
                            spDAO.getSanPhamById(id));
                    req.getRequestDispatcher(
                            "/admin/san-pham/sua-san-pham.jsp")
                       .forward(req, res);
                    return;
                }

                case "delete": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    spDAO.deleteSanPham(id);
                    res.sendRedirect(req.getContextPath() + "/admin/san-pham");
                    return;
                }

                default: {
                    res.sendRedirect(req.getContextPath() + "/admin/san-pham");
                    return;
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req)) {
            res.sendRedirect(req.getContextPath() + "/TrangChuServlet");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {

                case "add": {
                    SanPham sp = new SanPham();

                    sp.setTenSanPham(req.getParameter("ten_san_pham"));
                    sp.setMoTa(req.getParameter("mo_ta"));
                    sp.setUrlAnh(req.getParameter("url_anh"));
                    sp.setNhaSanXuat(req.getParameter("nha_san_xuat"));
                    sp.setGiaCoBan(Double.parseDouble(req.getParameter("gia_co_ban")));
                    sp.setTrangThai(Integer.parseInt(req.getParameter("trang_thai")));

                    spDAO.addSanPham(sp);

                    res.sendRedirect(req.getContextPath() + "/admin/san-pham");
                    return;
                }

                case "update": {
                    SanPham sp = new SanPham();

                    sp.setIdSanPham(Integer.parseInt(req.getParameter("id_san_pham")));
                    sp.setTenSanPham(req.getParameter("ten_san_pham"));
                    sp.setMoTa(req.getParameter("mo_ta"));
                    sp.setUrlAnh(req.getParameter("url_anh"));
                    sp.setNhaSanXuat(req.getParameter("nha_san_xuat"));
                    sp.setGiaCoBan(Double.parseDouble(req.getParameter("gia_co_ban")));
                    sp.setTrangThai(Integer.parseInt(req.getParameter("trang_thai")));

                    spDAO.updateSanPham(sp);

                    res.sendRedirect(req.getContextPath() + "/admin/san-pham");
                    return;
                }

                case "delete": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    spDAO.deleteSanPham(id);

                    res.sendRedirect(req.getContextPath() + "/admin/san-pham");
                    return;
                }

                default: {
                    res.sendRedirect(req.getContextPath() + "/admin/san-pham");
                    return;
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}