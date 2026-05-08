<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Quản lý sản phẩm"/>
<c:set var="breadcrumb" value="Sản phẩm / Danh sách"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} – CLICKBUY</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">
    <%@ include file="/common/sidebar-admin.jsp" %>
    <div class="main-content">
        <%@ include file="/common/topnav-admin.jsp" %>
        <div class="page-content">

            <c:if test="${not empty message}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill"></i> ${error}</div>
            </c:if>

            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <div class="card-title"><i class="bi bi-box-seam-fill"></i> Danh sách sản phẩm</div>
                    <a href="them-san-pham.jsp" class="btn btn-primary btn-sm">
                        <i class="bi bi-plus-lg"></i> Thêm mới
                    </a>
                </div>
                <div class="card-body p0">
                    <div class="tbl-wrap">
                        <table class="tbl">
                            <thead>
                                <tr>
                                    <th style="width:50px">ID</th>
                                    <th style="width:70px">Ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Nhà SX</th>
                                    <th style="width:130px">Giá cơ bản</th>
                                    <th style="width:110px">Trạng thái</th>
                                    <th style="width:120px">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- ========= DỮ LIỆU MẪU (xóa khi ghép Servlet) ========= --%>
                                <tr>
                                    <td>1</td>
                                    <td>
                                        <img src="https://placehold.co/50x50?text=SP" alt="ảnh"
                                             style="width:48px;height:48px;object-fit:cover;border-radius:8px;border:1px solid #eee">
                                    </td>
                                    <td>
                                        <div style="font-weight:600">Laptop Gaming ASUS ROG Strix G16</div>
                                        <div style="font-size:12px;color:var(--text-muted)">Core i7-13650HX | RTX 4050</div>
                                    </td>
                                    <td>ASUS</td>
                                    <td style="font-weight:700">
                                        <fmt:formatNumber value="35490000" pattern="#,###"/>₫
                                    </td>
                                    <td><span class="badge badge-success">Đang bán</span></td>
                                    <td>
                                        <a href="sua-san-pham.jsp" class="btn btn-sm btn-warning">
                                            <i class="bi bi-pencil-fill"></i> Sửa
                                        </a>
                                        <a href="#" class="btn btn-sm btn-danger">
                                            <i class="bi bi-trash-fill"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>
                                        <img src="https://placehold.co/50x50?text=SP" alt="ảnh"
                                             style="width:48px;height:48px;object-fit:cover;border-radius:8px;border:1px solid #eee">
                                    </td>
                                    <td>
                                        <div style="font-weight:600">Apple MacBook Air M2</div>
                                        <div style="font-size:12px;color:var(--text-muted)">8GB / 256GB</div>
                                    </td>
                                    <td>Apple</td>
                                    <td style="font-weight:700">
                                        <fmt:formatNumber value="24990000" pattern="#,###"/>₫
                                    </td>
                                    <td><span class="badge badge-success">Đang bán</span></td>
                                    <td>
                                        <a href="sua-san-pham.jsp" class="btn btn-sm btn-warning">
                                            <i class="bi bi-pencil-fill"></i> Sửa
                                        </a>
                                        <a href="#" class="btn btn-sm btn-danger">
                                            <i class="bi bi-trash-fill"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>
                                        <img src="https://placehold.co/50x50?text=SP" alt="ảnh"
                                             style="width:48px;height:48px;object-fit:cover;border-radius:8px;border:1px solid #eee">
                                    </td>
                                    <td>
                                        <div style="font-weight:600">Ốp lưng iPhone 15 Silicone Case</div>
                                        <div style="font-size:12px;color:var(--text-muted)">Phụ kiện điện thoại</div>
                                    </td>
                                    <td>Apple</td>
                                    <td style="font-weight:700">
                                        <fmt:formatNumber value="150000" pattern="#,###"/>₫
                                    </td>
                                    <td><span class="badge badge-warning">Tạm ngưng</span></td>
                                    <td>
                                        <a href="sua-san-pham.jsp" class="btn btn-sm btn-warning">
                                            <i class="bi bi-pencil-fill"></i> Sửa
                                        </a>
                                        <a href="#" class="btn btn-sm btn-danger">
                                            <i class="bi bi-trash-fill"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                                <%-- ========= KẾT THÚC DỮ LIỆU MẪU ========= --%>

                                <%-- ========= UNCOMMENT KHI GHÉP SERVLET =========
                                <c:choose>
                                    <c:when test="${not empty listSanPham}">
                                        <c:forEach items="${listSanPham}" var="sp">
                                            <tr>
                                                <td>${sp.idSanPham}</td>
                                                <td>
                                                    <img src="${not empty sp.urlAnh ? sp.urlAnh : 'https://placehold.co/50x50?text=SP'}"
                                                         alt="${sp.tenSanPham}"
                                                         style="width:48px;height:48px;object-fit:cover;border-radius:8px;border:1px solid #eee">
                                                </td>
                                                <td>
                                                    <div style="font-weight:600">${sp.tenSanPham}</div>
                                                    <div style="font-size:12px;color:var(--text-muted)">${fn:substring(sp.moTa,0,60)}...</div>
                                                </td>
                                                <td>${sp.nhaSanXuat}</td>
                                                <td style="font-weight:700">
                                                    <fmt:formatNumber value="${sp.giaCoBan}" pattern="#,###"/>₫
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${sp.trangThai == 'dang_ban'}">
                                                            <span class="badge badge-success">Đang bán</span>
                                                        </c:when>
                                                        <c:when test="${sp.trangThai == 'tam_ngung'}">
                                                            <span class="badge badge-warning">Tạm ngưng</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-neutral">${sp.trangThai}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="sua-san-pham.jsp?id=${sp.idSanPham}" class="btn btn-sm btn-warning">
                                                        <i class="bi bi-pencil-fill"></i> Sửa
                                                    </a>
                                                    <a href="danh-sach-san-pham.jsp?action=delete&id=${sp.idSanPham}"
                                                       class="btn btn-sm btn-danger"
                                                       onclick="return confirm('Xác nhận xóa sản phẩm này?')">
                                                        <i class="bi bi-trash-fill"></i> Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7" class="tbl-no-data">
                                                <i class="bi bi-inbox"></i> Chưa có sản phẩm nào
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                ========= END SERVLET ========= --%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div><%-- end page-content --%>
    </div><%-- end main-content --%>
</div><%-- end layout-wrapper --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
