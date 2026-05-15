package controller;

import dao.SanPhamTrongGioDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import util.SessionUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/GioHangServlet", "/gio-hang"})
public class GioHangServlet extends HttpServlet {
    private final SanPhamTrongGioDAO gioDao = new SanPhamTrongGioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "view";

        try {
            Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);
            if (idNguoiDung == null) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
                return;
            }

            switch (action) {
                case "add":
                    int idBienTheAdd = Integer.parseInt(request.getParameter("idBienThe"));
                    int soLuongAdd = request.getParameter("soLuong") == null ? 1 : Integer.parseInt(request.getParameter("soLuong"));
                    gioDao.addItem(idNguoiDung, idBienTheAdd, soLuongAdd);
                    response.sendRedirect(request.getContextPath() + "/gio-hang?action=view");
                    break;

                case "remove":
                    int idBienTheRemove = Integer.parseInt(request.getParameter("idBienThe"));
                    gioDao.removeItem(idNguoiDung, idBienTheRemove);
                    response.sendRedirect(request.getContextPath() + "/gio-hang?action=view");
                    break;

                case "clear":
                    gioDao.clearCart(idNguoiDung);
                    response.sendRedirect(request.getContextPath() + "/gio-hang?action=view");
                    break;

                case "view":
                default:
                    request.setAttribute("danhSachGioHang", gioDao.getItemsByUserId(idNguoiDung));
                    request.getRequestDispatcher("/user/gio-hang.jsp").forward(request, response);
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

            if ("update".equals(action)) {
                int idBienThe = Integer.parseInt(request.getParameter("idBienThe"));
                int soLuong = Integer.parseInt(request.getParameter("soLuong"));
                gioDao.updateQuantity(idNguoiDung, idBienThe, soLuong);
            }
            response.sendRedirect(request.getContextPath() + "/gio-hang?action=view");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/loi.jsp").forward(request, response);
        }
    }
}
