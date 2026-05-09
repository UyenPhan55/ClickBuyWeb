package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.NguoiDung;

// Chặn toàn bộ /staff/* — idVaiTro=1 (admin) và 2 (nhân viên) đều vào được
@WebFilter("/staff/*")
public class StaffFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        NguoiDung user = (NguoiDung) req.getSession().getAttribute("user");

        if (user != null && (user.getIdVaiTro() == 1 || user.getIdVaiTro() == 2)) {
            chain.doFilter(request, response); // Admin hoặc nhân viên → cho qua
        } else if (user != null) {
            // Đã đăng nhập nhưng không phải staff
            res.sendRedirect(req.getContextPath() + "/TrangChuServlet");
        } else {
            // Chưa đăng nhập
            res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
        }
    }

    @Override public void init(FilterConfig fc) throws ServletException {}
    @Override public void destroy() {}
}