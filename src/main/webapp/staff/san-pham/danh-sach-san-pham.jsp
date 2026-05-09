<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Danh sách sản phẩm"/>
<c:set var="breadcrumb" value="Sản phẩm / Danh sách"/>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh sách sản phẩm – Nhân viên</title>
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
          <div class="page-title">Danh sách sản phẩm</div>
          <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/StaffServlet?action=dashboard">Trang chủ</a>
            <span>/</span>
            <span>Sản phẩm</span>
            <span>/</span>
            <span>Danh sách</span>
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

      <%-- Flash --%>
      <c:if test="${not empty message}">
        <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${message}</div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill"></i> ${error}</div>
      </c:if>

      <div class="card">
        <%-- Header: tiêu đề + bộ lọc --%>
        <div class="card-header">
          <div class="card-title"><i class="bi bi-box-seam-fill"></i> Sản phẩm</div>

          <form method="get" action="${pageContext.request.contextPath}/SanPhamServlet"
                style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
            <input type="hidden" name="action" value="danhSach">

            <div class="search-wrap">
              <i class="bi bi-search"></i>
              <input type="text" name="keyword" class="form-control"
                     placeholder="Tìm tên sản phẩm..." value="${param.keyword}">
            </div>

            <select name="trangThai" class="form-select" style="width:160px">
              <option value="">Tất cả trạng thái</option>
              <option value="con_hang"  ${param.trangThai=='con_hang'  ? 'selected':''}> Còn hàng</option>
              <option value="het_hang"  ${param.trangThai=='het_hang'  ? 'selected':''}> Hết hàng</option>
              <option value="sap_het"   ${param.trangThai=='sap_het'   ? 'selected':''}> Sắp hết (≤5)</option>
            </select>

            <button type="submit" class="btn btn-primary btn-sm">
              <i class="bi bi-funnel"></i> Lọc
            </button>
          </form>
        </div>

        <%-- Table --%>
        <div class="card-body p0">
          <div class="tbl-wrap">
            <table class="tbl">
              <thead>
                <tr>
                  <th style="width:44px">#</th>
                  <th style="width:56px">Ảnh</th>
                  <th>Tên sản phẩm</th>
                  <th>Danh mục</th>
                  <th>Giá bán</th>
                  <th>Tồn kho</th>
                  <th>Trạng thái</th>
                  <th style="width:130px">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${not empty danhSachSanPham}">
                    <c:forEach var="sp" items="${danhSachSanPham}" varStatus="st">
                      <tr>
                        <td style="color:var(--text-muted)">${(trangHienTai - 1) * soLuongMoiTrang + st.index + 1}</td>

                        <td>
                          <img src="${not empty sp.hinhAnh ? sp.hinhAnh : ''}"
                               class="tbl-img"
                               onerror="this.src='${pageContext.request.contextPath}/assets/img/no-image.png'">
                        </td>

                        <td>
                          <div style="font-weight:600">${sp.tenSanPham}</div>
                          <div style="font-size:11.5px;color:var(--text-muted)">Mã: ${sp.maSanPham}</div>
                        </td>

                        <td>${sp.tenDanhMuc}</td>

                        <td style="font-weight:700;white-space:nowrap">
                          <fmt:formatNumber value="${sp.giaBan}" pattern="#,###"/>₫
                        </td>

                        <%-- Tô màu tồn kho theo ngưỡng --%>
                        <td>
                          <span class="badge
                            <c:choose>
                              <c:when test="${sp.soLuongTon == 0}">badge-danger</c:when>
                              <c:when test="${sp.soLuongTon <= 5}">badge-warning</c:when>
                              <c:otherwise>badge-success</c:otherwise>
                            </c:choose>">
                            ${sp.soLuongTon}
                          </span>
                        </td>

                        <td>
                          <span class="badge ${sp.trangThai ? 'badge-success' : 'badge-neutral'}">
                            ${sp.trangThai ? 'Còn hàng' : 'Hết hàng'}
                          </span>
                        </td>

                        <td>
                          <div style="display:flex;gap:5px">
                            <a href="${pageContext.request.contextPath}/SanPhamServlet?action=capNhatTonKho&id=${sp.maSanPham}"
                               class="btn btn-outline btn-sm btn-icon" title="Cập nhật tồn kho">
                              <i class="bi bi-pencil-square"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/SanPhamServlet?action=quanLyBienThe&id=${sp.maSanPham}"
                               class="btn btn-outline btn-sm btn-icon" title="Quản lý biến thể">
                              <i class="bi bi-diagram-3"></i>
                            </a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="8" class="tbl-no-data">
                        <i class="bi bi-inbox"></i>
                        Không tìm thấy sản phẩm nào
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
                Hiển thị ${(trangHienTai-1)*soLuongMoiTrang + 1}
                – ${trangHienTai*soLuongMoiTrang < tongSanPham ? trangHienTai*soLuongMoiTrang : tongSanPham}
                / ${tongSanPham} sản phẩm
              </div>
              <ul class="paging">
                <li class="pg-item ${trangHienTai <= 1 ? 'disabled':''}">
                  <a class="pg-link" href="?action=danhSach&trang=${trangHienTai-1}&keyword=${param.keyword}&trangThai=${param.trangThai}">
                    <i class="bi bi-chevron-left"></i>
                  </a>
                </li>
                <c:forEach begin="1" end="${tongTrang}" var="i">
                  <li class="pg-item ${i==trangHienTai?'active':''}">
                    <a class="pg-link" href="?action=danhSach&trang=${i}&keyword=${param.keyword}&trangThai=${param.trangThai}">${i}</a>
                  </li>
                </c:forEach>
                <li class="pg-item ${trangHienTai >= tongTrang ? 'disabled':''}">
                  <a class="pg-link" href="?action=danhSach&trang=${trangHienTai+1}&keyword=${param.keyword}&trangThai=${param.trangThai}">
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
