<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="sidebar">
<<<<<<< HEAD

    <a href="${pageContext.request.contextPath}/StaffServlet" 
       class="sidebar-brand">
        <div class="sb-logo">S</div>
        <div>
            <div class="sb-brand-name">CLICKBUY</div>
            <span class="sb-brand-role">STAFF</span>
        </div>
    </a>

    <ul class="sidebar-nav">
        <div class="nav-section">Tổng quan</div>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/StaffServlet" 
               class="nav-link ${empty param.action ? 'active' : ''}">
                <i class="fa-solid fa-chart-line"></i> Dashboard
            </a>
        </li>

        <div class="nav-section">Quản lý</div>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/san-pham?action=list"
               class="nav-link ${param.action == 'list' ? 'active' : ''}">
                <i class="fa-solid fa-box"></i> Sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
               class="nav-link ${(param.action == 'staff-list' || requestScope.activeAction == 'staff-list') ? 'active' : ''}">
                <i class="fa-solid fa-cart-shopping"></i> Đơn hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=list"
               class="nav-link ${param.action == 'list-voucher' || param.action == 'list' ? 'active' : ''}">
                <i class="fa-solid fa-tag"></i> Mã giảm giá
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/BaoHanhServlet?action=list"
               class="nav-link ${param.action == 'list-warranty' || param.action == 'list' ? 'active' : ''}">
                <i class="fa-solid fa-shield"></i> Bảo hành
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list"
               class="nav-link ${param.action == 'staff-list' ? 'active' : ''}">
                <i class="fa-solid fa-triangle-exclamation"></i> Khiếu nại
            </a>
        </li>

        <div class="nav-section">Tài khoản</div>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/AuthServlet?action=logout"
               class="nav-link">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </li>
=======
    <a href="${pageContext.request.contextPath}/StaffServlet" class="sidebar-brand">
        <div class="sb-logo"><i class="bi bi-headset"></i></div>
        <div>
            <div class="sb-brand-name">CLICKBUY</div>
            <span class="sb-brand-role">STAFF</span>
        </div>
    </a>

    <div class="sidebar-user">
        <div class="sb-avatar">
            ${not empty sessionScope.user ? sessionScope.user.tenDayDu.charAt(0) : 'S'}
        </div>
        <div>
            <div class="sb-user-name">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu : 'Nhân viên'}
            </div>
            <span class="sb-user-badge">Nhân viên</span>
        </div>
    </div>
            <a href="../../java/dao/SanPhamDAO.java"></a>
    <ul class="sidebar-nav">
        <li class="nav-section">Tổng quan</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/StaffServlet"
               class="nav-link ${activeMenu == 'dashboard' ? 'active' : ''}">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>

        <li class="nav-section">Nghiệp vụ</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
               class="nav-link ${activeMenu == 'orders' ? 'active' : ''}">
                <i class="bi bi-receipt-cutoff"></i> Đơn hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list"
               class="nav-link ${activeMenu == 'complaints' ? 'active' : ''}">
                <i class="bi bi-chat-square-text"></i> Khiếu nại
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/BaoHanhServlet?action=list"
               class="nav-link ${activeMenu == 'warranty' ? 'active' : ''}">
                <i class="bi bi-shield-check"></i> Bảo hành
            </a>
        </li>

        <li class="nav-section">Tra cứu</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/san-pham?action=list"
               class="nav-link ${activeMenu == 'products' ? 'active' : ''}">
                <i class="bi bi-phone"></i> Sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/NguoiDungServlet"
               class="nav-link ${activeMenu == 'users' ? 'active' : ''}">
                <i class="bi bi-people"></i> Người dùng
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=list"
               class="nav-link ${activeMenu == 'vouchers' ? 'active' : ''}">
                <i class="bi bi-tags"></i> Mã giảm giá
            </a>
        </li>

        <li class="nav-section">Tài khoản</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/AuthServlet?action=logout"
               class="nav-link">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
        </li>
>>>>>>> 14a66ce (Hoan thien giao dien admin va staff)
    </ul>
</div>
