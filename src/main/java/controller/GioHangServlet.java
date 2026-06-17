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

        Integer idNguoiDung = SessionUtil.getIdNguoiDung(request);

        try {
            if (idNguoiDung == null && !action.equals("view")) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
                return;
            }

            switch (action) {
                case "add":
                    String idBienTheParam = request.getParameter("idBienThe");
                    String idSanPhamParam = request.getParameter("idSanPham");
                    String soLuongParam = request.getParameter("soLuong");

                    if (idBienTheParam != null && idSanPhamParam != null && soLuongParam != null) {
                        try {
                            int idBT = Integer.parseInt(idBienTheParam);
                            int sl = Integer.parseInt(soLuongParam);
                            gioDao.addItem(idNguoiDung, idBT, sl); 
                            response.getWriter().write("success");
                        } catch (NumberFormatException e) {
                            response.getWriter().write("error_format");
                        }
                    } else {
                        response.getWriter().write("error_missing_params");
                    }
                    break;

                case "remove":
                    gioDao.removeItem(idNguoiDung, Integer.parseInt(request.getParameter("idBienThe")));
                    response.sendRedirect("gio-hang?action=view");
                    break;

                case "view":
                default:
                    request.setAttribute("danhSachGioHang", (idNguoiDung != null) ? gioDao.getItemsByUserId(idNguoiDung) : null);
                    request.getRequestDispatcher("/user/gio-hang.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi xử lý giỏ hàng: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}