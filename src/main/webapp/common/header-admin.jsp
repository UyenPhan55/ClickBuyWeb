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
    <%-- SIDEBAR được include ở đây luôn để đồng bộ --%>
    <%@ include file="/common/sidebar-admin.jsp" %>

    <div class="main-wrapper">
        <%-- TOPNAV --%>
        <div class="topnav">
            <div class="topnav-left">
                <div class="page-title">${pageTitle}</div>
                <div class="breadcrumb"><span>${breadcrumb}</span></div>
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
                    <div class="avatar">
                        <c:choose>
                            <c:when test="${not empty sessionScope.hoTen}">
                                ${sessionScope.hoTen.substring(0,1).toUpperCase()}
                            </c:when>
                            <c:otherwise>A</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="uname">
                        <c:choose>
                            <c:when test="${not empty sessionScope.hoTen}">${sessionScope.hoTen}</c:when>
                            <c:otherwise>Admin</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
        <%-- NỘI DUNG TRANG BẮT ĐẦU TỪ ĐÂY --%>