<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
  
    <form action="${pageContext.request.contextPath}/DonHangServlet" method="post">
        <div class="row">
            <div class="col-md-7">
                <div class="card shadow-sm p-4 border-0 mb-4">
                    <h4 class="fw-bold mb-4 text-danger">THÔNG TIN GIAO HÀNG</h4>
                    
                    <div class="mb-3">
                        <label class="form-label">Họ tên</label>
                        <input type="text" name="ten_nguoi_nhan" class="form-control" 
                               value="${sessionScope.user.ten_day_du}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" name="sdt_nguoi_nhan" class="form-control" 
                               value="${sessionScope.user.sdt}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ nhận hàng</label>
                        <textarea name="dia_chi" class="form-control" rows="2" required 
                                  placeholder="Số nhà, tên đường, phường/xã...">${sessionScope.user.dia_chi}</textarea>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card shadow-sm p-4 border-0">
                    <h5 class="fw-bold mb-3">TÓM TẮT ĐƠN HÀNG</h5>
                    
                    <%-- Dữ liệu tạm tính từ Giỏ hàng --%>
                    <div class="d-flex justify-content-between">
                        <span>Tạm tính:</span>
                        <span class="fw-bold"><fmt:formatNumber value="${tempTotal}" type="number"/>đ</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>Phí ship:</span>
                        <span class="text-success fw-bold">Miễn phí</span>
                    </div>
                    
                    <%-- PHẦN NHẬP MÃ GIẢM GIÁ --%>
                    <div class="mt-3 p-3 border rounded bg-light">
                        <label class="small fw-bold mb-1">Mã giảm giá</label>
                        <div class="input-group input-group-sm">
                            <input type="text" name="ma_voucher" class="form-control shadow-none" 
                                   placeholder="Mã voucher..." value="${appliedVoucherCode}">
                            <button class="btn btn-dark" type="submit" formaction="${pageContext.request.contextPath}/MaGiamGiaServlet">
                                Áp dụng
                            </button>
                        </div>
                        <%-- Thông báo nếu voucher hợp lệ hoặc lỗi --%>
                        <c:if test="${not empty voucherMessage}">
                            <small class="d-block mt-1 ${voucherSuccess ? 'text-success' : 'text-danger'}">
                                ${voucherMessage}
                            </small>
                        </c:if>
                    </div>

                    <hr>
                    
                    <%-- Tính tổng tiền sau khi trừ giảm giá (nếu có) --%>
                    <div class="d-flex justify-content-between mb-4">
                        <span class="fw-bold fs-5">Tổng tiền:</span>
                        <span class="fw-bold fs-4 text-danger">
                            <fmt:formatNumber value="${finalTotal}" type="number"/>đ
                        </span>
                    </div>

                    <%-- Nút submit thực sự để tạo Đơn hàng --%>
                    <button type="submit" class="btn btn-danger btn-lg w-100 fw-bold py-3 shadow-sm">
                        XÁC NHẬN ĐẶT HÀNG
                    </button>
                </div>
            </div>
        </div>
    </form>
</main>

<jsp:include page="../common/footer.jsp" />