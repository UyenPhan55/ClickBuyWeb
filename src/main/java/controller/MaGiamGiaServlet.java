package controller;

import dao.MaGiamGiaDAO;
import model.MaGiamGia;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "MaGiamGiaServlet", urlPatterns = {"/check-voucher"})
public class MaGiamGiaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("voucherCode");
        MaGiamGiaDAO dao = new MaGiamGiaDAO();
        
        // Gọi DAO để kiểm tra mã trong Database
        MaGiamGia mgg = dao.getMaGiamGiaByCode(code);
        
        HttpSession session = request.getSession();
        if (mgg != null) {
            // Nếu mã hợp lệ, lưu vào session để Người 5 tính tiền đơn hàng
            session.setAttribute("discount", mgg);
            response.sendRedirect("user/gio-hang.jsp?status=success");
        } else {
            response.sendRedirect("user/gio-hang.jsp?status=invalid");
        }
    }
}
