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

@WebServlet(urlPatterns = {"/danh-sach-san-pham"})
public class SanPhamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Cài đặt tiếng Việt để tránh lỗi font nếu có
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // 1. Gọi DAO để lấy danh sách sản phẩm từ Database
            SanPhamDAO dao = new SanPhamDAO();
            List<SanPham> list = dao.getAllSanPham();

            // 2. Đẩy danh sách này lên request với tên "listP"
            request.setAttribute("listP", list);

            // 3. Chuyển hướng sang trang JSP (nằm trong thư mục user) để hiển thị
            request.getRequestDispatcher("user/danh-sach-san-pham.jsp").forward(request, response);
            
        } catch (ServletException | IOException e) {
        }
    }
}