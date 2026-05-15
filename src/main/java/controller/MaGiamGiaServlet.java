package controller;

import dao.MaGiamGiaDAO;
import model.MaGiamGia;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MaGiamGiaServlet", urlPatterns = {"/ma-giam-gia"})
public class MaGiamGiaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy hành động người dùng muốn thực hiện (mặc định là xem danh sách)
        String action = request.getParameter("action");
        if (action == null) { 
            action = "danh-sach"; 
        }
        
        MaGiamGiaDAO mggDAO = new MaGiamGiaDAO();
        
        try {
            switch (action) {
                case "danh-sach":
                    // Lấy danh sách từ Database
                    List<MaGiamGia> list = mggDAO.getAll(); 
                    request.setAttribute("listMGG", list);
                    
                    // Chuyển dữ liệu sang trang JSP để hiển thị
                    // Lưu ý: Đổi lại đường dẫn "/admin/ma-giam-gia.jsp" cho khớp với thư mục thật của nhóm bạn nhé
                    request.getRequestDispatcher("/admin/ma-giam-gia.jsp").forward(request, response);
                    break;
                    
                case "xoa":
                    // Lấy ID cần xóa từ URL (ví dụ: ma-giam-gia?action=xoa&id=1)
                    int idXoa = Integer.parseInt(request.getParameter("id"));
                    mggDAO.deleteMaGiamGia(idXoa);
                    
                    // Xóa xong thì tự động quay lại trang danh sách
                    response.sendRedirect("ma-giam-gia?action=danh-sach");
                    break;
                    
                default:
                    response.sendRedirect("ma-giam-gia?action=danh-sach");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hàm doPost dùng khi bạn làm form có nút "Submit" (ví dụ: Thêm mới mã giảm giá)
        // Set tiếng Việt cho request
        request.setCharacterEncoding("UTF-8");
        
        // Tạm thời mình để trống, khi nào bạn thiết kế xong form Thêm mã giảm giá trên file .jsp 
        // thì mình sẽ viết code nhận dữ liệu (request.getParameter) vào đây nhé.
    }
}
