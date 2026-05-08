package controller;

import dao.SanPhamDAO;
import model.SanPham;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// Khai báo đường dẫn URL
@WebServlet(urlPatterns = {"/danh-sach-san-pham"})
public class SanPhamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        SanPhamDAO dao = new SanPhamDAO();
        List<SanPham> list = dao.getAllSanPham();
        
        // Đẩy list này lên request với tên "listP"
        request.setAttribute("listP", list);
        
        // Chuyển hướng sang file JSP
        request.getRequestDispatcher("user/danh-sach-san-pham.jsp").forward(request, response);
    }
}