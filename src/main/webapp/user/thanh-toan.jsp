<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang hệ Jakarta cho Tomcat 10 --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
  
    <%-- Form chính gửi về DonHangServlet để tạo đơn --%>
    <form action="${pageContext.request.contextPath}/DonHangServlet" method="post">
        <div class="row">
            <%-- CỘT TRÁI: THÔNG TIN KHÁCH HÀNG --%>
            <div class="col-md-7">
                <div class="card shadow-sm p-4 border-0 mb-4">
                    <h4 class="fw-bold mb-4 text-danger">THÔNG TIN GIAO HÀNG</h4>
                    
                    <div class="mb-3">
                        <label class="form-label fw-medium">Họ tên người nhận</label>
                        <input type="text" name="ten_nguoi_nhan" class="form-control shadow-none" 
                               value="${sessionScope.user.ten_day_du}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-medium">Số điện thoại</label>
                        <input type="text" name="sdt_nguoi_nhan" class="form-control shadow-none" 
                               value="${sessionScope.user.sdt}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-medium">Địa chỉ nhận hàng</label>
                        <textarea name="dia_chi" class="form-control shadow-none" rows="3" required 
                                  placeholder="Số nhà, tên đường, phường/xã...">${sessionScope.user.dia_chi}</textarea>
                    </div>
                    <div class="p-3 bg-light rounded small text-muted fst-italic">
                        <i class="bi bi-info-circle me-1"></i> ClickBuy sẽ liên hệ qua số điện thoại này để xác nhận đơn hàng.
                    </div>
                </div>
            </div>

            <%-- CỘT PHẢI: TÓM TẮT & THANH TOÁN --%>
            <div class="col-md-5">
                <div class="card shadow-sm p-4 border-0">
                    <h5 class="fw-bold mb-3 text-uppercase">Tóm tắt đơn hàng</h5>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Tạm tính:</span>
                        <span class="fw-bold"><fmt:formatNumber value="${tempTotal}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Phí giao hàng:</span>
                        <span class="text-success fw-bold">Miễn phí</span>
                    </div>
                    
                    <%-- PHẦN NHẬP MÃ GIẢM GIÁ --%>
                    <div class="mt-3 p-3 border rounded bg-white">
                        <label class="small fw-bold mb-2 text-muted text-uppercase">Mã giảm giá</label>
                        <div class="input-group input-group-sm">
                            <input type="text" name="ma_voucher" class="form-control shadow-none" 
                                   placeholder="Nhập mã voucher..." value="${appliedVoucherCode}">
                            <%-- Dùng formaction để gửi riêng về Servlet xử lý Voucher mà không làm mất dữ liệu form --%>
                            <button class="btn btn-dark fw-bold" type="submit" formaction="${pageContext.request.contextPath}/MaGiamGiaServlet">
                                ÁP DỤNG
                            </button>
                        </div>
                        <c:if test="${not empty voucherMessage}">
                            <small class="d-block mt-2 ${voucherSuccess ? 'text-success' : 'text-danger'}">
                                <i class="bi ${voucherSuccess ? 'bi-check-circle' : 'bi-exclamation-circle'} me-1"></i>
                                ${voucherMessage}
                            </small>
                        </c:if>
                    </div>

                    <hr class="my-4">
                    
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fw-bold fs-5">TỔNG TIỀN:</span>
                        <span class="fw-bold fs-3 text-danger">
                            <fmt:formatNumber value="${finalTotal != null ? finalTotal : tempTotal}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </span>
                    </div>

                    <%-- Nút xác nhận đặt hàng chính thức --%>
                    <button type="submit" class="btn btn-danger btn-lg w-100 fw-bold py-3 shadow-sm mb-3">
                        XÁC NHẬN ĐẶT HÀNG
                    </button>
                    
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/user/gio-hang.jsp" class="text-decoration-none small text-muted">
                            <i class="bi bi-chevron-left"></i> Quay lại giỏ hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</main>

<jsp:include page="../common/footer.jsp" />
