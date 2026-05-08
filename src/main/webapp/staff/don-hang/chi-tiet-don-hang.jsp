<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi tiết đơn hàng – Nhân viên</title>
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
          <div class="page-title">Chi tiết đơn hàng #${donHang.idDonHang}</div>
          <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/StaffServlet?action=dashboard">Trang chủ</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach">Đơn hàng</a>
            <span>/</span>
            <span>Chi tiết</span>
          </div>
        </div>
      </div>
      <div class="topnav-right">
        <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach"
           class="btn btn-outline btn-sm">
          <i class="bi bi-arrow-left"></i> Quay lại
        </a>
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

      <div class="row g-3">

        <%-- ── CỘT TRÁI (8/12): Sản phẩm + Cập nhật trạng thái ── --%>
        <div class="col-xl-8">

          <%-- Danh sách sản phẩm trong đơn --%>
          <div class="card">
            <div class="card-header">
              <div class="card-title"><i class="bi bi-bag-check"></i> Sản phẩm trong đơn</div>
              <span class="badge
                <c:choose>
                  <c:when test="${donHang.trangThai=='CHO_XAC_NHAN'}">badge-warning</c:when>
                  <c:when test="${donHang.trangThai=='DANG_GIAO'}">badge-info</c:when>
                  <c:when test="${donHang.trangThai=='DA_GIAO'}">badge-success</c:when>
                  <c:when test="${donHang.trangThai=='DA_HUY'}">badge-danger</c:when>
                  <c:otherwise>badge-neutral</c:otherwise>
                </c:choose>">
                <c:choose>
                  <c:when test="${donHang.trangThai=='CHO_XAC_NHAN'}">Chờ xác nhận</c:when>
                  <c:when test="${donHang.trangThai=='DANG_GIAO'}">Đang giao</c:when>
                  <c:when test="${donHang.trangThai=='DA_GIAO'}">Đã giao</c:when>
                  <c:when test="${donHang.trangThai=='DA_HUY'}">Đã hủy</c:when>
                  <c:otherwise>${donHang.trangThai}</c:otherwise>
                </c:choose>
              </span>
            </div>
            <div class="card-body p0">
              <table class="tbl">
                <thead>
                  <tr>
                    <th>Sản phẩm</th>
                    <th>Biến thể</th>
                    <th>Đơn giá</th>
                    <th style="text-align:center">SL</th>
                    <th style="text-align:right">Thành tiền</th>
                  </tr>
                </thead>
                <tbody>
                  <c:choose>
                    <c:when test="${not empty chiTietDonHang}">
                      <c:forEach var="item" items="${chiTietDonHang}">
                        <tr>
                          <td>
                            <div style="display:flex;gap:10px;align-items:center">
                              <img src="${not empty item.hinhAnh ? item.hinhAnh : ''}"
                                   style="width:44px;height:44px;object-fit:cover;border-radius:8px;border:1px solid var(--border);flex-shrink:0"
                                   onerror="this.style.display='none'">
                              <div>
                                <div style="font-weight:600">${item.tenSanPham}</div>
                                <div style="font-size:11.5px;color:var(--text-muted)">Mã: ${item.maSanPham}</div>
                              </div>
                            </div>
                          </td>
                          <td style="font-size:12.5px;color:var(--text-muted)">
                            ${not empty item.tenBienThe ? item.tenBienThe : '—'}
                          </td>
                          <td style="white-space:nowrap">
                            <fmt:formatNumber value="${item.donGia}" pattern="#,###"/>₫
                          </td>
                          <td style="text-align:center;font-weight:700">${item.soLuong}</td>
                          <td style="text-align:right;font-weight:700;white-space:nowrap">
                            <fmt:formatNumber value="${item.thanhTien}" pattern="#,###"/>₫
                          </td>
                        </tr>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <tr>
                        <td colspan="5" class="tbl-no-data">
                          <i class="bi bi-bag-x"></i> Không có sản phẩm
                        </td>
                      </tr>
                    </c:otherwise>
                  </c:choose>
                </tbody>
              </table>

              <%-- Tổng cộng --%>
              <div style="padding:16px 20px;border-top:1px solid var(--border)">
                <div style="display:flex;justify-content:flex-end">
                  <div style="min-width:260px">
                    <div style="display:flex;justify-content:space-between;padding:4px 0;font-size:13px;color:var(--text-muted)">
                      <span>Tạm tính</span>
                      <span><fmt:formatNumber value="${donHang.tamTinh}" pattern="#,###"/>₫</span>
                    </div>
                    <div style="display:flex;justify-content:space-between;padding:4px 0;font-size:13px;color:var(--success)">
                      <span>Giảm giá</span>
                      <span>- <fmt:formatNumber value="${donHang.giamGia}" pattern="#,###"/>₫</span>
                    </div>
                    <div style="display:flex;justify-content:space-between;padding:4px 0;font-size:13px;color:var(--text-muted)">
                      <span>Phí vận chuyển</span>
                      <span><fmt:formatNumber value="${donHang.phiShip}" pattern="#,###"/>₫</span>
                    </div>
                    <div style="display:flex;justify-content:space-between;padding:10px 0 0;margin-top:6px;border-top:2px solid var(--border);font-weight:800;font-size:17px;color:var(--primary)">
                      <span>Tổng cộng</span>
                      <span><fmt:formatNumber value="${donHang.tongTien}" pattern="#,###"/>₫</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div><%-- end card sản phẩm --%>

          <%-- Cập nhật trạng thái đơn hàng --%>
          <div class="card">
            <div class="card-header">
              <div class="card-title"><i class="bi bi-arrow-repeat"></i> Cập nhật trạng thái đơn hàng</div>
            </div>
            <div class="card-body">
              <form method="post" action="${pageContext.request.contextPath}/DonHangServlet"
                    style="display:flex;gap:10px;align-items:flex-end;flex-wrap:wrap">
                <input type="hidden" name="action"      value="capNhatTrangThai">
                <input type="hidden" name="idDonHang"  value="${donHang.idDonHang}">

                <div style="flex:1;min-width:200px">
                  <label class="form-label">Trạng thái mới <span class="req">*</span></label>
                  <select name="trangThai" class="form-select" required>
                    <option value="CHO_XAC_NHAN" ${donHang.trangThai=='CHO_XAC_NHAN'?'selected':''}>Chờ xác nhận</option>
                    <option value="DANG_GIAO"    ${donHang.trangThai=='DANG_GIAO'   ?'selected':''}>Đang giao</option>
                    <option value="DA_GIAO"      ${donHang.trangThai=='DA_GIAO'     ?'selected':''}>Đã giao</option>
                    <option value="DA_HUY"       ${donHang.trangThai=='DA_HUY'      ?'selected':''}>Đã hủy</option>
                  </select>
                </div>

                <div style="flex:2;min-width:200px">
                  <label class="form-label">Ghi chú</label>
                  <input type="text" name="ghiChu" class="form-control"
                         placeholder="Lý do cập nhật (nếu có)...">
                </div>

                <button type="submit" class="btn btn-primary" style="flex-shrink:0">
                  <i class="bi bi-check-lg"></i> Xác nhận
                </button>
              </form>
            </div>
          </div>

        </div><%-- end col-left --%>

        <%-- ── CỘT PHẢI (4/12): Thông tin KH + Thanh toán ── --%>
        <div class="col-xl-4">

          <%-- Thông tin khách hàng --%>
          <div class="card">
            <div class="card-header">
              <div class="card-title"><i class="bi bi-person-fill"></i> Thông tin khách hàng</div>
            </div>
            <div class="card-body" style="display:flex;flex-direction:column;gap:12px">

              <div>
                <div style="font-size:11px;color:var(--text-muted);text-transform:uppercase;letter-spacing:.5px;margin-bottom:3px">Mã người dùng</div>
                <div style="font-weight:600">#${donHang.idNguoiDung}</div>
              </div>

              <div>
                <div style="font-size:11px;color:var(--text-muted);text-transform:uppercase;letter-spacing:.5px;margin-bottom:3px">Số điện thoại nhận hàng</div>
                <div style="font-weight:600">${donHang.sdtNguoiNhan}</div>
              </div>

              <div>
                <div style="font-size:11px;color:var(--text-muted);text-transform:uppercase;letter-spacing:.5px;margin-bottom:3px">Địa chỉ giao hàng</div>
                <div style="line-height:1.5">${donHang.diaChi}</div>
              </div>

            </div>
          </div>

          <%-- Thông tin đơn hàng --%>
          <div class="card">
            <div class="card-header">
              <div class="card-title"><i class="bi bi-credit-card-fill"></i> Thông tin đơn hàng</div>
            </div>
            <div class="card-body" style="display:flex;flex-direction:column;gap:12px">

              <div>
                <div style="font-size:11px;color:var(--text-muted);text-transform:uppercase;letter-spacing:.5px;margin-bottom:3px">Ngày đặt hàng</div>
                <div style="font-size:13px">
                  <fmt:formatDate value="${donHang.ngayDat}" pattern="dd/MM/yyyy"/>
                </div>
              </div>

              <div>
                <div style="font-size:11px;color:var(--text-muted);text-transform:uppercase;letter-spacing:.5px;margin-bottom:3px">Trạng thái</div>
                <span class="badge
                  <c:choose>
                    <c:when test="${donHang.trangThai=='CHO_XAC_NHAN'}">badge-warning</c:when>
                    <c:when test="${donHang.trangThai=='DANG_GIAO'}">badge-info</c:when>
                    <c:when test="${donHang.trangThai=='DA_GIAO'}">badge-success</c:when>
                    <c:when test="${donHang.trangThai=='DA_HUY'}">badge-danger</c:when>
                    <c:otherwise>badge-neutral</c:otherwise>
                  </c:choose>">
                  <c:choose>
                    <c:when test="${donHang.trangThai=='CHO_XAC_NHAN'}">Chờ xác nhận</c:when>
                    <c:when test="${donHang.trangThai=='DANG_GIAO'}">Đang giao</c:when>
                    <c:when test="${donHang.trangThai=='DA_GIAO'}">Đã giao</c:when>
                    <c:when test="${donHang.trangThai=='DA_HUY'}">Đã hủy</c:when>
                    <c:otherwise>${donHang.trangThai}</c:otherwise>
                  </c:choose>
                </span>
              </div>

              <%-- Voucher: NULL thì không hiện --%>
              <c:if test="${not empty donHang.idVoucher}">
                <div>
                  <div style="font-size:11px;color:var(--text-muted);text-transform:uppercase;letter-spacing:.5px;margin-bottom:3px">Mã voucher áp dụng</div>
                  <span class="badge badge-primary">
                    <i class="bi bi-tag-fill"></i> #${donHang.idVoucher}
                  </span>
                </div>
              </c:if>

            </div>
          </div>

        </div><%-- end col-right --%>
      </div><%-- end row --%>
    </div><%-- end page-content --%>
  </div><%-- end main-content --%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
