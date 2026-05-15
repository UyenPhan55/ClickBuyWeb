<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Danh sách sản phẩm"/>
<c:set var="breadcrumb" value="Sản phẩm / Danh sách"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm – CLICKBUY</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">

    <%--  Sửa 1: jsp:include thay <%@ include --%>
    <jsp:include page="/common/sidebar-staff.jsp"/>

    <div class="main-content">
        <div class="topnav">
            <div class="topnav-left">
                <div>
                    <div class="page-title">Danh sách sản phẩm</div>
                    <div class="breadcrumb">
                        <%--  Sửa 2: StaffServlet không cần action --%>
                        <a href="${pageContext.request.contextPath}/StaffServlet">Trang chủ</a>
                        <span>/</span>
                        <span>Sản phẩm</span>
                    </div>
                </div>
            </div>
            <div class="topnav-right">
                <div class="topnav-user">
                    <div class="avatar">
                        <%--  Sửa 3: sessionScope.user.tenDayDu --%>
                        ${not empty sessionScope.user ? sessionScope.user.tenDayDu.charAt(0) : 'N'}
                    </div>
                    <span class="uname">
                        ${not empty sessionScope.user ? sessionScope.user.tenDayDu : 'Nhân viên'}
                    </span>
                </div>
            </div>
        </div>

        <div class="page-content">
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill"></i> ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i> ${error}
                </div>
            </c:if>

            
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-box-seam-fill"></i> Sản phẩm
                    </div>

                    <form method="get"
                          action="${pageContext.request.contextPath}/SanPhamServlet"
                          style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
                        <%--  Sửa 4: action=list thay action=danhSach --%>
                        <input type="hidden" name="action" value="list">
                        <div class="search-wrap">
                            <i class="bi bi-search"></i>
                            <input type="text" name="keyword" class="form-control"
                                   placeholder="Tìm tên sản phẩm..." value="${param.keyword}">
                        </div>
                        <button type="submit" class="btn btn-primary btn-sm">
                            <i class="bi bi-funnel"></i> Lọc
                        </button>
                    </form>
                </div>

                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Ảnh</th>
                                <th>Tên sản phẩm</th>
                                <%--  Sửa 5: Nhà SX thay Danh mục --%>
                                <th>Nhà SX</th>
                                <th>Giá cơ bản</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <%--  Sửa 6: listSanPham thay danhSachSanPham --%>
                                <c:when test="${not empty listSanPham}">
                                    <c:forEach var="sp" items="${listSanPham}" varStatus="st">
                                        <tr>
                                            <td class="text-muted">${st.index + 1}</td>
                                            <td>
                                                <%--  Sửa 7: urlAnh thay hinhAnh --%>
                                                <img src="${not empty sp.urlAnh
                                                    ? pageContext.request.contextPath.concat('/uploads/san-pham/').concat(sp.urlAnh)
                                                    : 'https://placehold.co/50x50?text=SP'}"
                                                     style="width:48px;height:48px;
                                                            object-fit:cover;border-radius:8px;"
                                                     onerror="this.src='https://placehold.co/50x50?text=SP'">
                                            </td>
                                            <td>
                                                <div class="fw-bold">${sp.tenSanPham}</div>
                                                <div style="font-size:11.5px;color:#888">
                                                    <%--  Sửa 7: idSanPham thay maSanPham --%>
                                                    #${sp.idSanPham}
                                                </div>
                                            </td>
                                            <%--  Sửa 5: nhaSanXuat thay tenDanhMuc --%>
                                            <td>${sp.nhaSanXuat}</td>
                                            <td class="fw-bold" style="white-space:nowrap">
                                                <%--  Sửa 8: giaCoban thay giaBan --%>
                                                <fmt:formatNumber value="${sp.giaCoBan}"
                                                                  pattern="#,###"/>₫
                                            </td>
                                            <td>
                                                <%--  Sửa 8: trangThai là int 1/0 --%>
                                                <c:choose>
                                                    <c:when test="${sp.trangThai == 1}">
                                                        <span class="badge bg-success">Đang bán</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Tạm ngưng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-1">
                                                    <%--  Sửa: action=edit + idSanPham --%>
                                                    <a href="${pageContext.request.contextPath}/SanPhamServlet?action=edit&id=${sp.idSanPham}"
                                                       class="btn btn-sm btn-warning"
                                                       title="Sửa">
                                                        <i class="bi bi-pencil-fill"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/SanPhamServlet?action=delete&id=${sp.idSanPham}"
                                                       class="btn btn-sm btn-danger"
                                                       onclick="return confirm('Xác nhận xóa?')"
                                                       title="Xóa">
                                                        <i class="bi bi-trash-fill"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center py-4 text-muted">
                                            <i class="bi bi-inbox fs-4"></i>
                                            <div>Không tìm thấy sản phẩm nào</div>
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