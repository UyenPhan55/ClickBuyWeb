<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<c:set var="pageTitle" value="Quản lý bảo hành"/>
<c:set var="breadcrumb" value="Bảo hành / Danh sách"/>
<c:set var="activeMenu" value="warranty" scope="request"/>

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
                        <i class="bi bi-shield-check"></i> Danh sách bảo hành
                    </div>
                    <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/BaoHanhServlet?action=list">
                        <i class="bi bi-arrow-clockwise"></i> Làm mới
                    </a>
                </div>
                <div class="card-body p0">
                    <div class="tbl-wrap">
                        <table class="tbl">
                            <thead>
                            <tr>
                                <th>Mã BH</th>
                                <th>Khách hàng</th>
                                <th>Sản phẩm</th>
                                <th>Đơn hàng</th>
                                <th>Thời hạn</th>
                                <th>Nhân viên</th>
                                <th>Trạng thái</th>
                                <th style="width:110px">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty danhSachBaoHanh}">
                                    <c:forEach items="${danhSachBaoHanh}" var="bh">
                                        <tr>
                                            <td><strong>${bh.maBaoHanhCode}</strong></td>
                                            <td>
                                                <div style="font-weight:700">${bh.tenNguoiDung}</div>
                                                <div style="font-size:11.5px;color:var(--text-muted)">ID: ${bh.idNguoiDung}</div>
                                            </td>
                                            <td>
                                                <div style="font-weight:700">${bh.tenSanPham}</div>
                                                <div style="font-size:11.5px;color:var(--text-muted)">${bh.tenBienThe}</div>
                                            </td>
                                            <td>#${bh.idDonHang}</td>
                                            <td style="white-space:nowrap">
                                                <fmt:formatDate value="${bh.ngayBatDau}" pattern="dd/MM/yyyy"/>
                                                <span class="text-muted">-</span>
                                                <fmt:formatDate value="${bh.ngayKetThuc}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>${not empty bh.tenNhanVien ? bh.tenNhanVien : 'Chưa gán'}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${bh.trangThai == 'CON_HAN'}">
                                                        <span class="badge badge-success">Còn hạn</span>
                                                    </c:when>
                                                    <c:when test="${bh.trangThai == 'HET_HAN'}">
                                                        <span class="badge badge-danger">Hết hạn</span>
                                                    </c:when>
                                                    <c:when test="${bh.trangThai == 'DANG_XU_LY'}">
                                                        <span class="badge badge-warning">Đang xử lý</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-neutral">${bh.trangThai}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <button type="button"
                                                        class="btn btn-admin btn-sm"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#modalBaoHanh"
                                                        data-id="${bh.idBaoHanh}"
                                                        data-status="${bh.trangThai}"
                                                        data-note="${fn:escapeXml(bh.ghiChu)}">
                                                    <i class="bi bi-pencil-square"></i> Cập nhật
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="tbl-no-data">
                                            <i class="bi bi-inbox"></i> Chưa có phiếu bảo hành
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

<div class="modal fade" id="modalBaoHanh" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/BaoHanhServlet" method="post">
                <input type="hidden" name="action" value="updateStatus">
                <input type="hidden" name="idBaoHanh" id="idBaoHanh">
                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật bảo hành</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Trạng thái</label>
                        <select name="trangThai" id="trangThaiBaoHanh" class="form-select">
                            <option value="CON_HAN">Còn hạn</option>
                            <option value="DANG_XU_LY">Đang xử lý</option>
                            <option value="HET_HAN">Hết hạn</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Ghi chú</label>
                        <textarea name="ghiChu" id="ghiChuBaoHanh" class="form-control" rows="4"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-admin">
                        <i class="bi bi-save"></i> Lưu
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('modalBaoHanh').addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        document.getElementById('idBaoHanh').value = button.getAttribute('data-id');
        document.getElementById('trangThaiBaoHanh').value = button.getAttribute('data-status') || 'CON_HAN';
        document.getElementById('ghiChuBaoHanh').value = button.getAttribute('data-note') || '';
    });
</script>
</body>
</html>
