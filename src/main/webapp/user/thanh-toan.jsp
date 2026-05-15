<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<%-- BƯỚC 1: TÍNH TỔNG TIỀN TẠM TÍNH --%>
<c:set var="tempTotal" value="0" />
<c:forEach var="item" items="${danhSachGioHang}">
    <c:set var="tempTotal" value="${tempTotal + (item.giaBienThe * item.soLuong)}" />
</c:forEach>

<%-- BƯỚC 2: TÍNH TOÁN SỐ TIỀN GIẢM GIÁ TỪ SESSION --%>
<c:set var="discountAmount" value="0" />
<c:if test="${not empty sessionScope.discount}">
    <c:set var="mgg" value="${sessionScope.discount}" />
    <c:choose>
        <%-- Nếu giảm theo phần trăm --%>
        <c:when test="${mgg.loaiGiam eq 'PHAN_TRAM'}">
            <c:set var="discountAmount" value="${tempTotal * (mgg.giaTriGiam / 100)}" />
            <%-- CỰC QUAN TRỌNG: Kiểm tra mức giảm tối đa từ MySQL --%>
            <c:if test="${mgg.giamToiDa > 0 && discountAmount > mgg.giamToiDa}">
                <c:set var="discountAmount" value="${mgg.giamToiDa}" />
            </c:if>
        </c:when>
        <%-- Nếu giảm theo tiền mặt --%>
        <c:otherwise>
            <c:set var="discountAmount" value="${mgg.giaTriGiam}" />
        </c:otherwise>
    </c:choose>
</c:if>

<c:set var="finalTotal" value="${tempTotal - discountAmount}" />

<main class="container my-5">
    <form action="${pageContext.request.contextPath}/DonHangServlet" method="post">
        <input type="hidden" name="action" value="place">
        
        <div class="row">
            <%-- CỘT TRÁI: THÔNG TIN GIAO HÀNG --%>
            <div class="col-md-7">
                <div class="card shadow-sm p-4 border-0 mb-4" style="border-radius: 20px;">
                    <h4 class="fw-bold mb-4 text-danger text-uppercase">Thông tin giao hàng</h4>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Họ tên người nhận</label>
                        <input type="text" name="hoTen" class="form-control shadow-none py-2" 
                               value="${sessionScope.user.tenDayDu}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Số điện thoại</label>
                        <input type="text" name="sdtNguoiNhan" class="form-control shadow-none py-2" 
                               value="${sessionScope.user.sdt}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Địa chỉ nhận hàng</label>
                        <textarea name="diaChi" class="form-control shadow-none" rows="3" required 
                                  placeholder="Số nhà, tên đường...">${sessionScope.user.diaChi}</textarea>
                    </div>
                </div>
            </div>

            <%-- CỘT PHẢI: TÓM TẮT & CHỌN VOUCHER --%>
            <div class="col-md-5">
                <div class="card shadow-sm p-4 border-0" style="border-radius: 20px;">
                    <h5 class="fw-bold mb-4 text-uppercase">Tóm tắt đơn hàng</h5>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Tạm tính:</span>
                        <span class="fw-bold">
                            <fmt:formatNumber value="${tempTotal}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </span>
                    </div>
                    
                    <%-- HIỂN THỊ MÃ ĐÃ ÁP DỤNG --%>
                    <c:if test="${discountAmount > 0}">
                        <div class="d-flex justify-content-between mb-2 text-success fw-bold">
                            <span>Giảm giá (${sessionScope.discount.maCode}):</span>
                            <span>-<fmt:formatNumber value="${discountAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></span>
                        </div>
                    </c:if>
                    
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted">Phí giao hàng:</span>
                        <span class="text-success fw-bold">Miễn phí</span>
                    </div>
                    
                    <%-- PHẦN CHỌN MÃ GIẢM GIÁ (Lấy động từ MySQL) --%>
                    <div class="mt-2 p-3 border rounded-3 bg-light">
                        <label class="small fw-bold mb-2 text-muted text-uppercase">Mã giảm giá (Voucher)</label>
                        <div class="input-group">
                            <select name="voucherCode" class="form-select shadow-none">
                                <option value="">-- Chọn mã giảm giá --</option>
                                <%-- ĐÂY LÀ ĐOẠN LẤY DỮ LIỆU TỪ MYSQL NÈ BÀ --%>
                                <c:forEach var="v" items="${danhSachVoucher}">
                                    <option value="${v.maCode}" ${sessionScope.discount.maCode == v.maCode ? 'selected' : ''}>
                                        ${v.maCode} - Giảm ${v.loaiGiam eq 'PHAN_TRAM' ? v.giaTriGiam : ''}
                                        <c:if test="${v.loaiGiam eq 'PHAN_TRAM'}">%</c:if>
                                        <c:if test="${v.loaiGiam ne 'PHAN_TRAM'}"><fmt:formatNumber value="${v.giaTriGiam}" />đ</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            
                            <button class="btn btn-dark fw-bold px-3" type="submit" 
                                    formaction="${pageContext.request.contextPath}/MaGiamGiaServlet">
                                ÁP DỤNG
                            </button>
                        </div>
                        
                        <%-- Cần ID này để DonHangDAO lưu vào DB khi đặt hàng --%>
                        <input type="hidden" name="idVoucher" value="${sessionScope.discount.idVoucher}">
                        
                        <c:if test="${not empty sessionScope.voucherMsg}">
                            <div class="mt-2 small text-danger">
                                <i class="bi bi-exclamation-triangle-fill me-1"></i> ${sessionScope.voucherMsg}
                                <c:remove var="voucherMsg" scope="session" />
                            </div>
                        </c:if>
                    </div>

                    <hr class="my-4" style="border-style: dashed;">
                    
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fw-bold fs-5 text-dark">TỔNG TIỀN:</span>
                        <span class="fw-bold fs-2 text-danger">
                            <fmt:formatNumber value="${finalTotal}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </span>
                    </div>

                    <button type="submit" class="btn btn-danger btn-lg w-100 fw-bold py-3 shadow mb-3" style="border-radius: 15px;">
                        XÁC NHẬN ĐẶT HÀNG
                    </button>
                </div>
            </div>
        </div>
    </form>
</main>

<jsp:include page="../common/footer.jsp" />
