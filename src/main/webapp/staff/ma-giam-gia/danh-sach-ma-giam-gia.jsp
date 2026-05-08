<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh sách mã giảm giá – Nhân viên</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">

  <%@ include file="/common/sidebar-staff.jsp" %>

  <div class="main-content">

    <div class="topnav">
      <div class="topnav-left">
        <div>
          <div class="page-title">Danh sách mã giảm giá</div>
          <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/StaffServlet?action=dashboard">Trang chủ</a>
            <span>/</span><span>Mã giảm giá</span>
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

      <div class="card">
        <div class="card-header">
            <%-- (id_voucher, ma_code, loai_giam, gia_tri_giam, don_toi_thieu, giam_toi_da, so_luong_gioi_han, ngay_bat_dau, ngay_het_han, trang_thai)--%>
          <div class="card-title"><i class="bi bi-tag-fill"></i> Mã giảm giá</div>
          <form method="get" action="${pageContext.request.contextPath}/MaGiamGiaServlet"
                style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
            <input type="hidden" name="action" value="danhSach">
            <div class="search-wrap">
              <i class="bi bi-search"></i>
              <input type="text" name="keyword" class="form-control"
                     placeholder="Tìm mã code, tên chương trình..." value="${param.keyword}">
            </div>
            <select name="trangThai" class="form-select" style="width:180px">
              <option value="">Tất cả trạng thái</option>
              <option value="dang_hoat_dong" ${param.trangThai=='dang_hoat_dong'?'selected':''}>Đang hoạt động</option>
              <option value="het_han"        ${param.trangThai=='het_han'       ?'selected':''}>Hết hạn</option>
              <option value="het_luot"       ${param.trangThai=='het_luot'      ?'selected':''}>Hết lượt dùng</option>
            </select>
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
                  <th style="width:44px">#</th>
                  <th>Mã code</th>
                  <th>Tên chương trình</th>
                  <th>Loại giảm</th>
                  <th>Giá trị</th>
                  <th>Đơn tối thiểu</th>
                  <th>Hạn dùng</th>
                  <th>Đã dùng / Tổng</th>
                  <th>Trạng thái</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${not empty danhSachMaGiamGia}">
                    <c:forEach var="mg" items="${danhSachMaGiamGia}" varStatus="st">
                      <tr>
                        <td style="color:var(--text-muted)">${st.index + 1}</td>

                        <td>
                          <span style="font-family:monospace;font-weight:700;font-size:13px;
                                       background:var(--bg);border:1px dashed var(--border);
                                       padding:3px 10px;border-radius:6px;color:var(--primary)">
                            ${mg.maCode}
                          </span>
                        </td>

                        <td style="font-weight:600">${mg.tenChuongTrinh}</td>

                        <td>
                          <span class="badge ${mg.loaiGiam=='phan_tram' ? 'badge-info' : 'badge-primary'}">
                            ${mg.loaiGiam=='phan_tram' ? 'Phần trăm (%)' : 'Số tiền cố định'}
                          </span>
                        </td>

                        <td style="font-weight:700;white-space:nowrap;color:var(--success)">
                          <c:choose>
                            <c:when test="${mg.loaiGiam=='phan_tram'}">${mg.giaTriGiam}%</c:when>
                            <c:otherwise>
                              <fmt:formatNumber value="${mg.giaTriGiam}" pattern="#,###"/>₫
                            </c:otherwise>
                          </c:choose>
                        </td>

                        <td style="white-space:nowrap;font-size:12.5px">
                          <fmt:formatNumber value="${mg.donToiThieu}" pattern="#,###"/>₫
                        </td>

                        <td>
                          <div style="font-size:12.5px;
                                      color:${mg.soNgayConLai!=null && mg.soNgayConLai<=3 ? 'var(--danger)' : 'var(--text-muted)'}">
                            <fmt:formatDate value="${mg.ngayHetHan}" pattern="dd/MM/yyyy"/>
                          </div>
                          <c:if test="${mg.soNgayConLai!=null && mg.soNgayConLai>=0 && mg.soNgayConLai<=7}">
                            <div style="font-size:11px;color:var(--danger)">(còn ${mg.soNgayConLai} ngày)</div>
                          </c:if>
                        </td>

                        <td style="text-align:center">
                          <div style="font-size:13px">
                            <strong>${mg.daSDung!=null ? mg.daSDung : 0}</strong>
                            <span style="color:var(--text-muted)"> / ${mg.soLuotDung!=null ? mg.soLuotDung : '∞'}</span>
                          </div>
                          <c:if test="${mg.soLuotDung!=null && mg.soLuotDung>0}">
                            <div style="height:4px;background:var(--bg);border-radius:4px;margin-top:4px;overflow:hidden">
                              <div style="height:100%;background:var(--primary);border-radius:4px;
                                          width:${(mg.daSDung/mg.soLuotDung)*100}%"></div>
                            </div>
                          </c:if>
                        </td>

                        <td>
                          <c:choose>
                            <c:when test="${mg.trangThai=='dang_hoat_dong'}">
                              <span class="badge badge-success">Đang hoạt động</span>
                            </c:when>
                            <c:when test="${mg.trangThai=='het_han'}">
                              <span class="badge badge-danger">Hết hạn</span>
                            </c:when>
                            <c:when test="${mg.trangThai=='het_luot'}">
                              <span class="badge badge-warning">Hết lượt</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge badge-neutral">${mg.trangThai}</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="9" class="tbl-no-data">
                        <i class="bi bi-tag"></i>
                        Không có mã giảm giá nào
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>

          <c:if test="${tongTrang > 1}">
            <div class="tbl-footer">
              <div class="tbl-footer-info">Trang ${trangHienTai} / ${tongTrang} (${tongMaGiamGia} mã)</div>
              <ul class="paging">
                <li class="pg-item ${trangHienTai<=1?'disabled':''}">
                  <a class="pg-link" href="?action=danhSach&trang=${trangHienTai-1}&keyword=${param.keyword}&trangThai=${param.trangThai}"><i class="bi bi-chevron-left"></i></a>
                </li>
                <c:forEach begin="1" end="${tongTrang}" var="i">
                  <li class="pg-item ${i==trangHienTai?'active':''}">
                    <a class="pg-link" href="?action=danhSach&trang=${i}&keyword=${param.keyword}&trangThai=${param.trangThai}">${i}</a>
                  </li>
                </c:forEach>
                <li class="pg-item ${trangHienTai>=tongTrang?'disabled':''}">
                  <a class="pg-link" href="?action=danhSach&trang=${trangHienTai+1}&keyword=${param.keyword}&trangThai=${param.trangThai}"><i class="bi bi-chevron-right"></i></a>
                </li>
              </ul>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
