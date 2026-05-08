<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Quản lý tài khoản"/>
<c:set var="breadcrumb" value="Người dùng / Danh sách"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">
    <%@ include file="/common/sidebar-admin.jsp" %>
    <div class="main-content">
        <%@ include file="/common/topnav-admin.jsp" %>
        <div class="page-content">
            <div class="card">
                <div class="card-header"><h5>Danh sách tài khoản</h5></div>
                <div class="card-body">
                    <table class="table table-hover">
                        <thead>
                            <tr><th>ID</th><th>Họ tên</th><th>Email</th><th>Vai trò</th><th>Trạng thái</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listUser}" var="u">
                            <tr>
                                <td>${u.idNguoiDung}</td>
                                <td>${u.hoTen}</td>
                                <td>${u.email}</td>
                                <td><span class="badge bg-info">${u.tenVaiTro}</span></td>
                                <td>${u.trangThai == 1 ? 'Hoạt động' : 'Bị khóa'}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>