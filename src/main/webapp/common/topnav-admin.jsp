<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="topnav">
    <div class="topnav-left">
        <div>
            <div class="page-title">
                ${not empty pageTitle ? pageTitle : 'Trang quản trị'}
            </div>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/AdminServlet">Trang chủ</a>
                <span>/</span>
                <span>${not empty breadcrumb ? breadcrumb : 'Dashboard'}</span>
            </div>
        </div>
    </div>
    <div class="topnav-right">
        <div class="topnav-role">
            <i class="bi bi-shield-fill-check"></i> ADMIN
        </div>
        <div class="topnav-user">
            <div class="avatar">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu.charAt(0) : 'A'}
            </div>
            <div class="uname">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu : 'Admin'}
            </div>
        </div>
    </div>
</div>
