<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<%--  Đặt biến TRƯỚC khi include header để header đọc được --%>
<c:set var="pageTitle" value="Dashboard nhân viên"/>
<c:set var="breadcrumb" value="Trang chủ / Dashboard"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} – CLICKBUY Staff</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">

    <%-- SIDEBAR --%>
    <jsp:include page="/common/sidebar-staff.jsp" />

    <div class="main-content">
        <%-- TOPNAV HEADER --%>
        <jsp:include page="/common/header-staff.jsp" />

        <%-- NỘI DUNG --%>
        <div class="page-content">
            <c:if test="${not empty message}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill"></i> ${error}</div>
            </c:if>

            <%-- Stat cards --%>
            <div class="row g-3 mb-4">
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon ic-blue"><i class="bi bi-box-seam-fill"></i></div>
                        <div>
                            <div class="stat-val">${totalProducts != null ? totalProducts : 0}</div>
                            <div class="stat-lbl">Tổng sản phẩm</div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon ic-yellow"><i class="bi bi-cart3"></i></div>
                        <div>
                            <div class="stat-val">${donHangMoi != null ? donHangMoi : 0}</div>
                            <div class="stat-lbl">Đơn mới hôm nay</div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon ic-red"><i class="bi bi-chat-left-text-fill"></i></div>
                        <div>
                            <div class="stat-val">${khieuNaiCho != null ? khieuNaiCho : 0}</div>
                            <div class="stat-lbl">Khiếu nại chờ xử lý</div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon ic-cyan"><i class="bi bi-shield-check"></i></div>
                        <div>
                            <div class="stat-val">${baoHanhCho != null ? baoHanhCho : 0}</div>
                            <div class="stat-lbl">Bảo hành đang xử lý</div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Row 2 --%>
            <div class="row g-3">
                <%-- Đơn hàng gần đây --%>
                <div class="col-xl-8">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title"><i class="bi bi-cart3"></i> Đơn hàng gần đây</div>
                            <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
                               class="btn btn-outline btn-sm">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                        </div>
                        <div class="card-body p0">
                            <div class="tbl-wrap">
                                <table class="tbl">
                                    <thead>
                                        <tr>
                                            <th>#Mã đơn</th><th>Khách hàng</th>
                                            <th>Ngày đặt</th><th>Tổng tiền</th><th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty danhSachDonHang}">
                                                <c:forEach var="dh" items="${danhSachDonHang}" begin="0" end="4">
                                                    <tr>
                                                        <td><strong>#${dh.idDonHang}</strong></td>
                                                        <td>${dh.tenNguoiDung}</td>
                                                        <td><fmt:formatDate value="${dh.ngayDat}" pattern="dd/MM/yyyy"/></td>
                                                        <td style="font-weight:700">
                                                            <fmt:formatNumber value="${dh.tongThanhToan}" pattern="#,###"/>₫
                                                        </td>
                                                        <td>
                                                            <span class="badge
                                                                <c:choose>
                                                                    <c:when test="${dh.trangThai == 'CHO_XAC_NHAN'}">badge-warning</c:when>
                                                                    <c:when test="${dh.trangThai == 'DANG_GIAO'}">badge-info</c:when>
                                                                    <c:when test="${dh.trangThai == 'DA_GIAO' || dh.trangThai == 'HOAN_THANH'}">badge-success</c:when>
                                                                    <c:when test="${dh.trangThai == 'DA_HUY'}">badge-danger</c:when>
                                                                    <c:otherwise>badge-neutral</c:otherwise>
                                                                </c:choose>">
                                                                <c:choose>
                                                                    <c:when test="${dh.trangThai == 'CHO_XAC_NHAN'}">Chờ xác nhận</c:when>
                                                                    <c:when test="${dh.trangThai == 'DANG_GIAO'}">Đang giao</c:when>
                                                                    <c:when test="${dh.trangThai == 'DA_GIAO' || dh.trangThai == 'HOAN_THANH'}">Đã giao</c:when>
                                                                    <c:when test="${dh.trangThai == 'DA_HUY'}">Đã hủy</c:when>
                                                                    <c:otherwise>${dh.trangThai}</c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="5" class="tbl-no-data">
                                                        <i class="bi bi-inbox"></i> Chưa có đơn hàng nào
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

                <%-- Việc cần làm --%>
                <div class="col-xl-4">
                    <div class="card h-100">
                        <div class="card-header">
                            <div class="card-title"><i class="bi bi-lightning-charge-fill"></i> Việc cần làm</div>
                        </div>
                        <div class="card-body" style="padding:12px;display:flex;flex-direction:column;gap:10px;">
                            <a href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list" style="text-decoration:none">
                                <div class="stat-card" style="padding:13px">
                                    <div class="stat-icon ic-red" style="width:40px;height:40px;border-radius:10px;font-size:17px">
                                        <i class="bi bi-chat-left-text-fill"></i>
                                    </div>
                                    <div style="flex:1">
                                        <div class="stat-val" style="font-size:20px">${khieuNaiCho != null ? khieuNaiCho : 0}</div>
                                        <div class="stat-lbl">Khiếu nại chờ xử lý</div>
                                    </div>
                                    <i class="bi bi-chevron-right" style="color:var(--text-muted)"></i>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/BaoHanhServlet?action=list" style="text-decoration:none">
                                <div class="stat-card" style="padding:13px">
                                    <div class="stat-icon ic-yellow" style="width:40px;height:40px;border-radius:10px;font-size:17px">
                                        <i class="bi bi-shield-exclamation"></i>
                                    </div>
                                    <div style="flex:1">
                                        <div class="stat-val" style="font-size:20px">${baoHanhCho != null ? baoHanhCho : 0}</div>
                                        <div class="stat-lbl">Bảo hành đang xử lý</div>
                                    </div>
                                    <i class="bi bi-chevron-right" style="color:var(--text-muted)"></i>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list" style="text-decoration:none">
                                <div class="stat-card" style="padding:13px">
                                    <div class="stat-icon ic-blue" style="width:40px;height:40px;border-radius:10px;font-size:17px">
                                        <i class="bi bi-hourglass-split"></i>
                                    </div>
                                    <div style="flex:1">
                                        <div class="stat-val" style="font-size:20px">${donHangChoXacNhan != null ? donHangChoXacNhan : 0}</div>
                                        <div class="stat-lbl">Đơn chờ xác nhận</div>
                                    </div>
                                    <i class="bi bi-chevron-right" style="color:var(--text-muted)"></i>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div><%-- end row 2 --%>

        </div><%-- end page-content --%>
    </div><%-- end main-content --%>
</div><%-- end layout-wrapper --%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
