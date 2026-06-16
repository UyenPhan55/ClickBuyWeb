<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khiếu nại – CLICKBUY</title>
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
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill"></i> ${message}
                </div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-exclamation-triangle"></i> Danh sách khiếu nại
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Khách hàng</th>
                                <th>Mã đơn</th>
                                <th>Nội dung</th>
                                <th>Yêu cầu trả hàng</th>
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
                                            <td>#${kn.idKhieuNai}</td>
                                            <td>${kn.tenNguoiDung}</td>
                                            <td>#CB${kn.idDonHang}</td>
                                            <td style="max-width:200px;overflow:hidden;
                                                        text-overflow:ellipsis;white-space:nowrap">
                                                ${kn.noiDung}
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${kn.yeuCauTraHang == 1}">
                                                        <span class="badge bg-warning text-dark">
                                                            Có
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Không</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-size:12px;white-space:nowrap">
                                                <fmt:formatDate value="${kn.ngayGui}"
                                                                pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${kn.trangThai=='CHO_XU_LY'}">
                                                        <span class="badge bg-danger">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${kn.trangThai=='DA_PHAN_HOI'}">
                                                        <span class="badge bg-success">Đã phản hồi</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">
                                                            ${kn.trangThai}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${kn.trangThai=='CHO_XU_LY'}">
                                                        <button type="button"
                                                                class="btn btn-sm btn-primary"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalPhanHoi"
                                                                data-id="${kn.idKhieuNai}">
                                                            <i class="bi bi-reply"></i> Phản hồi
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted" style="font-size:12px">
                                                            ${kn.phanHoi}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center py-4 text-muted">
                                            <i class="bi bi-inbox fs-4"></i>
                                            <div>Chưa có khiếu nại nào</div>
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

<%-- Modal phản hồi --%>
<div class="modal fade" id="modalPhanHoi" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/KhieuNaiServlet"
                  method="post">
                <input type="hidden" name="action" value="reply">
                <input type="hidden" name="id_khieu_nai" id="hiddenIdKhieuNai">
                <div class="modal-header">
                    <h5 class="modal-title">Phản hồi khiếu nại</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label fw-semibold">Nội dung phản hồi</label>
                    <textarea name="phan_hoi" class="form-control" rows="4"
                              placeholder="Nhập phản hồi..." required></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Gửi phản hồi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Truyền id vào modal khi mở
    document.getElementById('modalPhanHoi').addEventListener('show.bs.modal', function(e) {
        const id = e.relatedTarget.getAttribute('data-id');
        document.getElementById('hiddenIdKhieuNai').value = id;
    });
</script>
</body>
</html>