package controller;

import dao.SanPhamDAO;
import dao.BienTheSanPhamDAO;
import model.SanPham;
import model.BienTheSanPham;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SanPhamServlet", urlPatterns = {"/san-pham"})
public class SanPhamServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        SanPhamDAO spDAO = new SanPhamDAO();
        BienTheSanPhamDAO btDAO = new BienTheSanPhamDAO();

        try {
            switch (action) {
                case "list":
                    // Lấy danh sách sản phẩm hiển thị ra trang chủ/danh sách
                    List<SanPham> list = spDAO.getAllSanPham();
                    request.setAttribute("listSP", list);
                    request.getRequestDispatcher("user/danh-sach-san-pham.jsp").forward(request, response);
                    break;
                case "detail":
                    // Xem chi tiết 1 sản phẩm và các biến thể của nó
                    int id = Integer.parseInt(request.getParameter("id"));
                    SanPham sp = spDAO.getSanPhamById(id);
                    List<BienTheSanPham> listBT = btDAO.getBienTheBySanPhamId(id);
                    request.setAttribute("detail", sp);
                    request.setAttribute("listBT", listBT);
                    request.getRequestDispatcher("user/chi-tiet-san-pham.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}