<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Danh sách đơn hàng"/>
<c:set var="breadcrumb" value="Đơn hàng"/>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh sách đơn hàng – Nhân viên</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">

  <%@ include file="/common/sidebar-staff.jsp" %>

  <div class="main-content">

    <%-- Topnav --%>
    <div class="topnav">
      <div class="topnav-left">
        <div>
          <div class="page-title">Danh sách đơn hàng</div>
          <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/StaffServlet?action=dashboard">Trang chủ</a>
            <span>/</span>
            <span>Đơn hàng</span>
          </div>
        </div>
      </div>
      <div class="topnav-right">
        <div class="topnav-user">
          <div class="avatar">
            <c:choose>
              <c:when test="${not empty sessionScope.hoTen}">${sessionScope.hoTen.charAt(0)}</c:when>
              <c:otherwise>N</c:otherwise>
            </c:choose>
          </div>
          <span class="uname">${not empty sessionScope.hoTen ? sessionScope.hoTen : 'Nhân viên'}</span>
        </div>
      </div>
    </div>

    <div class="page-content">

      <c:if test="${not empty message}">
        <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${message}</div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill"></i> ${error}</div>
      </c:if>

      <%-- Tab trạng thái nhanh --%>
      <div style="display:flex;gap:6px;margin-bottom:16px;flex-wrap:wrap">
        <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach"
           class="btn btn-sm ${empty param.trangThai ? 'btn-primary' : 'btn-outline'}">
          Tất cả
          <c:if test="${not empty tongDonHang}">
            <span style="background:rgba(255,255,255,.25);border-radius:20px;padding:0 6px;margin-left:2px;font-size:11px">${tongDonHang}</span>
          </c:if>
        </a>
        <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach&trangThai=cho_xac_nhan"
           class="btn btn-sm ${param.trangThai=='cho_xac_nhan' ? 'btn-warning' : 'btn-outline'}">
          Chờ xác nhận
        </a>
        <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach&trangThai=dang_giao"
           class="btn btn-sm ${param.trangThai=='dang_giao' ? 'btn-primary' : 'btn-outline'}">
          Đang giao
        </a>
        <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach&trangThai=da_giao"
           class="btn btn-sm ${param.trangThai=='da_giao' ? 'btn-success' : 'btn-outline'}">
          Đã giao
        </a>
        <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach&trangThai=da_huy"
           class="btn btn-sm ${param.trangThai=='da_huy' ? 'btn-danger' : 'btn-outline'}">
          Đã hủy
        </a>
      </div>

      <div class="card">
        <div class="card-header">
          <div class="card-title"><i class="bi bi-cart3"></i> Đơn hàng</div>

          <form method="get" action="${pageContext.request.contextPath}/DonHangServlet"
                style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
            <input type="hidden" name="action"    value="danhSach">
            <input type="hidden" name="trangThai" value="${param.trangThai}">

            <div class="search-wrap">
              <i class="bi bi-search"></i>
              <input type="text" name="keyword" class="form-control"
                     placeholder="Mã đơn, tên khách hàng..." value="${param.keyword}">
            </div>

            <input type="date" name="tuNgay"  class="form-control" style="width:155px"
                   value="${param.tuNgay}"  title="Từ ngày">
            <input type="date" name="denNgay" class="form-control" style="width:155px"
                   value="${param.denNgay}" title="Đến ngày">

            <button type="submit" class="btn btn-primary btn-sm">
              <i class="bi bi-funnel"></i> Lọc
            </button>
          </form>
        </div>

        <div class="card-body p0">
          <div class="tbl-wrap">
            <table class="tbl">
              <thead>
                <tr>
                  <th>#Mã đơn</th>
                  <th>Khách hàng</th>
                  <th>SĐT</th>
                  <th>Ngày đặt</th>
                  <th>Tổng tiền</th>
                  <th>Thanh toán</th>
                  <th>Trạng thái</th>
                  <th style="width:70px">Chi tiết</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${not empty danhSachDonHang}">
                    <c:forEach var="dh" items="${danhSachDonHang}">
                      <tr>
                        <td><strong style="color:var(--primary)">#${dh.maDonHang}</strong></td>

                        <td>${dh.tenKhachHang}</td>

                        <td style="font-size:12.5px;color:var(--text-muted)">${dh.soDienThoai}</td>

                        <td style="font-size:12.5px;white-space:nowrap">
                          <fmt:formatDate value="${dh.ngayDat}" pattern="dd/MM/yyyy"/>
                          <br>
                          <span style="color:var(--text-muted)">
                            <fmt:formatDate value="${dh.ngayDat}" pattern="HH:mm"/>
                          </span>
                        </td>

                        <td style="font-weight:700;white-space:nowrap">
                          <fmt:formatNumber value="${dh.tongTien}" pattern="#,###"/>₫
                        </td>

                        <td>
                          <span class="badge ${dh.daNhanhToan ? 'badge-success' : 'badge-warning'}">
                            ${dh.daNhanhToan ? 'Đã thanh toán' : 'Chưa TT'}
                          </span>
                        </td>

                        <td>
                          <span class="badge
                            <c:choose>
                              <c:when test="${dh.trangThai=='cho_xac_nhan'}">badge-warning</c:when>
                              <c:when test="${dh.trangThai=='dang_giao'}">badge-info</c:when>
                              <c:when test="${dh.trangThai=='da_giao'}">badge-success</c:when>
                              <c:when test="${dh.trangThai=='da_huy'}">badge-danger</c:when>
                              <c:otherwise>badge-neutral</c:otherwise>
                            </c:choose>">
                            <c:choose>
                              <c:when test="${dh.trangThai=='cho_xac_nhan'}">Chờ xác nhận</c:when>
                              <c:when test="${dh.trangThai=='dang_giao'}">Đang giao</c:when>
                              <c:when test="${dh.trangThai=='da_giao'}">Đã giao</c:when>
                              <c:when test="${dh.trangThai=='da_huy'}">Đã hủy</c:when>
                              <c:otherwise>${dh.trangThai}</c:otherwise>
                            </c:choose>
                          </span>
                        </td>

                        <td>
                          <a href="${pageContext.request.contextPath}/DonHangServlet?action=chiTiet&id=${dh.maDonHang}"
                             class="btn btn-outline btn-sm btn-icon" title="Xem chi tiết">
                            <i class="bi bi-eye"></i>
                          </a>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="8" class="tbl-no-data">
                        <i class="bi bi-cart-x"></i>
                        Không có đơn hàng nào
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>

          <%-- Pagination --%>
          <c:if test="${tongTrang > 1}">
            <div class="tbl-footer">
              <div class="tbl-footer-info">
                Trang ${trangHienTai} / ${tongTrang} (${tongDonHang} đơn hàng)
              </div>
              <ul class="paging">
                <li class="pg-item ${trangHienTai<=1?'disabled':''}">
                  <a class="pg-link" href="?action=danhSach&trang=${trangHienTai-1}&trangThai=${param.trangThai}&keyword=${param.keyword}">
                    <i class="bi bi-chevron-left"></i>
                  </a>
                </li>
                <c:forEach begin="1" end="${tongTrang}" var="i">
                  <li class="pg-item ${i==trangHienTai?'active':''}">
                    <a class="pg-link" href="?action=danhSach&trang=${i}&trangThai=${param.trangThai}&keyword=${param.keyword}">${i}</a>
                  </li>
                </c:forEach>
                <li class="pg-item ${trangHienTai>=tongTrang?'disabled':''}">
                  <a class="pg-link" href="?action=danhSach&trang=${trangHienTai+1}&trangThai=${param.trangThai}&keyword=${param.keyword}">
                    <i class="bi bi-chevron-right"></i>
                  </a>
                </li>
              </ul>
            </div>
          </c:if>

        </div><%-- end card-body --%>
      </div><%-- end card --%>
    </div><%-- end page-content --%>
  </div><%-- end main-content --%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
