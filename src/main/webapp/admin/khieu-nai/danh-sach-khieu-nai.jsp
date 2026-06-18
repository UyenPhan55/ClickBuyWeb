<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Quản lý khiếu nại"/>
<c:set var="breadcrumb" value="Khiếu nại / Danh sách"/>
<c:set var="activeMenu" value="complaints" scope="request"/>

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
                        <i class="bi bi-exclamation-triangle"></i> Danh sách khiếu nại
                    </div>
                    <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list">
                        <i class="bi bi-arrow-clockwise"></i> Làm mới
                    </a>
                </div>
                <div class="card-body p0">
                    <div class="tbl-wrap">
                        <table class="tbl">
                            <thead>
                            <tr>
                                <th>Mã</th>
                                <th>Khách hàng</th>
                                <th>Đơn hàng</th>
                                <th>Nội dung</th>
                                <th>Trả hàng</th>
                                <th>Ngày gửi</th>
                                <th>Trạng thái</th>
                                <th>Phản hồi</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty danhSachKhieuNai}">
                                    <c:forEach var="kn" items="${danhSachKhieuNai}">
                                        <tr>
                                            <td><strong>#${kn.idKhieuNai}</strong></td>
                                            <td>
                                                <div style="font-weight:700">${kn.tenNguoiDung}</div>
                                                <div style="font-size:11.5px;color:var(--text-muted)">${kn.email}</div>
                                            </td>
                                            <td>#${kn.idDonHang}</td>
                                            <td style="max-width:280px">${kn.noiDung}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${kn.yeuCauTraHang == 1}">
                                                        <span class="badge badge-warning">Có</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-neutral">Không</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="white-space:nowrap">
                                                <fmt:formatDate value="${kn.ngayGui}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${kn.trangThai == 'CHO_XU_LY'}">
                                                        <span class="badge badge-danger">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${kn.trangThai == 'DA_PHAN_HOI'}">
                                                        <span class="badge badge-success">Đã phản hồi</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-neutral">${kn.trangThai}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${kn.trangThai == 'CHO_XU_LY'}">
                                                        <button type="button"
                                                                class="btn btn-admin btn-sm"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalPhanHoi"
                                                                data-id="${kn.idKhieuNai}">
                                                            <i class="bi bi-reply"></i> Phản hồi
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="font-size:12px;color:var(--text-muted)">${kn.phanHoi}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="tbl-no-data">
                                            <i class="bi bi-inbox"></i> Chưa có khiếu nại
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

<div class="modal fade" id="modalPhanHoi" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/KhieuNaiServlet" method="post">
                <input type="hidden" name="action" value="reply">
                <input type="hidden" name="idKhieuNai" id="hiddenIdKhieuNai">
                <input type="hidden" name="trangThai" value="DA_PHAN_HOI">
                <div class="modal-header">
                    <h5 class="modal-title">Phản hồi khiếu nại</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label">Nội dung phản hồi</label>
                    <textarea name="phanHoi"
                              class="form-control"
                              rows="4"
                              placeholder="Nhập nội dung phản hồi..."
                              required></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-admin">
                        <i class="bi bi-send"></i> Gửi phản hồi
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('modalPhanHoi').addEventListener('show.bs.modal', function (event) {
        document.getElementById('hiddenIdKhieuNai').value = event.relatedTarget.getAttribute('data-id');
    });
</script>
</body>
</html>
