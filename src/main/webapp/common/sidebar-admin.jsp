<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="sidebar">

    <a href="${pageContext.request.contextPath}/AdminServlet?action=dashboard" 
       class="sidebar-brand">
        <div class="sb-logo">A</div>
        <div>
            <div class="sb-brand-name">CLICKBUY</div>
            <span class="sb-brand-role">ADMIN</span>
        </div>
    </a>

    <ul class="sidebar-nav">
        <div class="nav-section">Tổng quan</div>
        <li class="nav-item">
            <%--  Qua AdminServlet → AdminFilter chạy → check role --%>
            <a href="${pageContext.request.contextPath}/AdminServlet?action=dashboard" 
               class="nav-link active">
                <i class="fa-solid fa-chart-line"></i> Dashboard
            </a>
        </li>

        <div class="nav-section">Quản lý</div>
        <li class="nav-item">

            <a href="${pageContext.request.contextPath}/san-pham?action=list"
               class="nav-link">
                <i class="fa-solid fa-box"></i> Sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
               class="nav-link">
                <i class="fa-solid fa-cart-shopping"></i> Đơn hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/NguoiDungServlet?action=list" 
               class="nav-link">
                <i class="fa-solid fa-users"></i> Tài khoản
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=list"
               class="nav-link">
                <i class="fa-solid fa-tag"></i> Mã giảm giá
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/BaoHanhServlet?action=list"
               class="nav-link">
                <i class="fa-solid fa-shield"></i> Bảo hành
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list"
               class="nav-link">
                <i class="fa-solid fa-triangle-exclamation"></i> Khiếu nại
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/LichSuHoatDongServlet?action=list" 
               class="nav-link">
                <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử
            </a>
        </li>

        <div class="nav-section">Tài khoản</div>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/AuthServlet?action=logout"
               class="nav-link">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>