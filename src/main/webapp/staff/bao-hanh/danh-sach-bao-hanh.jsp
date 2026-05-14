<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Danh sách bảo hành"/>
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

    <%--  Sửa: jsp:include thay <%@ include --%>
    <jsp:include page="/common/sidebar-staff.jsp"/>

    <div class="main-content">
        <jsp:include page="/common/topnav-staff.jsp"/>

        <div class="page-content">
            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-shield-check"></i> Danh sách bảo hành
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Mã BH</th>
                                <th>ID đơn hàng</th>
                                <th>ID biến thể</th>
                                <th>Nhân viên</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%--  Xóa data mẫu, uncomment phần servlet --%>
                            <c:choose>
                                <c:when test="${not empty danhSachBaoHanh}">
                                    <c:forEach items="${danhSachBaoHanh}" var="bh">
                                        <tr>
                                            <td>${bh.idBaoHanh}</td>
                                            <td><strong>#${bh.maBaoHanhCode}</strong></td>
                                            <td>${bh.idDonHang}</td>
                                            <td>${bh.idBienThe}</td>
                                            <td>${bh.idNhanVien}</td>
                                            <td>
                                                <fmt:formatDate value="${bh.ngayBatDau}"
                                                                pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${bh.ngayKetThuc}"
                                                                pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${bh.trangThai == 'CON_HAN'}">
                                                        <span class="badge bg-success">Còn hạn</span>
                                                    </c:when>
                                                    <c:when test="${bh.trangThai == 'HET_HAN'}">
                                                        <span class="badge bg-danger">Hết hạn</span>
                                                    </c:when>
                                                    <c:when test="${bh.trangThai == 'DANG_XU_LY'}">
                                                        <span class="badge bg-warning text-dark">
                                                            Đang xử lý
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">
                                                            ${bh.trangThai}
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
                                            <div>Chưa có phiếu bảo hành nào</div>
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