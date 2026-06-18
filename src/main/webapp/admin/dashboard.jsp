<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Dashboard Admin"/>
<c:set var="breadcrumb" value="Tổng quan hệ thống"/>
<c:set var="activeMenu" value="dashboard" scope="request"/>

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
            <div class="row g-3 mb-4">
                <div class="col-xl-3 col-md-6">
                    <a class="stat-card" href="${pageContext.request.contextPath}/SanPhamServlet?action=list">
                        <div class="stat-icon ic-blue"><i class="bi bi-box-seam"></i></div>
                        <div>
                            <div class="stat-val">${totalProducts != null ? totalProducts : 0}</div>
                            <div class="stat-lbl">Sản phẩm</div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6">
                    <a class="stat-card" href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list">
                        <div class="stat-icon ic-green"><i class="bi bi-cart3"></i></div>
                        <div>
                            <div class="stat-val">${totalOrders != null ? totalOrders : 0}</div>
                            <div class="stat-lbl">Đơn hàng</div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6">
                    <a class="stat-card" href="${pageContext.request.contextPath}/NguoiDungServlet?action=list">
                        <div class="stat-icon ic-purple"><i class="bi bi-people"></i></div>
                        <div>
                            <div class="stat-val">${totalUsers != null ? totalUsers : 0}</div>
                            <div class="stat-lbl">Tài khoản</div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6">
                    <a class="stat-card" href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=list">
                        <div class="stat-icon ic-yellow"><i class="bi bi-tags"></i></div>
                        <div>
                            <div class="stat-val">${totalVouchers != null ? totalVouchers : 0}</div>
                            <div class="stat-lbl">Mã giảm giá</div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6">
                    <a class="stat-card" href="${pageContext.request.contextPath}/BaoHanhServlet?action=list">
                        <div class="stat-icon ic-cyan"><i class="bi bi-shield-check"></i></div>
                        <div>
                            <div class="stat-val">${totalWarranties != null ? totalWarranties : 0}</div>
                            <div class="stat-lbl">Bảo hành</div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6">
                    <a class="stat-card" href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list">
                        <div class="stat-icon ic-red"><i class="bi bi-exclamation-triangle"></i></div>
                        <div>
                            <div class="stat-val">${totalComplaints != null ? totalComplaints : 0}</div>
                            <div class="stat-lbl">Khiếu nại</div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6">
                    <a class="stat-card" href="${pageContext.request.contextPath}/LichSuHoatDongServlet?action=list">
                        <div class="stat-icon ic-purple"><i class="bi bi-clock-history"></i></div>
                        <div>
                            <div class="stat-val">${totalLogs != null ? totalLogs : 0}</div>
                            <div class="stat-lbl">Lịch sử hệ thống</div>
                        </div>
                    </a>
                </div>
            </div>

            <div class="row g-3">
                <div class="col-xl-7">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title"><i class="bi bi-receipt"></i> Đơn hàng gần đây</div>
                            <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list">
                                Xem tất cả <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                        <div class="card-body p0">
                            <div class="tbl-wrap">
                                <table class="tbl">
                                    <thead>
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Khách hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty recentOrders}">
                                            <c:forEach var="dh" items="${recentOrders}" begin="0" end="5">
                                                <tr>
                                                    <td><strong>#${dh.idDonHang}</strong></td>
                                                    <td>
                                                        <div style="font-weight:700">${dh.tenNguoiDung}</div>
                                                        <div style="font-size:11.5px;color:var(--text-muted)">${dh.email}</div>
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
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-5">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title"><i class="bi bi-clock-history"></i> Lịch sử gần đây</div>
                            <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/LichSuHoatDongServlet?action=list">
                                Xem log <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                        <div class="card-body p0">
                            <div class="tbl-wrap">
                                <table class="tbl">
                                    <thead>
                                    <tr>
                                        <th>Người dùng</th>
                                        <th>Hành động</th>
                                        <th>Thời gian</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty recentLogs}">
                                            <c:forEach var="log" items="${recentLogs}" begin="0" end="6">
                                                <tr>
                                                    <td>
                                                        <div style="font-weight:700">${log.tenNguoiDung}</div>
                                                        <div style="font-size:11.5px;color:var(--text-muted)">${log.email}</div>
                                                    </td>
                                                    <td>
                                                        <div>${log.hanhDong}</div>
                                                        <div style="font-size:11.5px;color:var(--text-muted)">
                                                            ${log.bangTacDong} #${log.idDoiTuong}
                                                        </div>
                                                    </td>
                                                    <td style="white-space:nowrap">
                                                        <fmt:formatDate value="${log.thoiGian}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="3" class="tbl-no-data">
                                                    <i class="bi bi-inbox"></i> Chưa có log
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
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
