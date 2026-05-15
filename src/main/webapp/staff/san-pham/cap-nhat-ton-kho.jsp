<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Cập nhật tồn kho"/>
<c:set var="breadcrumb" value="Sản phẩm / Tồn kho"/>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cập nhật tồn kho – Nhân viên</title>
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

      <div class="row g-3">

        <%-- ── CỘT TRÁI: Form cập nhật ── --%>
        <div class="col-xl-5">
          <div class="card">
            <div class="card-header">
              <div class="card-title"><i class="bi bi-pencil-square"></i> Cập nhật tồn kho</div>
            </div>
            <div class="card-body">

              <%-- Thông tin sản phẩm đang chọn --%>
              <c:if test="${not empty sanPham}">
                <div style="display:flex;gap:14px;align-items:center;padding:14px;background:var(--bg);border-radius:var(--radius-sm);margin-bottom:20px">
                  <img src="${not empty sanPham.hinhAnh ? sanPham.hinhAnh : ''}"
                       style="width:58px;height:58px;object-fit:cover;border-radius:10px;border:1px solid var(--border);flex-shrink:0"
                       onerror="this.style.display='none'">
                  <div>
                    <div style="font-weight:700;font-size:14px">${sanPham.tenSanPham}</div>
                    <div style="color:var(--text-muted);font-size:12px;margin-top:2px">
                      Mã: ${sanPham.maSanPham} &nbsp;|&nbsp; ${sanPham.tenDanhMuc}
                    </div>
                    <div style="margin-top:6px">
                      <span class="badge
                        <c:choose>
                          <c:when test="${sanPham.soLuongTon == 0}">badge-danger</c:when>
                          <c:when test="${sanPham.soLuongTon <= 5}">badge-warning</c:when>
                          <c:otherwise>badge-success</c:otherwise>
                        </c:choose>">
                        <i class="bi bi-box-seam"></i>
                        Tồn kho hiện tại: ${sanPham.soLuongTon}
                      </span>
                    </div>
                  </div>
                </div>
              </c:if>

              <form method="post" action="${pageContext.request.contextPath}/SanPhamServlet">
                <input type="hidden" name="action"     value="capNhatTonKho">
                <input type="hidden" name="maSanPham"  value="${sanPham.maSanPham}">

                <%-- Loại thao tác --%>
                <div class="form-group">
                  <label class="form-label">Loại thao tác <span class="req">*</span></label>
                  <div style="display:flex;flex-direction:column;gap:8px;margin-top:4px">

                    <label style="display:flex;align-items:center;gap:10px;padding:11px 14px;border:1.5px solid var(--border);border-radius:var(--radius-sm);cursor:pointer" id="lbl-nhap">
                      <input type="radio" name="loaiThaoTac" value="nhap" checked onchange="onLoaiChange()">
                      <div>
                        <div style="font-weight:600;font-size:13px">➕ Nhập thêm hàng</div>
                        <div style="font-size:11.5px;color:var(--text-muted)">Cộng thêm số lượng vào tồn kho</div>
                      </div>
                    </label>

                    <label style="display:flex;align-items:center;gap:10px;padding:11px 14px;border:1.5px solid var(--border);border-radius:var(--radius-sm);cursor:pointer" id="lbl-xuat">
                      <input type="radio" name="loaiThaoTac" value="xuat" onchange="onLoaiChange()">
                      <div>
                        <div style="font-weight:600;font-size:13px">➖ Xuất hàng / Điều chỉnh giảm</div>
                        <div style="font-size:11.5px;color:var(--text-muted)">Trừ số lượng khỏi tồn kho</div>
                      </div>
                    </label>

                    <label style="display:flex;align-items:center;gap:10px;padding:11px 14px;border:1.5px solid var(--border);border-radius:var(--radius-sm);cursor:pointer" id="lbl-dieu-chinh">
                      <input type="radio" name="loaiThaoTac" value="dieu_chinh" onchange="onLoaiChange()">
                      <div>
                        <div style="font-weight:600;font-size:13px">🔁 Điều chỉnh số lượng tuyệt đối</div>
                        <div style="font-size:11.5px;color:var(--text-muted)">Đặt tồn kho về đúng con số nhập</div>
                      </div>
                    </label>

                  </div>
                </div>

                <%-- Số lượng --%>
                <div class="form-group">
                  <label class="form-label" id="lbl-soluong">Số lượng nhập thêm <span class="req">*</span></label>
                  <input type="number" name="soLuong" id="inp-soluong"
                         class="form-control" min="1" required placeholder="Nhập số lượng...">
                </div>

                <%-- Ghi chú --%>
                <div class="form-group">
                  <label class="form-label">Ghi chú</label>
                  <textarea name="ghiChu" class="form-control" rows="3"
                            placeholder="Lý do nhập / xuất, tên nhà cung cấp..."></textarea>
                </div>

                <div style="display:flex;gap:8px">
                  <button type="submit" class="btn btn-primary">
                    <i class="bi bi-check-lg"></i> Xác nhận cập nhật
                  </button>
                  <a href="${pageContext.request.contextPath}/san-pham?action=danhSach"
                     class="btn btn-outline">
                    <i class="bi bi-x-lg"></i> Hủy
                  </a>
                </div>
              </form>
            </div>
          </div>
        </div><%-- end col-left --%>

        <%-- ── CỘT PHẢI: Lịch sử cập nhật ── --%>
        <div class="col-xl-7">
          <div class="card">
            <div class="card-header">
              <div class="card-title"><i class="bi bi-clock-history"></i> Lịch sử cập nhật tồn kho</div>
            </div>
            <div class="card-body p0">
              <div class="tbl-wrap">
                <table class="tbl">
                  <thead>
                    <tr>
                      <th>Thời gian</th>
                      <th>Loại</th>
                      <th>Số lượng</th>
                      <th>Tồn sau</th>
                      <th>Nhân viên</th>
                      <th>Ghi chú</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:choose>
                      <c:when test="${not empty lichSuTonKho}">
                        <c:forEach var="ls" items="${lichSuTonKho}">
                          <tr>
                            <td style="font-size:12px;white-space:nowrap;color:var(--text-muted)">
                              <fmt:formatDate value="${ls.thoiGian}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td>
                              <span class="badge ${ls.loaiThaoTac == 'nhap' ? 'badge-success' : ls.loaiThaoTac == 'xuat' ? 'badge-danger' : 'badge-info'}">
                                <c:choose>
                                  <c:when test="${ls.loaiThaoTac == 'nhap'}">Nhập</c:when>
                                  <c:when test="${ls.loaiThaoTac == 'xuat'}">Xuất</c:when>
                                  <c:otherwise>Điều chỉnh</c:otherwise>
                                </c:choose>
                              </span>
                            </td>
                            <td>
                              <strong style="color:${ls.loaiThaoTac == 'nhap' ? 'var(--success)' : 'var(--danger)'}">
                                ${ls.loaiThaoTac == 'nhap' ? '+' : '-'}${ls.soLuong}
                              </strong>
                            </td>
                            <td>${ls.tonKhoSau}</td>
                            <td style="font-size:12.5px">${ls.tenNhanVien}</td>
                            <td style="font-size:12.5px;color:var(--text-muted);max-width:160px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis">
                              ${ls.ghiChu}
                            </td>
                          </tr>
                        </c:forEach>
                      </c:when>
                      <c:otherwise>
                        <tr>
                          <td colspan="6" class="tbl-no-data">
                            <i class="bi bi-clock-history"></i>
                            Chưa có lịch sử cập nhật
                          </td>
                        </tr>
                      </c:otherwise>
                    </c:choose>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div><%-- end col-right --%>

      </div><%-- end row --%>
    </div><%-- end page-content --%>
  </div><%-- end main-content --%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const lblMap = {
    nhap        : 'Số lượng nhập thêm',
    xuat        : 'Số lượng xuất ra',
    dieu_chinh  : 'Số lượng tồn kho mới'
  };
  const idMap  = { nhap: 'lbl-nhap', xuat: 'lbl-xuat', dieu_chinh: 'lbl-dieu-chinh' };

  function onLoaiChange() {
    const val = document.querySelector('input[name="loaiThaoTac"]:checked').value;
    document.getElementById('lbl-soluong').childNodes[0].textContent = lblMap[val] + ' ';

    // Đổi màu border radio đang chọn
    Object.values(idMap).forEach(id => {
      document.getElementById(id).style.borderColor = 'var(--border)';
      document.getElementById(id).style.background  = 'transparent';
    });
    const active = document.getElementById(idMap[val]);
    active.style.borderColor = 'var(--primary-light)';
    active.style.background  = 'rgba(59,130,246,.05)';
  }

  // Khởi tạo khi load
  document.addEventListener('DOMContentLoaded', onLoaiChange);
</script>
</body>
</html>
