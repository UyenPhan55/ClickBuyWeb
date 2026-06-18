<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Dashboard nhân viên"/>
<c:set var="breadcrumb" value="Tổng quan"/>
<c:set var="activeMenu" value="dashboard" scope="request"/>

<!DOCTYPE html>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - CLICKBUY Staff</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">
    <jsp:include page="/common/sidebar-staff.jsp"/>

```
<div class="main-content">
    <jsp:include page="/common/topnav-staff.jsp"/>

    <div class="page-content">
        <div class="row g-3 mb-4">
            <div class="col-xl-3 col-md-6">
                <a class="stat-card" href="${pageContext.request.contextPath}/SanPhamServlet?action=list">
                    <div class="stat-icon ic-cyan"><i class="bi bi-phone"></i></div>
                    <div>
                        <div class="stat-val">${totalProducts != null ? totalProducts : 0}</div>
                        <div class="stat-lbl">Sản phẩm đang tra cứu</div>
                    </div>
                </a>
            </div>

            <div class="col-xl-3 col-md-6">
                <a class="stat-card" href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list">
                    <div class="stat-icon ic-blue"><i class="bi bi-receipt-cutoff"></i></div>
                    <div>
                        <div class="stat-val">${totalOrders != null ? totalOrders : 0}</div>
                        <div class="stat-lbl">Tổng đơn hàng</div>
                    </div>
                </a>
            </div>

            <div class="col-xl-3 col-md-6">
                <a class="stat-card" href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list">
                    <div class="stat-icon ic-red"><i class="bi bi-chat-square-text"></i></div>
                    <div>
                        <div class="stat-val">${pendingComplaintsCount != null ? pendingComplaintsCount : 0}</div>
                        <div class="stat-lbl">Khiếu nại chờ xử lý</div>
                    </div>
                </a>
            </div>

            <div class="col-xl-3 col-md-6">
                <a class="stat-card" href="${pageContext.request.contextPath}/BaoHanhServlet?action=list">
                    <div class="stat-icon ic-yellow"><i class="bi bi-shield-exclamation"></i></div>
                    <div>
                        <div class="stat-val">${processingWarrantyCount != null ? processingWarrantyCount : 0}</div>
                        <div class="stat-lbl">Bảo hành đang xử lý</div>
                    </div>
                </a>
            </div>
        </div>

        <div class="row g-3">
            <div class="col-xl-8">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title"><i class="bi bi-cart3"></i> Đơn hàng gần đây</div>
                        <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
                           class="btn btn-outline btn-sm">
                            Xem tất cả <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>

                    <div class="card-body p-0">
                        <div class="tbl-wrap">
                            <table class="tbl">
                                <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng thanh toán</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty danhSachDonHang}">
                                        <c:forEach var="dh" items="${danhSachDonHang}" begin="0" end="4">
                                            <c:set var="badgeClass" value="badge-neutral"/>
                                            <c:set var="statusText" value="${dh.trangThai}"/>

                                            <c:choose>
                                                <c:when test="${dh.trangThai == 'CHO_XAC_NHAN'}">
                                                    <c:set var="badgeClass" value="badge-warning"/>
                                                    <c:set var="statusText" value="Chờ xác nhận"/>
                                                </c:when>
                                                <c:when test="${dh.trangThai == 'DANG_GIAO'}">
                                                    <c:set var="badgeClass" value="badge-info"/>
                                                    <c:set var="statusText" value="Đang giao"/>
                                                </c:when>
                                                <c:when test="${dh.trangThai == 'DA_GIAO' || dh.trangThai == 'HOAN_THANH'}">
                                                    <c:set var="badgeClass" value="badge-success"/>
                                                    <c:set var="statusText" value="Đã giao"/>
                                                </c:when>
                                                <c:when test="${dh.trangThai == 'DA_HUY'}">
                                                    <c:set var="badgeClass" value="badge-danger"/>
                                                    <c:set var="statusText" value="Đã hủy"/>
                                                </c:when>
                                            </c:choose>

                                            <tr>
                                                <td><strong>#${dh.idDonHang}</strong></td>
                                                <td>${dh.tenNguoiDung}</td>
                                                <td><fmt:formatDate value="${dh.ngayDat}" pattern="dd/MM/yyyy"/></td>
                                                <td style="font-weight:700">
                                                    <fmt:formatNumber value="${dh.tongThanhToan}" pattern="#,###"/>₫
                                                </td>
                                                <td>
                                                    <span class="badge ${badgeClass}">${statusText}</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${not empty recentOrders}">
                                                <c:forEach var="dh" items="${recentOrders}" begin="0" end="5">
                                                    <tr>
                                                        <td><strong>#${dh.idDonHang}</strong></td>
                                                        <td>
                                                            <div class="item-title">${dh.tenNguoiDung}</div>
                                                            <div class="item-sub">${dh.email}</div>
                                                        </td>
                                                        <td><fmt:formatDate value="${dh.ngayDat}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                        <td style="font-weight:700;white-space:nowrap">
                                                            <fmt:formatNumber value="${dh.tongThanhToan}" pattern="#,###"/>đ
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${dh.trangThai == 'CHO_XAC_NHAN'}">
                                                                    <span class="badge badge-warning">Chờ xác nhận</span>
                                                                </c:when>
                                                                <c:when test="${dh.trangThai == 'DANG_GIAO'}">
                                                                    <span class="badge badge-info">Đang giao</span>
                                                                </c:when>
                                                                <c:when test="${dh.trangThai == 'DA_GIAO'}">
                                                                    <span class="badge badge-success">Đã giao</span>
                                                                </c:when>
                                                                <c:when test="${dh.trangThai == 'DA_HUY'}">
                                                                    <span class="badge badge-danger">Đã hủy</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge badge-neutral">${dh.trangThai}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>

                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="5" class="tbl-no-data">
                                                        <i class="bi bi-inbox"></i> Chưa có đơn hàng
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-4">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title"><i class="bi bi-lightning-charge"></i> Lối tắt xử lý</div>
                    </div>

                    <div class="card-body">
                        <div class="quick-grid">
                            <a class="quick-action" href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list">
                                <i class="bi bi-hourglass-split"></i>
                                <div>
                                    <strong>${pendingOrdersCount != null ? pendingOrdersCount : 0} đơn chờ</strong>
                                    <span>Cập nhật trạng thái</span>
                                </div>
                                <i class="bi bi-chevron-right" style="color:var(--text-muted)"></i>
                            </a>

                            <a class="quick-action" href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list">
                                <i class="bi bi-reply"></i>
                                <div>
                                    <strong>Phản hồi</strong>
                                    <span>Khiếu nại khách hàng</span>
                                </div>
                                <i class="bi bi-chevron-right" style="color:var(--text-muted)"></i>
                            </a>

                            <a class="quick-action" href="${pageContext.request.contextPath}/BaoHanhServlet?action=list">
                                <i class="bi bi-shield-check"></i>
                                <div>
                                    <strong>Bảo hành</strong>
                                    <span>Tra cứu thời hạn</span>
                                </div>
                                <i class="bi bi-chevron-right" style="color:var(--text-muted)"></i>
                            </a>

                            <a class="quick-action" href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=list">
                                <i class="bi bi-tags"></i>
                                <div>
                                    <strong>Mã giảm giá</strong>
                                    <span>Xem chương trình</span>
                                </div>
                                <i class="bi bi-chevron-right" style="color:var(--text-muted)"></i>
                            </a>

                            <a class="quick-action" href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list">
                                <i class="bi bi-receipt-cutoff"></i>
                                <div>
                                    <strong>${donHangChoXacNhan != null ? donHangChoXacNhan : 0} đơn chờ xác nhận</strong>
                                    <span>Xem danh sách đơn hàng</span>
                                </div>
                                <i class="bi bi-chevron-right" style="color:var(--text-muted)"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <div class="card-title"><i class="bi bi-chat-left-dots"></i> Khiếu nại mới</div>
                    </div>

                    <div class="card-body p0">
                        <div class="tbl-wrap">
                            <table class="tbl">
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty listKhieuNai}">
                                        <c:forEach var="kn" items="${listKhieuNai}" begin="0" end="3">
                                            <tr>
                                                <td>
                                                    <div class="item-title">#${kn.idKhieuNai} - ${kn.tenNguoiDung}</div>
                                                    <div class="item-sub">${kn.noiDung}</div>
                                                </td>
                                                <td style="text-align:right">
                                                    <c:choose>
                                                        <c:when test="${kn.trangThai == 'CHO_XU_LY'}">
                                                            <span class="badge badge-danger">Chờ xử lý</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-success">Đã phản hồi</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <tr>
                                            <td class="tbl-no-data">
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
```

   </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
