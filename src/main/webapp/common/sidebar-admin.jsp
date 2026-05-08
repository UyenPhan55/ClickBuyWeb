<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="sidebar-brand">
        <div class="sb-logo">A</div>
        <div>
            <div class="sb-brand-name">CLICKBUY</div>
            <span class="sb-brand-role">ADMIN</span>
        </div>
    </a>

    <ul class="sidebar-nav">
        <div class="nav-section">Tổng quan</div>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="nav-link active">
                <i class="fa-solid fa-chart-line"></i> Dashboard
            </a>
        </li>

        <div class="nav-section">Quản lý</div>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/san-pham/danh-sach-san-pham.jsp" class="nav-link">
                <i class="fa-solid fa-box"></i> Sản phẩm
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/nguoi-dung/danh-sach-tai-khoan.jsp" class="nav-link">
                <i class="fa-solid fa-users"></i> Tài khoản
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/lich-su-hoat-dong/danh-sach-lich-su.jsp" class="nav-link">
                <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử
            </a>
        </li>
    </ul>
</div>