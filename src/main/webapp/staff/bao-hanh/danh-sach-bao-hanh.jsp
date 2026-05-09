<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Danh sách bảo hành"/>
<c:set var="breadcrumb" value="Bảo hành"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">
    <%@ include file="/common/sidebar-staff.jsp" %>
    <div class="main-content">
        <%@ include file="/common/topnav-staff.jsp" %>
        <div class="page-content">
            <div class="card">
                <div class="card-header"><div class="card-title"><i class="bi bi-shield-check"></i> Danh sách bảo hành</div></div>
                <div class="card-body p0">
                    <table class="tbl">
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
                            <%-- Dữ liệu mẫu (xóa khi ghép Servlet) --%>
                            <tr>
                                <td>1</td>
                                <td><strong>#BH001</strong></td>
                                <td>1</td>
                                <td>1</td>
                                <td>2</td>
                                <td>01/03/2025</td>
                                <td>01/03/2026</td>
                                <td><span class="badge badge-success">Còn hạn</span></td>
                            </tr>

                            <%-- Uncomment khi ghép Servlet
                            <c:choose>
                                <c:when test="${not empty listBaoHanh}">
                                    <c:forEach items="${listBaoHanh}" var="bh">
                                    <tr>
                                        <td>${bh.idBaoHanh}</td>
                                        <td><strong>#${bh.maBaoHanhCode}</strong></td>
                                        <td>${bh.idDonHang}</td>
                                        <td>${bh.idBienThe}</td>
                                        <td>${bh.idNhanVien}</td>
                                        <td><fmt:formatDate value="${bh.ngayBatDau}" pattern="dd/MM/yyyy"/></td>
                                        <td><fmt:formatDate value="${bh.ngayKetThuc}" pattern="dd/MM/yyyy"/></td>
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
                                    </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="tbl-no-data">
                                            <i class="bi bi-inbox"></i> Chưa có phiếu bảo hành nào
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            --%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>