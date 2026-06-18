<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Lịch sử hoạt động"/>
<c:set var="breadcrumb" value="Hệ thống / Lịch sử"/>
<c:set var="activeMenu" value="logs" scope="request"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - CLICKBUY Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
<div class="layout-wrapper">
    <jsp:include page="/common/sidebar-admin.jsp"/>

    <div class="main-content">
        <jsp:include page="/common/topnav-admin.jsp"/>

        <div class="page-content">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i> ${error}
                </div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-clock-history"></i> Nhật ký hệ thống
                    </div>
                    <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/LichSuHoatDongServlet?action=list">
                        <i class="bi bi-arrow-clockwise"></i> Làm mới
                    </a>
                </div>
                <div class="card-body p0">
                    <div class="tbl-wrap">
                        <table class="tbl">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người dùng</th>
                                <th>Hành động</th>
                                <th>Bảng tác động</th>
                                <th>Đối tượng</th>
                                <th>IP</th>
                                <th>Thời gian</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty danhSachLichSu}">
                                    <c:forEach items="${danhSachLichSu}" var="log">
                                        <tr>
                                            <td>#${log.idLog}</td>
                                            <td>
                                                <div style="font-weight:700">${log.tenNguoiDung}</div>
                                                <div style="font-size:11.5px;color:var(--text-muted)">${log.email}</div>
                                            </td>
                                            <td>${log.hanhDong}</td>
                                            <td><span class="badge badge-admin">${log.bangTacDong}</span></td>
                                            <td>#${log.idDoiTuong}</td>
                                            <td>${log.diaChiIp}</td>
                                            <td style="white-space:nowrap">
                                                <fmt:formatDate value="${log.thoiGian}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="tbl-no-data">
                                            <i class="bi bi-inbox"></i> Chưa có log
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
