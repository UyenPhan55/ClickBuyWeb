<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mã giảm giá – CLICKBUY</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">

    <jsp:include page="/common/sidebar-staff.jsp"/>

    <div class="main-content">
        <div class="topnav">
            <div class="topnav-left">
                <div class="page-title">Danh sách mã giảm giá</div>
            </div>
            <div class="topnav-right">
                <div class="topnav-user">
                    <div class="avatar">
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

            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-tag-fill"></i> Mã giảm giá
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Mã code</th>
                                <th>Loại giảm</th>
                                <th>Giá trị</th>
                                <th>Đơn tối thiểu</th>
                                <th>Giảm tối đa</th>
                                <th>Số lượng</th>
                                <th>Hạn dùng</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty danhSachMaGiamGia}">
                                    <c:forEach var="mg" items="${danhSachMaGiamGia}" varStatus="st">
                                        <tr>
                                            <td class="text-muted">${st.index + 1}</td>
                                            <td>
                                                <span style="font-family:monospace;font-weight:700;
                                                             font-size:13px;background:#f5f5f5;
                                                             padding:3px 10px;border-radius:6px;
                                                             color:#d70018;">
                                                    ${mg.maCode}
                                                </span>
                                            </td>
                                            <td>
                                                <%--  Sửa: PHAN_TRAM/TIEN_MAT uppercase khớp DB --%>
                                                <c:choose>
                                                    <c:when test="${mg.loaiGiam=='PHAN_TRAM'}">
                                                        <span class="badge bg-info">Phần trăm (%)</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-primary">Số tiền cố định</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="fw-bold text-success" style="white-space:nowrap">
                                                <c:choose>
                                                    <c:when test="${mg.loaiGiam=='PHAN_TRAM'}">
                                                        ${mg.giaTriGiam}%
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatNumber value="${mg.giaTriGiam}"
                                                                          pattern="#,###"/>₫
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-size:12.5px;white-space:nowrap">
                                                <fmt:formatNumber value="${mg.donToiThieu}"
                                                                  pattern="#,###"/>₫
                                            </td>
                                            <td style="font-size:12.5px;white-space:nowrap">
                                                <fmt:formatNumber value="${mg.giamToiDa}"
                                                                  pattern="#,###"/>₫
                                            </td>
                                            <%--  Sửa: soLuongGioiHan thay soLuotDung --%>
                                            <td class="text-center">
                                                ${mg.soLuongGioiHan}
                                            </td>
                                            <td style="font-size:12.5px">
                                                <fmt:formatDate value="${mg.ngayBatDau}"
                                                                pattern="dd/MM/yyyy"/>
                                                <br>
                                                <span class="text-muted">→</span>
                                                <fmt:formatDate value="${mg.ngayHetHan}"
                                                                pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <%--  Sửa: trangThai là int 1/0 --%>
                                                <c:choose>
                                                    <c:when test="${mg.trangThai == 1}">
                                                        <span class="badge bg-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Tắt</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="9" class="text-center py-4 text-muted">
                                            <i class="bi bi-tag fs-4"></i>
                                            <div>Không có mã giảm giá nào</div>
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