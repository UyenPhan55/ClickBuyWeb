<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Tra cứu sản phẩm"/>
<c:set var="breadcrumb" value="Sản phẩm / Danh sách"/>
<c:set var="activeMenu" value="products" scope="request"/>

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
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i> ${error}
                </div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-phone"></i> Danh sách sản phẩm
                    </div>
                    <form action="${pageContext.request.contextPath}/san-pham"
                          method="get"
                          class="search-wrap">

                        <input type="hidden" name="action" value="list">

                        <i class="bi bi-search"></i>

                        <input type="text"
                               name="keyword"
                               class="form-control"
                               placeholder="Tìm theo tên sản phẩm..."
                               value="${keyword}">
                    </form>
                </div>

                <div class="card-body p0">
                    <div class="tbl-wrap">
                        <table class="tbl">
                            <thead>
                            <tr>
                                <th style="width:48px">#</th>
                                <th style="width:62px">Ảnh</th>
                                <th>Sản phẩm</th>
                                <th>Nhà sản xuất</th>
                                <th>Giá cơ bản</th>
                                <th>Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty listSanPham}">
                                    <c:forEach var="sp" items="${listSanPham}" varStatus="st">
                                        <tr>
                                            <td class="text-muted">${st.index + 1}</td>
                                            <td>
                                                <img class="tbl-img"
                                                     src="${pageContext.request.contextPath}/uploads/san-pham/${sp.urlAnh}"
                                                     alt="${sp.tenSanPham}"
                                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/iphone15.jpg'">
                                            </td>
                                            <td>
                                                <div class="item-title">${sp.tenSanPham}</div>
                                                <div class="item-sub">Mã sản phẩm: ${sp.idSanPham}</div>
                                            </td>
                                            <td>${sp.nhaSanXuat}</td>
                                            <td style="font-weight:700;white-space:nowrap">
                                                <fmt:formatNumber value="${sp.giaCoBan}" pattern="#,###"/>đ
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${sp.trangThai == 1}">
                                                        <span class="badge badge-success">Đang bán</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-neutral">Tạm ngưng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="tbl-no-data">
                                            <i class="bi bi-inbox"></i> Không tìm thấy sản phẩm
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="tbl-footer">
                    <div class="tbl-footer-info">Dữ liệu sản phẩm từ hệ thống</div>
                    <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/SanPhamServlet?action=list">
                        <i class="bi bi-arrow-clockwise"></i> Làm mới
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
