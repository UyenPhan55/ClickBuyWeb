<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="pageTitle" value="Tra cứu người dùng"/>
<c:set var="breadcrumb" value="Người dùng / Danh sách"/>
<c:set var="activeMenu" value="users" scope="request"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - CLICKBUY Staff</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">
    <jsp:include page="/common/sidebar-staff.jsp"/>

    <div class="main-content">
        <jsp:include page="/common/topnav-staff.jsp"/>

        <div class="page-content">
            <div class="alert alert-info">
                <i class="bi bi-info-circle-fill"></i>
                Staff chỉ xem thông tin người dùng. Khóa tài khoản và phân quyền do Admin thực hiện.
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-people"></i> Người dùng
                    </div>
                    <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/NguoiDungServlet">
                        <i class="bi bi-arrow-clockwise"></i> Làm mới
                    </a>
                </div>
                <div class="card-body p0">
                    <div class="tbl-wrap">
                        <table class="tbl">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>SĐT</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty danhSachNguoiDung}">
                                    <c:forEach var="nd" items="${danhSachNguoiDung}" varStatus="st">
                                        <tr>
                                            <td class="text-muted">${st.index + 1}</td>
                                            <td>
                                                <div class="item-title">${nd.tenDayDu}</div>
                                                <div class="item-sub">ID: ${nd.idNguoiDung}</div>
                                            </td>
                                            <td>${nd.email}</td>
                                            <td>${nd.sdt}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${nd.idVaiTro == 1}">
                                                        <span class="badge badge-danger">Admin</span>
                                                    </c:when>
                                                    <c:when test="${nd.idVaiTro == 2}">
                                                        <span class="badge badge-warning">Nhân viên</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-neutral">Khách hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${nd.trangThai == 1}">
                                                        <span class="badge badge-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger">Bị khóa</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="tbl-no-data">
                                            <i class="bi bi-people"></i> Không có người dùng
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
