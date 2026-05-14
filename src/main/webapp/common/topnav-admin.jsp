<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="topnav">
    <div class="topnav-left">
        <div>
            <div class="page-title">${pageTitle}</div>
            <div class="breadcrumb">
                <%--  Sửa: trỏ vào AdminServlet --%>
                <a href="${pageContext.request.contextPath}/AdminServlet">Trang chủ</a>
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
            <%--  Sửa: sessionScope.user.tenDayDu --%>
            <div class="avatar">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu.charAt(0) : 'A'}
            </div>
            <div class="uname">
                ${not empty sessionScope.user ? sessionScope.user.tenDayDu : 'Admin'}
            </div>
        </div>
    </div>
</div>