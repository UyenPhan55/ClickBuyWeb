<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
  <title>Danh sách người dùng – Nhân viên</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">

  <%@ include file="/common/sidebar-staff.jsp" %>
  <div class="main-content">
  <%@ include file="/common/topnav-staff.jsp" %>
    <div class="page-content">

      <c:if test="${not empty message}">
        <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${message}</div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill"></i> ${error}</div>
      </c:if>

      <div class="alert alert-info">
        <i class="bi bi-info-circle-fill"></i>
        Nhân viên chỉ có quyền <strong>xem thông tin</strong> người dùng.
        Phân quyền và khóa tài khoản do <strong>Admin</strong> thực hiện.
      </div>

      <div class="card">
        <div class="card-header">
          <div class="card-title"><i class="bi bi-people-fill"></i> Người dùng</div>

          <form method="get" action="${pageContext.request.contextPath}/NguoiDungServlet"
                style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
            <input type="hidden" name="action" value="danhSach">
            <div class="search-wrap">
              <i class="bi bi-search"></i>
              <input type="text" name="keyword" class="form-control"
                     placeholder="Tìm tên, email, SĐT..." value="${param.keyword}">
            </div>
            <select name="trangThai" class="form-select" style="width:160px">
              <option value="">Tất cả trạng thái</option>
              <option value="hoat_dong" ${param.trangThai=='hoat_dong'?'selected':''}>Hoạt động</option>
              <option value="bi_khoa"   ${param.trangThai=='bi_khoa'  ?'selected':''}>Bị khóa</option>
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
                  <th>Họ tên</th>
                  <th>Email</th>
                  <th>Số điện thoại</th>
                  <th>Ngày đăng ký</th>
                  <th>Số đơn hàng</th>
                  <th>Trạng thái</th>
                  <th style="width:80px">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${not empty danhSachNguoiDung}">
                    <c:forEach var="nd" items="${danhSachNguoiDung}" varStatus="st">
                      <tr>
                        <td style="color:var(--text-muted)">
                          ${(trangHienTai-1)*soLuongMoiTrang + st.index + 1}
                        </td>
                        <td>
                          <div style="display:flex;align-items:center;gap:10px">
                            <div style="width:36px;height:36px;border-radius:50%;
                                        background:linear-gradient(135deg,var(--primary),var(--accent));
                                        display:flex;align-items:center;justify-content:center;
                                        color:#fff;font-weight:700;font-size:13px;flex-shrink:0">
                              ${nd.hoTen.charAt(0)}
                            </div>
                            <div>
                              <div style="font-weight:600">${nd.hoTen}</div>
                              <div style="font-size:11.5px;color:var(--text-muted)">Mã: ${nd.maNguoiDung}</div>
                            </div>
                          </div>
                        </td>
                        <td style="font-size:13px">${nd.email}</td>
                        <td style="font-size:13px">${nd.soDienThoai}</td>
                        <td style="font-size:12.5px;color:var(--text-muted);white-space:nowrap">
                          <fmt:formatDate value="${nd.ngayTao}" pattern="dd/MM/yyyy"/>
                        </td>
                        <td style="text-align:center">
                          <span class="badge badge-primary">
                            ${nd.soDonHang != null ? nd.soDonHang : 0}
                          </span>
                        </td>
                        <td>
                          <span class="badge ${nd.trangThai ? 'badge-success' : 'badge-danger'}">
                            ${nd.trangThai ? 'Hoạt động' : 'Bị khóa'}
                          </span>
                        </td>
                        <td>
                          <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach&maNguoiDung=${nd.maNguoiDung}"
                             class="btn btn-outline btn-sm btn-icon" title="Xem đơn hàng của khách này">
                            <i class="bi bi-cart3"></i>
                          </a>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="8" class="tbl-no-data">
                        <i class="bi bi-people"></i>
                        Không tìm thấy người dùng nào
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>

          <c:if test="${tongTrang > 1}">
            <div class="tbl-footer">
              <div class="tbl-footer-info">
                Hiển thị ${(trangHienTai-1)*soLuongMoiTrang+1}
                – ${trangHienTai*soLuongMoiTrang < tongNguoiDung ? trangHienTai*soLuongMoiTrang : tongNguoiDung}
                / ${tongNguoiDung} người dùng
              </div>
              <ul class="paging">
                <li class="pg-item ${trangHienTai<=1?'disabled':''}">
                  <a class="pg-link" href="?action=danhSach&trang=${trangHienTai-1}&keyword=${param.keyword}&trangThai=${param.trangThai}">
                    <i class="bi bi-chevron-left"></i>
                  </a>
                </li>
                <c:forEach begin="1" end="${tongTrang}" var="i">
                  <li class="pg-item ${i==trangHienTai?'active':''}">
                    <a class="pg-link" href="?action=danhSach&trang=${i}&keyword=${param.keyword}&trangThai=${param.trangThai}">${i}</a>
                  </li>
                </c:forEach>
                <li class="pg-item ${trangHienTai>=tongTrang?'disabled':''}">
                  <a class="pg-link" href="?action=danhSach&trang=${trangHienTai+1}&keyword=${param.keyword}&trangThai=${param.trangThai}">
                    <i class="bi bi-chevron-right"></i>
                  </a>
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
