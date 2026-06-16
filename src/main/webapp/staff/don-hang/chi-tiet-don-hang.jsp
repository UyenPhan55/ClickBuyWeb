<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng – CLICKBUY</title>
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
                <div class="page-title">
                    Chi tiết đơn hàng #${donHang.idDonHang}
                </div>
                <div class="breadcrumb-nav">
                    <a href="${pageContext.request.contextPath}/StaffServlet">Trang chủ</a>
                    <span>/</span>
                    <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list">
                        Đơn hàng
                    </a>
                    <span>/</span>
                    <span>Chi tiết</span>
                </div>
            </div>
            <div class="topnav-right">
                <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
                   class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
                <div class="topnav-user">
                    <div class="avatar">
                        ${not empty sessionScope.user
                            ? sessionScope.user.tenDayDu.charAt(0) : 'N'}
                    </div>
                    <span class="uname">
                        ${not empty sessionScope.user
                            ? sessionScope.user.tenDayDu : 'Nhân viên'}
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
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i> ${error}
                </div>
            </c:if>

            <div class="row g-3">

                <%-- CỘT TRÁI --%>
                <div class="col-xl-8">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <div class="card-title">
                                <i class="bi bi-bag-check"></i> Sản phẩm trong đơn
                            </div>
                            <c:choose>
                                <c:when test="${donHang.trangThai=='CHO_XAC_NHAN'}">
                                    <span class="badge bg-warning text-dark">Chờ xác nhận</span>
                                </c:when>
                                <c:when test="${donHang.trangThai=='DANG_GIAO'}">
                                    <span class="badge bg-info">Đang giao</span>
                                </c:when>
                                <c:when test="${donHang.trangThai=='DA_GIAO'
                                           || donHang.trangThai=='HOAN_THANH'}">
                                    <span class="badge bg-success">Hoàn thành</span>
                                </c:when>
                                <c:when test="${donHang.trangThai=='DA_HUY'}">
                                    <span class="badge bg-danger">Đã hủy</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${donHang.trangThai}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-body p-0">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Biến thể</th>
                                        <th>Đơn giá</th>
                                        <th class="text-center">SL</th>
                                        <th class="text-end">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty chiTietDonHang}">
                                            <c:forEach var="item" items="${chiTietDonHang}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <img src="${not empty item.urlAnh
                                                                ? pageContext.request.contextPath.concat('/uploads/san-pham/').concat(item.urlAnh)
                                                                : 'https://placehold.co/44x44?text=SP'}"
                                                                 style="width:44px;height:44px;
                                                                        object-fit:cover;
                                                                        border-radius:8px;"
                                                                 onerror="this.src='https://placehold.co/44x44?text=SP'">
                                                            
                                                            <%--  Sửa: tenSanPham thay idSanPham --%>                                           
                                                            <div class="fw-bold">
                                                                
                                                                ${item.tenSanPham}
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-muted" style="font-size:12.5px">
                                                        ${not empty item.tenBienThe
                                                            ? item.tenBienThe : '—'}
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${item.donGia}"
                                                                          pattern="#,###"/>₫
                                                    </td>
                                                    <td class="text-center fw-bold">
                                                        ${item.soLuong}
                                                    </td>
                                                    <td class="text-end fw-bold">
                                                        <fmt:formatNumber value="${item.thanhTien}"
                                                                          pattern="#,###"/>₫
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5"
                                                    class="text-center py-4 text-muted">
                                                    <i class="bi bi-bag-x"></i>
                                                    Không có sản phẩm
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>

                            <%-- Tổng cộng --%>
                            <div class="p-3 border-top">
                                <div class="d-flex justify-content-end">
                                    <div style="min-width:260px">
                                        <div class="d-flex justify-content-between py-1 text-muted"
                                             style="font-size:13px">
                                            <span>Tạm tính</span>
                                            <span>
                                                <fmt:formatNumber value="${donHang.tamTinh}"
                                                                  pattern="#,###"/>₫
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between py-1 text-success"
                                             style="font-size:13px">
                                            <span>Giảm giá</span>
                                            <span>
                                                - <fmt:formatNumber value="${donHang.giamGia}"
                                                                    pattern="#,###"/>₫
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between pt-2 mt-1
                                                    border-top fw-bold"
                                             style="font-size:17px;color:#d70018">
                                            <span>Tổng cộng</span>
                                            <span>
                                                <fmt:formatNumber value="${donHang.tongThanhToan}"
                                                                  pattern="#,###"/>₫
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- Cập nhật trạng thái --%>
                    <div class="card mt-3">
                        <div class="card-header">
                            <div class="card-title">
                                <i class="bi bi-arrow-repeat"></i> Cập nhật trạng thái
                            </div>
                        </div>
                        <div class="card-body">
                            <%--  Sửa: method GET thay POST --%>
                            <form method="post"
                                  action="${pageContext.request.contextPath}/DonHangServlet"
                                  class="d-flex gap-2 align-items-end flex-wrap">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="idDonHang" value="${donHang.idDonHang}">

                                <div style="flex:1;min-width:200px">
                                    <label class="form-label">Trạng thái mới</label>
                                    <select name="trangThai" class="form-select" required>
                                        <option value="CHO_XAC_NHAN"
                                            ${donHang.trangThai=='CHO_XAC_NHAN'?'selected':''}>
                                            Chờ xác nhận
                                        </option>
                                        <option value="DA_XAC_NHAN"
                                            ${donHang.trangThai=='DA_XAC_NHAN'?'selected':''}>
                                            Đã xác nhận
                                        </option>
                                        <option value="DANG_CHUAN_BI"
                                            ${donHang.trangThai=='DANG_CHUAN_BI'?'selected':''}>
                                            Đang chuẩn bị
                                        </option>
                                        <option value="DANG_GIAO"
                                            ${donHang.trangThai=='DANG_GIAO'?'selected':''}>
                                            Đang giao
                                        </option>
                                        <option value="DA_GIAO"
                                            ${donHang.trangThai=='DA_GIAO'?'selected':''}>
                                            Đã giao
                                        </option>
                                        <option value="HOAN_THANH"
                                            ${donHang.trangThai=='HOAN_THANH'?'selected':''}>
                                            Hoàn thành
                                        </option>
                                        <option value="DA_HUY"
                                            ${donHang.trangThai=='DA_HUY'?'selected':''}>
                                            Đã hủy
                                        </option>
                                    </select>
                                </div>

                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-lg"></i> Xác nhận
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <%-- CỘT PHẢI --%>
                <div class="col-xl-4">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                                <i class="bi bi-person-fill"></i> Thông tin khách hàng
                            </div>
                        </div>
                        <div class="card-body d-flex flex-column gap-3">
                            <div>
                                <div class="text-muted"
                                     style="font-size:11px;text-transform:uppercase">
                                    Họ tên
                                </div>
                                <div class="fw-bold">${donHang.tenNguoiDung}</div>
                            </div>
                            <div>
                                <div class="text-muted"
                                     style="font-size:11px;text-transform:uppercase">
                                    Email
                                </div>
                                <div>${donHang.email}</div>
                            </div>
                            <div>
                                <div class="text-muted"
                                     style="font-size:11px;text-transform:uppercase">
                                    SĐT nhận hàng
                                </div>
                                <div class="fw-bold">${donHang.sdtNguoiNhan}</div>
                            </div>
                            <div>
                                <div class="text-muted"
                                     style="font-size:11px;text-transform:uppercase">
                                    Địa chỉ giao hàng
                                </div>
                                <div>${donHang.diaChi}</div>
                            </div>
                        </div>
                    </div>

                    <div class="card mt-3">
                        <div class="card-header">
                            <div class="card-title">
                                <i class="bi bi-credit-card-fill"></i> Thông tin đơn hàng
                            </div>
                        </div>
                        <div class="card-body d-flex flex-column gap-3">
                            <div>
                                <div class="text-muted"
                                     style="font-size:11px;text-transform:uppercase">
                                    Ngày đặt
                                </div>
                                <div style="font-size:13px">
                                    <fmt:formatDate value="${donHang.ngayDat}"
                                                    pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>
                            <c:if test="${not empty donHang.idVoucher}">
                                <div>
                                    <div class="text-muted"
                                         style="font-size:11px;text-transform:uppercase">
                                        Voucher áp dụng
                                    </div>
                                    <span class="badge bg-primary">
                                        <i class="bi bi-tag-fill"></i> #${donHang.idVoucher}
                                    </span>
                                </div>
                            </c:if>
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