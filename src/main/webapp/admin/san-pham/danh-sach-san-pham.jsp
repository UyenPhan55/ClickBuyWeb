<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<c:if test="${empty sessionScope.user || sessionScope.user.idVaiTro != 1}">
    <c:redirect url="/dang-nhap.jsp"/>
</c:if>

<c:set var="pageTitle" value="Quản lý sản phẩm"/>
<c:set var="activeMenu" value="products"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} – CLICKBUY</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>

<body>

<div class="layout-wrapper">

    <jsp:include page="/common/sidebar-admin.jsp"/>

    <div class="main-content">

        <jsp:include page="/common/topnav-admin.jsp"/>

        <div class="page-content">

            <!-- Message -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill"></i>
                    ${message}
                </div>
            </c:if>

            <!-- Error -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i>
                    ${error}
                </div>
            </c:if>

            <!-- Card -->
            <div class="card">

                <div class="card-header d-flex justify-content-between align-items-center">

                    <div class="card-title">
                        <i class="bi bi-box-seam-fill"></i>
                        Danh sách sản phẩm
                    </div>

                    <a href="${pageContext.request.contextPath}/san-pham?action=add"
                       class="btn btn-primary btn-sm">

                        <i class="bi bi-plus-lg"></i>
                        Thêm mới
                    </a>
                </div>

                <div class="card-body p-0">

                    <table class="table table-hover mb-0">

                        <thead>
                        <tr>
                            <th style="width:50px">ID</th>
                            <th style="width:70px">Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Nhà SX</th>
                            <th style="width:130px">Giá cơ bản</th>
                            <th style="width:110px">Trạng thái</th>
                            <th style="width:180px">Thao tác</th>
                        </tr>
                        </thead>

                        <tbody>

                        <c:choose>

                            <%-- Có dữ liệu --%>
                            <c:when test="${not empty listSanPham}">

                                <c:forEach items="${listSanPham}" var="sp">

                                    <tr>

                                        <!-- ID -->
                                        <td>
                                            ${sp.idSanPham}
                                        </td>

                                        <!-- Ảnh -->
                                        <<!-- Ảnh -->
                                        <td>
                                            <c:choose>

                                                <c:when test="${not empty sp.urlAnh}">
                                                    <img
                                                        src="${pageContext.request.contextPath}/assets/images/${sp.urlAnh}"
                                                        alt="${sp.tenSanPham}"
                                                        class="tbl-img"
                                                        onerror="this.onerror=null;
                                                        this.src='${pageContext.request.contextPath}/assets/images/iphone14.jpg';">
                                                </c:when>

                                                <c:otherwise>
                                                    <img
                                                        src="${pageContext.request.contextPath}/assets/images/iphone14.jpg"
                                                        alt="Không có ảnh"
                                                        class="tbl-img">
                                                </c:otherwise>

                                            </c:choose>
                                        </td>
                                        <!-- Tên -->
                                        <td>

                                            <div style="font-weight:600">
                                                ${sp.tenSanPham}
                                            </div>

                                            <div style="font-size:12px;color:#888">

                                                <c:choose>

                                                    <c:when test="${fn:length(sp.moTa) > 60}">
                                                        ${fn:substring(sp.moTa, 0, 60)}...
                                                    </c:when>

                                                    <c:otherwise>
                                                        ${sp.moTa}
                                                    </c:otherwise>

                                                </c:choose>

                                            </div>
                                        </td>

                                        <!-- Nhà sản xuất -->
                                        <td>
                                            ${sp.nhaSanXuat}
                                        </td>

                                        <!-- Giá -->
                                        <td style="font-weight:700">

                                            <fmt:formatNumber
                                                value="${sp.giaCoBan}"
                                                pattern="#,###"/>

                                            ₫
                                        </td>

                                        <!-- Trạng thái -->
                                        <td>

                                            <c:choose>

                                                <c:when test="${sp.trangThai == 1}">
                                                    <span class="badge bg-success">
                                                        Đang bán
                                                    </span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark">
                                                        Tạm ngưng
                                                    </span>
                                                </c:otherwise>

                                            </c:choose>

                                        </td>

                                        <!-- Thao tác -->
                                        <td>

                                            <div style="display:flex;gap:5px">

                                                <!-- Sửa -->
                                                <a href="${pageContext.request.contextPath}/san-pham?action=edit&id=${sp.idSanPham}"
                                                   class="btn btn-sm btn-warning">

                                                    <i class="bi bi-pencil-fill"></i>
                                                </a>

                                                <!-- Xóa -->
                                                <form action="${pageContext.request.contextPath}/san-pham"
                                                      method="post"
                                                      style="display:inline"

                                                      onsubmit="return confirm('Xác nhận xóa sản phẩm ${sp.tenSanPham}?')">

                                                    <input type="hidden"
                                                           name="action"
                                                           value="delete">

                                                    <input type="hidden"
                                                           name="id"
                                                           value="${sp.idSanPham}">

                                                    <button type="submit"
                                                            class="btn btn-sm btn-danger">

                                                        <i class="bi bi-trash-fill"></i>
                                                    </button>

                                                </form>

                                            </div>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </c:when>

                            <%-- Không có dữ liệu --%>
                            <c:otherwise>

                                <tr>

                                    <td colspan="7"
                                        class="text-center py-4 text-muted">

                                        <i class="bi bi-inbox fs-4"></i>

                                        <div>
                                            Chưa có sản phẩm nào
                                        </div>

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
