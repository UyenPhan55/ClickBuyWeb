<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<div class="topnav">
    <div class="topnav-left">
        <div class="page-title">${pageTitle}</div>
        <div class="breadcrumb"><span>${breadcrumb}</span></div>
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
                <c:choose>
                    <c:when test="${not empty sessionScope.hoTen}">
                        ${sessionScope.hoTen.charAt(0)}
                    </c:when>
                    <c:otherwise>S</c:otherwise>
                </c:choose>
            </div>
            <span class="uname">
                <c:choose>
                    <c:when test="${not empty sessionScope.hoTen}">${sessionScope.hoTen}</c:when>
                    <c:otherwise>Staff</c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>
</div>