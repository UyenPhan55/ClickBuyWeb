<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="topnav">
    <div class="topnav-left">
        <div>
            <div class="page-title">
                ${not empty pageTitle ? pageTitle : 'Trang quản trị'}
            </div>
            <div class="breadcrumb">
                <%--  Sửa: trỏ vào StaffServlet --%>
                <a href="${pageContext.request.contextPath}/StaffServlet">Trang chủ</a>
                <span>/</span>
                <span>${not empty breadcrumb ? breadcrumb : 'Dashboard'}</span>
            </div>
        </div>
    </div>
    <div class="topnav-right">
        <div class="topnav-role">
            <i class="bi bi-person-badge-fill"></i> NHÂN VIÊN
        </div>
        <a href="#" class="topnav-icon-btn">
            <i class="bi bi-bell"></i>
            <span class="dot"></span>
        </a>
        <div class="topnav-user">
            <%--  Sửa: sessionScope.user.tenDayDu --%>
            <div class="avatar">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu.charAt(0) : 'S'}
            </div>
            <span class="uname">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu : 'Staff'}
            </span>
        </div>
    </div>
</div>