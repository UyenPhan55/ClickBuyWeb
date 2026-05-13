<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn hàng – CLICKBUY</title>
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
                <div class="page-title">Danh sách đơn hàng</div>
            </div>
            <div class="topnav-right">
                <%--  Sửa: sessionScope.user.tenDayDu --%>
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

            <%-- Tab lọc trạng thái --%>
            <div class="d-flex gap-2 mb-3 flex-wrap">
                <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
                   class="btn btn-sm ${empty param.trangThai ? 'btn-primary' : 'btn-outline-secondary'}">
                    Tất cả
                </a>
                <%--  Sửa: value uppercase khớp DB --%>
                <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list&trangThai=CHO_XAC_NHAN"
                   class="btn btn-sm ${param.trangThai=='CHO_XAC_NHAN' ? 'btn-warning' : 'btn-outline-secondary'}">
                    Chờ xác nhận
                </a>
                <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list&trangThai=DANG_GIAO"
                   class="btn btn-sm ${param.trangThai=='DANG_GIAO' ? 'btn-primary' : 'btn-outline-secondary'}">
                    Đang giao
                </a>
                <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list&trangThai=HOAN_THANH"
                   class="btn btn-sm ${param.trangThai=='HOAN_THANH' ? 'btn-success' : 'btn-outline-secondary'}">
                    Hoàn thành
                </a>
                <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list&trangThai=DA_HUY"
                   class="btn btn-sm ${param.trangThai=='DA_HUY' ? 'btn-danger' : 'btn-outline-secondary'}">
                    Đã hủy
                </a>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-cart3"></i> Đơn hàng
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>#Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>SĐT</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Cập nhật</th>
                                <th>Chi tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty orderList}">
                                    <c:forEach var="dh" items="${orderList}">
                                        <tr>
                                            <%--  Sửa: idDonHang thay maDonHang --%>
                                            <td>
                                                <strong style="color:#d70018">
                                                    #CB${dh.idDonHang}
                                                </strong>
                                            </td>
                                            <%--  Sửa: tenNguoiDung từ JOIN --%>
                                            <td>${dh.tenNguoiDung}</td>
                                            <%--  Sửa: sdtNguoiNhan thay soDienThoai --%>
                                            <td style="font-size:12.5px">${dh.sdtNguoiNhan}</td>
                                            <td style="font-size:12.5px;white-space:nowrap">
                                                <fmt:formatDate value="${dh.ngayDat}"
                                                                pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td class="fw-bold" style="white-space:nowrap">
                                                <%--  Sửa: tongThanhToan thay tongTien --%>
                                                <fmt:formatNumber value="${dh.tongThanhToan}"
                                                                  pattern="#,###"/>₫
                                            </td>
                                            <td>
                                                <%--  Sửa: uppercase khớp DB --%>
                                                <c:choose>
                                                    <c:when test="${dh.trangThai=='CHO_XAC_NHAN'}">
                                                        <span class="badge bg-warning text-dark">
                                                            Chờ xác nhận
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${dh.trangThai=='DA_XAC_NHAN'}">
                                                        <span class="badge bg-info">Đã xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${dh.trangThai=='DANG_GIAO'}">
                                                        <span class="badge bg-primary">Đang giao</span>
                                                    </c:when>
                                                    <c:when test="${dh.trangThai=='HOAN_THANH'}">
                                                        <span class="badge bg-success">Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${dh.trangThai=='DA_HUY'}">
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">
                                                            ${dh.trangThai}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/DonHangServlet"
                                                      method="get" class="d-flex gap-1">
                                                    <input type="hidden" name="action"
                                                           value="updateStatus">
                                                    <input type="hidden" name="id"
                                                           value="${dh.idDonHang}">
                                                    <select name="status"
                                                            class="form-select form-select-sm"
                                                            style="width:auto;font-size:12px">
                                                        <option value="CHO_XAC_NHAN">Chờ xác nhận</option>
                                                        <option value="DA_XAC_NHAN">Đã xác nhận</option>
                                                        <option value="DANG_CHUAN_BI">Đang chuẩn bị</option>
                                                        <option value="DANG_GIAO">Đang giao</option>
                                                        <option value="DA_GIAO">Đã giao</option>
                                                        <option value="HOAN_THANH">Hoàn thành</option>
                                                        <option value="DA_HUY">Đã hủy</option>
                                                    </select>
                                                    <button class="btn btn-sm btn-primary">Lưu</button>
                                                </form>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/DonHangServlet?action=detail&id=${dh.idDonHang}"
                                                   class="btn btn-sm btn-outline-secondary">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center py-4 text-muted">
                                            <i class="bi bi-cart-x fs-4"></i>
                                            <div>Không có đơn hàng nào</div>
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