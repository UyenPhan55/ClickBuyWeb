<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<div class="topnav">
    <div class="topnav-left">
        <div>
            <%-- Trong file topnav-staff.jsp của bạn --%>
            <div class="page-title">
                ${not empty pageTitle ? pageTitle : 'Trang quản trị'}
            </div>

            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/StaffServlet?action=dashboard">Trang chủ</a>
                <span>/</span>
                <%-- Hiển thị breadcrumb, nếu không có thì mặc định là Dashboard --%>
                <span>${not empty breadcrumb ? breadcrumb : 'Dashboard'}</span>
            </div>
        </div>
    </div>

    <div class="topnav-right">
        <a href="#" class="topnav-icon-btn">
            <i class="fa-solid fa-bell"></i>
            <span class="dot"></span>
        </a>

        <div class="topnav-user">
            <div class="avatar">${not empty sessionScope.hoTen ? sessionScope.hoTen.substring(0,1).toUpperCase() : 'S'}</div>
            <div class="uname">${not empty sessionScope.hoTen ? sessionScope.hoTen : 'Staff'}</div>
        </div>
    </div>
</div>