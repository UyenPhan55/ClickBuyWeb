<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    try {
        dao.DonHangDAO dhDao = new dao.DonHangDAO();
        Integer userId = util.SessionUtil.getIdNguoiDung(request);
        if(userId != null) {
            request.setAttribute("ordersForSelect", dhDao.getOrdersByUser(userId));
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
                <p class="text-muted mb-4">Hệ thống đã tiếp nhận phản hồi. Bà chờ chút xíu để quay lại danh sách nhé!</p>
                <button type="button" class="btn btn-danger px-5 fw-bold py-2" onclick="location.reload()">OK</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Mẹo: Khi nhấn Submit, hiện Modal trước rồi mới gửi Form thật
    document.getElementById('complaintForm').onsubmit = function(e) {
        e.preventDefault(); // Dừng gửi form ngay lập tức
        
        // Hiện cái Modal lên
        var myModal = new bootstrap.Modal(document.getElementById('successModal'));
        myModal.show();
        
        // Chờ 2 giây cho bà kịp thấy cái Modal rồi mới gửi dữ liệu về Servlet
        var form = this;
        setTimeout(function() {
            form.submit();
        }, 2000);
    };

    // Kiểm tra xem nếu vừa load lại trang sau khi gửi xong (dựa vào URL)
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('status') === 'success') {
            var myModal = new bootstrap.Modal(document.getElementById('successModal'));
            myModal.show();
        }
    };
</script>

<jsp:include page="../common/footer.jsp" />
