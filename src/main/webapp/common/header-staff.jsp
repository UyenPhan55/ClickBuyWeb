<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="topnav">
    <div class="topnav-left">
        <div class="page-title">${pageTitle}</div>
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/StaffServlet">Trang chủ</a>
            <span>/</span>
            <span>${breadcrumb}</span>
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
            <div class="avatar">
                <%--  Sửa: sessionScope.user.tenDayDu --%>
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu.charAt(0) : 'S'}
            </div>
            <span class="uname">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu : 'Staff'}
            </span>
        </div>
    </div>
</div>