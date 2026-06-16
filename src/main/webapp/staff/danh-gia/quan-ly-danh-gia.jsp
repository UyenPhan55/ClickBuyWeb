<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Quản lý đánh giá"/>
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
    <jsp:include page="/common/sidebar-staff.jsp"/>
    <div class="main-content">
        <jsp:include page="/common/header-staff.jsp"/>
        <div class="page-content">
            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill"></i> ${error}</div>
            </c:if>
            <div class="card">
                <div class="card-header">
                    <div class="card-title"><i class="bi bi-star-fill"></i> Danh sách đánh giá</div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Khách hàng</th>
                                <th>Sản phẩm</th>
                                <th>Sao</th>
                                <th>Nội dung</th>
                                <th>Ngày</th>
                                <th>Trạng thái</th>
                                <th>Phản hồi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty danhSachDanhGia}">
                                    <c:forEach var="dg" items="${danhSachDanhGia}">
                                        <tr>
                                            <td>#${dg.idDanhGia}</td>
                                            <td>${dg.tenNguoiDung}</td>
                                            <td>
                                                ${dg.tenSanPham}
                                                <div class="small text-muted">${dg.tenBienThe}</div>
                                            </td>
                                            <td>
                                                <c:forEach begin="1" end="5" var="s">
                                                    <i class="bi bi-star-fill ${s <= dg.soSao ? 'text-warning' : 'text-muted'}"></i>
                                                </c:forEach>
                                            </td>
                                            <td style="max-width:220px">${dg.noiDung}</td>
                                            <td>
                                                <fmt:formatDate value="${dg.ngayDanhGia}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${dg.trangThai == 1}">
                                                        <span class="badge bg-success">Hiển thị</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Ẩn</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="min-width:260px">
                                                <form action="${pageContext.request.contextPath}/danh-gia" method="post" class="mb-2">
                                                    <input type="hidden" name="action" value="reply">
                                                    <input type="hidden" name="idDanhGia" value="${dg.idDanhGia}">
                                                    <textarea name="traLoi" class="form-control form-control-sm mb-1" rows="2"
                                                              placeholder="Trả lời khách hàng...">${dg.traLoi}</textarea>
                                                    <button type="submit" class="btn btn-sm btn-primary">Gửi trả lời</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/danh-gia" method="post" class="d-flex gap-1">
                                                    <input type="hidden" name="action" value="updateStatus">
                                                    <input type="hidden" name="idDanhGia" value="${dg.idDanhGia}">
                                                    <select name="trangThai" class="form-select form-select-sm">
                                                        <option value="1" ${dg.trangThai == 1 ? 'selected' : ''}>Hiển thị</option>
                                                        <option value="0" ${dg.trangThai == 0 ? 'selected' : ''}>Ẩn</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-sm btn-outline-secondary">Lưu</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">Chưa có đánh giá nào</td>
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
