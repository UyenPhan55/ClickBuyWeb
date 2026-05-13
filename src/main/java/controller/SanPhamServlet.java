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

@WebServlet(name = "SanPhamServlet", urlPatterns = {"/san-pham"})
public class SanPhamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) { action = "danh-sach"; }
        
        SanPhamDAO spDAO = new SanPhamDAO();
        
        try {
            switch (action) {
                case "danh-sach":
                    List<SanPham> list = spDAO.getAllSanPham();
                    request.setAttribute("listSP", list);
                    request.getRequestDispatcher("/user/danh-sach-san-pham.jsp").forward(request, response);
                    break;
                case "chi-tiet":
                    int id = Integer.parseInt(request.getParameter("id"));
                    SanPham sp = spDAO.getSanPhamById(id);
                    request.setAttribute("detail", sp);
                    request.getRequestDispatcher("/user/chi-tiet-san-pham.jsp").forward(request, response);
                    break;
                case "xoa":
                    int idXoa = Integer.parseInt(request.getParameter("id"));
                    spDAO.deleteSanPham(idXoa);
                    response.sendRedirect("san-pham?action=danh-sach");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}