<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    try {
        dao.DonHangDAO dhDao = new dao.DonHangDAO();
        Integer userId = util.SessionUtil.getIdNguoiDung(request);
        if(userId != null) {
            request.setAttribute("ordersForSelect", dhDao.getOrdersByUser(userId));
            if (request.getAttribute("danhSachKhieuNai") == null) {
                dao.KhieuNaiDAO knDao = new dao.KhieuNaiDAO();
                request.setAttribute("danhSachKhieuNai", knDao.getKhieuNaiByUser(userId));
            }
        }
    } catch (Exception e) { e.printStackTrace(); }
%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="mx-auto" style="max-width: 700px;">
        <div class="card shadow-sm border-0 p-4" style="border-radius: 20px;">
            <h3 class="fw-bold text-center mb-4 text-danger">GỬI KHIẾU NẠI</h3>
            
            <form id="complaintForm" action="${pageContext.request.contextPath}/KhieuNaiServlet" method="post">
                <input type="hidden" name="action" value="add">
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Chọn đơn hàng cần khiếu nại</label>
                    <select class="form-select border-danger-subtle shadow-none py-2" name="idDonHang" required>
                        <option value="" disabled selected>-- Chọn đơn hàng --</option>
                        <c:forEach var="order" items="${ordersForSelect}">
                            <option value="${order.idDonHang}">
                                Đơn hàng #CB${order.idDonHang} - <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy" />
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Nội dung khiếu nại</label>
                    <textarea class="form-control border-danger-subtle shadow-none" name="noiDung" rows="5" required placeholder="Mô tả chi tiết vấn đề..."></textarea>
                </div>

                <div class="mb-3 p-3 bg-light rounded border border-dashed">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="yeuCauTraHang" id="returnRequest" value="1">
                        <label class="form-check-label fw-bold text-danger" for="returnRequest">Tôi muốn trả hàng / hoàn tiền</label>
                    </div>
                </div>

                <button type="submit" class="btn btn-danger w-100 py-3 fw-bold shadow-sm" style="border-radius: 12px;">
                    GỬI KHIẾU NẠI NGAY
                </button>
            </form>
        </div>

        <div class="card shadow-sm border-0 p-4 mt-5" style="border-radius: 20px;">
            <h4 class="fw-bold text-center mb-4 text-dark">LỊCH SỬ KHIẾU NẠI</h4>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr class="table-danger text-uppercase">
                            <th scope="col" style="font-size: 0.85rem;">Mã khiếu nại</th>
                            <th scope="col" style="font-size: 0.85rem;">Đơn hàng</th>
                            <th scope="col" style="font-size: 0.85rem;">Nội dung</th>
                            <th scope="col" style="font-size: 0.85rem;">Hoàn tiền</th>
                            <th scope="col" style="font-size: 0.85rem;">Ngày gửi</th>
                            <th scope="col" style="font-size: 0.85rem;">Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty danhSachKhieuNai}">
                                <c:forEach var="kn" items="${danhSachKhieuNai}">
                                    <tr>
                                        <td class="fw-bold text-danger">#${kn.idKhieuNai}</td>
                                        <td>#CB${kn.idDonHang}</td>
                                        <td>
                                            <div class="text-truncate" style="max-width: 150px;" title="${kn.noiDung}">
                                                ${kn.noiDung}
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${kn.yeuCauTraHang == 1}">
                                                    <span class="badge bg-warning text-dark">Có</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-light text-secondary">Không</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="font-size: 0.85rem;">
                                            <fmt:formatDate value="${kn.ngayGui}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${kn.trangThai == 'CHO_XU_LY'}">
                                                    <span class="badge bg-danger">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${kn.trangThai == 'DA_PHAN_HOI'}">
                                                    <span class="badge bg-success">Đã phản hồi</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${kn.trangThai}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <c:if test="${not empty kn.phanHoi}">
                                        <tr class="table-light">
                                            <td colspan="6" class="ps-4">
                                                <div class="small text-muted" style="font-style: italic;">
                                                    <i class="bi bi-reply-all-fill me-1 text-danger"></i> 
                                                    <strong>ClickBuy phản hồi:</strong> "${kn.phanHoi}"
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-4 d-block mb-2"></i>
                                        Bạn chưa gửi khiếu nại nào.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<div class="modal fade" id="successModal" tabindex="-1" style="background: rgba(0,0,0,0.5); z-index: 9999;">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow" style="border-radius: 20px;">
            <div class="modal-body text-center p-5">
                <div class="mb-4">
                    <i class="bi bi-check-circle-fill text-success" style="font-size: 4rem;"></i>
                </div>
                <h4 class="fw-bold mb-3">Gửi khiếu nại thành công!</h4>
                <p class="text-muted mb-4">Hệ thống đã tiếp nhận phản hồi.</p>
                <button type="button" class="btn btn-danger px-5 fw-bold py-2" onclick="location.reload()">OK</button>
            </div>
        </div>
    </div>
</div>

<script>
   
    document.getElementById('complaintForm').onsubmit = function(e) {
        e.preventDefault(); 
        var myModal = new bootstrap.Modal(document.getElementById('successModal'));
        myModal.show();
        
        var form = this;
        setTimeout(function() {
            form.submit();
        }, 2000);
    };

    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('status') === 'success') {
            var myModal = new bootstrap.Modal(document.getElementById('successModal'));
            myModal.show();
        }
    };
</script>

<jsp:include page="../common/footer.jsp" />
