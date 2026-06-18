<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Quản lý mã giảm giá"/>
<c:set var="breadcrumb" value="Mã giảm giá / Danh sách"/>
<c:set var="activeMenu" value="vouchers" scope="request"/>

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
                        <i class="bi bi-tags"></i> Danh sách mã giảm giá
                    </div>
                    <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=list">
                        <i class="bi bi-arrow-clockwise"></i> Làm mới
                    </a>
                </div>
                <div class="card-body p0">
                    <div class="tbl-wrap">
                        <table class="tbl">
                            <thead>
                            <tr>
                                <th>Mã code</th>
                                <th>Loại giảm</th>
                                <th>Giá trị</th>
                                <th>Đơn tối thiểu</th>
                                <th>Giảm tối đa</th>
                                <th>Số lượng</th>
                                <th>Thời gian</th>
                                <th>Trạng thái</th>
                                <th style="width:90px">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty listMGG}">
                                    <c:forEach var="mg" items="${listMGG}">
                                        <tr>
                                            <td><strong>${mg.maCode}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${mg.loaiGiam == 'PHAN_TRAM'}">
                                                        <span class="badge badge-info">Phần trăm</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-primary">Tiền mặt</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-weight:700;white-space:nowrap">
                                                <c:choose>
                                                    <c:when test="${mg.loaiGiam == 'PHAN_TRAM'}">
                                                        ${mg.giaTriGiam}%
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatNumber value="${mg.giaTriGiam}" pattern="#,###"/>đ
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatNumber value="${mg.donToiThieu}" pattern="#,###"/>đ</td>
                                            <td><fmt:formatNumber value="${mg.giamToiDa}" pattern="#,###"/>đ</td>
                                            <td>${mg.soLuongGioiHan}</td>
                                            <td style="white-space:nowrap">
                                                <fmt:formatDate value="${mg.ngayBatDau}" pattern="dd/MM/yyyy"/>
                                                <span class="text-muted">-</span>
                                                <fmt:formatDate value="${mg.ngayHetHan}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${mg.trangThai == 1}">
                                                        <span class="badge badge-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-neutral">Tắt</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a class="btn btn-danger btn-sm btn-icon"
                                                   href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=xoa&id=${mg.idVoucher}"
                                                   onclick="return confirm('Xóa mã giảm giá ${mg.maCode}?')"
                                                   title="Xóa">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="9" class="tbl-no-data">
                                            <i class="bi bi-tag"></i> Không có mã giảm giá
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
