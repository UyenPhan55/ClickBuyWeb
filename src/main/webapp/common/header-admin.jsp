<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - CLICKBUY Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
<div class="wrapper">
    <%--  Sửa: jsp:include thay <%@ include --%>
    <jsp:include page="/common/sidebar-admin.jsp"/>

    <div class="main-wrapper">
        <div class="topnav">
            <div class="topnav-left">
                <div class="page-title">${pageTitle}</div>
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/AdminServlet">Trang chủ</a>
                    <span>/</span>
                    <span>${breadcrumb}</span>
                </div>
            </div>
            <div class="topnav-right">
                <div class="topnav-role">
                    <i class="bi bi-shield-fill-check"></i> ADMIN
                </div>
                <a href="#" class="topnav-icon-btn">
                    <i class="bi bi-bell"></i>
                    <span class="dot"></span>
                </a>
                <div class="topnav-user">
                    <%--  Sửa: sessionScope.user.tenDayDu --%>
                    <div class="avatar">
                        ${not empty sessionScope.user
                            ? sessionScope.user.tenDayDu.charAt(0)
                            : 'A'}
                    </div>
                    <span class="uname">
                        ${not empty sessionScope.user
                            ? sessionScope.user.tenDayDu
                            : 'Admin'}
                    </span>
                </div>
            </div>
        </div>
        <%-- NỘI DUNG TRANG BẮT ĐẦU TỪ ĐÂY --%>