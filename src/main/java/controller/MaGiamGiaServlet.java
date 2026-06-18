package controller;

import dao.MaGiamGiaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.MaGiamGia;
import util.SessionUtil;

@WebServlet(name = "MaGiamGiaServlet", urlPatterns = {"/ma-giam-gia", "/MaGiamGiaServlet"})
public class MaGiamGiaServlet extends HttpServlet {

    private final MaGiamGiaDAO mggDAO = new MaGiamGiaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
            return;
        }

        try {
            switch (action) {
                case "danh-sach":
                case "list":
                    if (!SessionUtil.isStaffOrAdmin(request)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }

                    List<MaGiamGia> list = mggDAO.getAll();
<<<<<<< HEAD
                    request.setAttribute("danhSachMaGiamGia", list);

                    request.getRequestDispatcher("/staff/ma-giam-gia/danh-sach-ma-giam-gia.jsp")
                           .forward(request, response);
=======
                    request.setAttribute("listMGG", list);
                    request.setAttribute("danhSachMaGiamGia", list);
                    request.getRequestDispatcher(SessionUtil.isAdmin(request)
                            ? "/admin/ma-giam-gia.jsp"
                            : "/staff/ma-giam-gia/danh-sach-ma-giam-gia.jsp")
                            .forward(request, response);
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
                    break;

                case "xoa":
                    if (!SessionUtil.isAdmin(request)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    }
                    mggDAO.deleteMaGiamGia(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/MaGiamGiaServlet?action=list");
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/MaGiamGiaServlet?action=list");
                    break;
            }
        } catch (Exception e) {
<<<<<<< HEAD
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/staff/ma-giam-gia/danh-sach-ma-giam-gia.jsp")
                   .forward(request, response);
=======
            request.setAttribute("error", "Co loi xay ra: " + e.getMessage());
            request.getRequestDispatcher(SessionUtil.isAdmin(request)
                    ? "/admin/ma-giam-gia.jsp"
                    : "/staff/ma-giam-gia/danh-sach-ma-giam-gia.jsp")
                    .forward(request, response);
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String code = request.getParameter("voucherCode");
        MaGiamGia mgg = mggDAO.getMaGiamGiaByCode(code);
        HttpSession session = request.getSession();

        if (mgg != null) {
            session.setAttribute("discount", mgg);
<<<<<<< HEAD

            // Áp mã thành công thì quay lại trang thanh toán
            response.sendRedirect(request.getContextPath() + "/don-hang?action=checkout&status=success");
        } else {
            session.setAttribute("voucherMsg", "Mã giảm giá không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/don-hang?action=checkout&status=invalid");
=======
            response.sendRedirect(request.getContextPath() + "/GioHangServlet?status=success");
        } else {
            session.setAttribute("voucherMsg", "Ma giam gia khong hop le!");
            response.sendRedirect(request.getContextPath() + "/GioHangServlet?status=invalid");
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
        }
    }
}
