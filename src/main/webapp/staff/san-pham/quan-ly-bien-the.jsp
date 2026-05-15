<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Quản lý biến thể"/>
<c:set var="breadcrumb" value="Sản phẩm / Quản lý"/>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý biến thể – Nhân viên</title>
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

      <%-- Thông tin sản phẩm gốc --%>
      <c:if test="${not empty sanPham}">
        <div class="card" style="margin-bottom:16px">
          <div class="card-body" style="padding:16px">
            <div style="display:flex;gap:16px;align-items:center">
              <img src="${not empty sanPham.hinhAnh ? sanPham.hinhAnh : ''}"
                   style="width:64px;height:64px;object-fit:cover;border-radius:10px;border:1px solid var(--border);flex-shrink:0"
                   onerror="this.style.display='none'">
              <div style="flex:1">
                <div style="font-weight:700;font-size:15px">${sanPham.tenSanPham}</div>
                <div style="color:var(--text-muted);font-size:12.5px;margin-top:3px">
                  Mã: <strong>${sanPham.maSanPham}</strong>
                  &nbsp;|&nbsp; Danh mục: ${sanPham.tenDanhMuc}
                  &nbsp;|&nbsp; Giá bán:
                  <strong><fmt:formatNumber value="${sanPham.giaBan}" pattern="#,###"/>₫</strong>
                </div>
              </div>
              <a href="${pageContext.request.contextPath}/san-pham?action=capNhatTonKho&id=${sanPham.maSanPham}"
                 class="btn btn-outline btn-sm">
                <i class="bi bi-pencil-square"></i> Cập nhật tồn kho
              </a>
              <a href="${pageContext.request.contextPath}/san-pham?action=danhSach"
                 class="btn btn-ghost btn-sm">
                <i class="bi bi-arrow-left"></i> Quay lại
              </a>
            </div>
          </div>
        </div>
      </c:if>

      <%-- Bảng biến thể --%>
      <div class="card">
        <div class="card-header">
          <div class="card-title"><i class="bi bi-diagram-3"></i> Danh sách biến thể</div>
          <%-- Nhân viên chỉ xem, không thêm/xóa biến thể --%>
          <span class="badge badge-info">
            <i class="bi bi-eye"></i> Chế độ xem
          </span>
        </div>
        <div class="card-body p0">
          <div class="tbl-wrap">
            <table class="tbl">
              <thead>
                <tr>
                  <th style="width:44px">#</th>
                  <th>Màu sắc</th>
                  <th>Kích thước</th>
                  <th>SKU</th>
                  <th>Giá thêm</th>
                  <th>Tồn kho</th>
                  <th>Trạng thái</th>
                  <th style="width:110px">Cập nhật tồn</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${not empty danhSachBienThe}">
                    <c:forEach var="bt" items="${danhSachBienThe}" varStatus="st">
                      <tr>
                        <td style="color:var(--text-muted)">${st.index + 1}</td>

                        <%-- Màu sắc có chấm màu --%>
                        <td>
                          <c:choose>
                            <c:when test="${not empty bt.mauSac}">
                              <div style="display:flex;align-items:center;gap:7px">
                                <span style="width:16px;height:16px;border-radius:50%;background:${not empty bt.maMau ? bt.maMau : '#ccc'};border:1px solid var(--border);flex-shrink:0;display:inline-block"></span>
                                ${bt.mauSac}
                              </div>
                            </c:when>
                            <c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise>
                          </c:choose>
                        </td>

                        <td>${not empty bt.kichThuoc ? bt.kichThuoc : '—'}</td>

                        <td style="font-family:monospace;font-size:12px;color:var(--text-muted)">${bt.sku}</td>

                        <td>
                          <c:choose>
                            <c:when test="${bt.giaThemVao > 0}">
                              +<fmt:formatNumber value="${bt.giaThemVao}" pattern="#,###"/>₫
                            </c:when>
                            <c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise>
                          </c:choose>
                        </td>

                        <td>
                          <span class="badge
                            <c:choose>
                              <c:when test="${bt.soLuongTon == 0}">badge-danger</c:when>
                              <c:when test="${bt.soLuongTon <= 5}">badge-warning</c:when>
                              <c:otherwise>badge-success</c:otherwise>
                            </c:choose>">
                            ${bt.soLuongTon}
                          </span>
                        </td>

                        <td>
                          <span class="badge ${bt.trangThai ? 'badge-success' : 'badge-neutral'}">
                            ${bt.trangThai ? 'Hoạt động' : 'Ẩn'}
                          </span>
                        </td>

                        <td>
                          <button class="btn btn-outline btn-sm btn-icon"
                                  title="Cập nhật tồn kho biến thể"
                                  onclick="openUpdateModal(${bt.maBienThe}, '${bt.mauSac} ${bt.kichThuoc}', ${bt.soLuongTon})">
                            <i class="bi bi-pencil-square"></i>
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="8" class="tbl-no-data">
                        <i class="bi bi-diagram-3"></i>
                        Sản phẩm này chưa có biến thể nào
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>
        </div>
      </div>

    </div><%-- end page-content --%>
  </div><%-- end main-content --%>
</div>

<%-- Modal cập nhật tồn kho biến thể --%>
<div class="modal fade" id="modalCapNhat" tabindex="-1">
  <div class="modal-dialog modal-sm modal-dialog-centered">
    <div class="modal-content" style="border-radius:var(--radius);border:1px solid var(--border)">
      <div class="modal-header" style="border-bottom:1px solid var(--border);padding:14px 18px">
        <h6 class="modal-title" style="font-weight:700;font-size:14px">
          <i class="bi bi-pencil-square"></i> Cập nhật tồn kho biến thể
        </h6>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form method="post" action="${pageContext.request.contextPath}/SanPhamServlet">
        <input type="hidden" name="action" value="capNhatTonKhoBienThe">
        <input type="hidden" name="maSanPham" value="${sanPham.maSanPham}">
        <input type="hidden" name="maBienThe" id="modal-maBienThe">
        <div class="modal-body" style="padding:16px 18px">
          <div style="margin-bottom:12px">
            <div style="font-size:12px;color:var(--text-muted)">Biến thể đang chọn</div>
            <div style="font-weight:600;font-size:13px;margin-top:2px" id="modal-tenBienThe"></div>
          </div>
          <div style="margin-bottom:12px">
            <div style="font-size:12px;color:var(--text-muted)">Tồn kho hiện tại</div>
            <div style="font-weight:700;font-size:18px;color:var(--primary);margin-top:2px" id="modal-tonHienTai"></div>
          </div>
          <div class="form-group" style="margin-bottom:0">
            <label class="form-label">Số lượng mới <span class="req">*</span></label>
            <input type="number" name="soLuongMoi" id="modal-soLuong"
                   class="form-control" min="0" required placeholder="Nhập số lượng...">
          </div>
        </div>
        <div class="modal-footer" style="border-top:1px solid var(--border);padding:12px 18px;gap:8px">
          <button type="button" class="btn btn-outline btn-sm" data-bs-dismiss="modal">Hủy</button>
          <button type="submit" class="btn btn-primary btn-sm">
            <i class="bi bi-check-lg"></i> Cập nhật
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function openUpdateModal(maBienThe, tenBienThe, tonHienTai) {
  document.getElementById('modal-maBienThe').value   = maBienThe;
  document.getElementById('modal-tenBienThe').textContent = tenBienThe || '—';
  document.getElementById('modal-tonHienTai').textContent = tonHienTai;
  document.getElementById('modal-soLuong').value = tonHienTai;
  new bootstrap.Modal(document.getElementById('modalCapNhat')).show();
}
</script>
</body>
</html>
