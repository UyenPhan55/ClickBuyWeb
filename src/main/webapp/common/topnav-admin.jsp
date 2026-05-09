<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<div class="topnav">
    <div class="topnav-left">
        <div>
            <div class="page-title">${pageTitle}</div>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Trang chủ</a>
                <span>/</span>
                <span>${breadcrumb}</span>
            </div>
        </div>
    </div>

    <div class="topnav-right">
        <div class="topnav-role">
            <i class="fa-solid fa-shield"></i> ADMIN
        </div>

        <a href="#" class="topnav-icon-btn">
            <i class="fa-solid fa-bell"></i>
            <span class="dot"></span>
        </a>

        <div class="topnav-user">
            <div class="avatar">${not empty sessionScope.hoTen ? sessionScope.hoTen.substring(0,1).toUpperCase() : 'A'}</div>
            <div class="uname">${not empty sessionScope.hoTen ? sessionScope.hoTen : 'Admin'}</div>
        </div>
    </div>
</div>