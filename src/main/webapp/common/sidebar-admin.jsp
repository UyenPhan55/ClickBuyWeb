<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="sidebar">
    <a href="${pageContext.request.contextPath}/AdminServlet" class="sidebar-brand">
        <div class="sb-logo"><i class="bi bi-shield-lock"></i></div>
        <div>
            <div class="sb-brand-name">CLICKBUY</div>
            <span class="sb-brand-role">ADMIN</span>
        </div>
        
    </a>

    <div class="sidebar-user">
        <div class="sb-avatar">
            ${not empty sessionScope.user ? sessionScope.user.tenDayDu.charAt(0) : 'A'}
        </div>
        <div>
            <div class="sb-user-name">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu : 'Admin'}
            </div>
            <span class="sb-user-badge">Quản trị</span>
        </div>
    </div>

    <ul class="sidebar-nav">
        <li class="nav-section">Tổng quan</li>
        <li class="nav-item">
<<<<<<< HEAD
            <%--  Qua AdminServlet → AdminFilter chạy → check role --%>
            <a href="${pageContext.request.contextPath}/AdminServlet?action=dashboard" 
               class="nav-link active">
                <i class="fa-solid fa-chart-line"></i> Dashboard
=======
            <a href="${pageContext.request.contextPath}/AdminServlet"
               class="nav-link ${activeMenu == 'dashboard' ? 'active' : ''}">
                <i class="bi bi-graph-up-arrow"></i> Dashboard
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
            </a>
        </li>

        <li class="nav-section">Quản lý</li>
        <li class="nav-item">
<<<<<<< HEAD

            <a href="${pageContext.request.contextPath}/san-pham?action=list"
               class="nav-link">
                <i class="fa-solid fa-box"></i> Sản phẩm
=======
            <a href="${pageContext.request.contextPath}/san-pham-ad"
               class="nav-link ${activeMenu == 'products' ? 'active' : ''}">
                <i class="bi bi-box-seam"></i> Sản phẩm
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
               class="nav-link ${activeMenu == 'orders' ? 'active' : ''}">
                <i class="bi bi-cart3"></i> Đơn hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/NguoiDungServlet?action=list"
               class="nav-link ${activeMenu == 'users' ? 'active' : ''}">
                <i class="bi bi-people"></i> Tài khoản
            </a>
        </li>
        <li class="nav-item">
            <%-- đồng bộ--%>
            <a href="${pageContext.request.contextPath}/ma-giam-gia-ad"
               class="nav-link ${activeMenu == 'vouchers' ? 'active' : ''}">
                <i class="bi bi-tags"></i> Mã giảm giá
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/BaoHanhServlet?action=list"
               class="nav-link ${activeMenu == 'warranty' ? 'active' : ''}">
                <i class="bi bi-shield-check"></i> Bảo hành
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list"
               class="nav-link ${activeMenu == 'complaints' ? 'active' : ''}">
                <i class="bi bi-exclamation-triangle"></i> Khiếu nại
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/LichSuHoatDongServlet?action=list"
               class="nav-link ${activeMenu == 'logs' ? 'active' : ''}">
                <i class="bi bi-clock-history"></i> Lịch sử
            </a>
        </li>

        <li class="nav-section">Tài khoản</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/AuthServlet?action=logout"
               class="nav-link">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>
