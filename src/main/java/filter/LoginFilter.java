package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.NguoiDung;

// Chặn các URL cần đăng nhập — chưa đăng nhập thì về trang login
@WebFilter(urlPatterns = {
    "/GioHangServlet",
    "/DonHangServlet",
    "/DanhGiaServlet",
    "/KhieuNaiServlet",
    "/ThongBaoServlet",
    "/BaoHanhServlet"
})
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        NguoiDung user = (NguoiDung) req.getSession().getAttribute("user");

        if (user != null) {
            chain.doFilter(request, response); // Đã đăng nhập → cho qua
        } else {
            res.sendRedirect(req.getContextPath() + "/dang-nhap.jsp");
        }
    }

    @Override public void init(FilterConfig fc) throws ServletException {}
    @Override public void destroy() {}
}