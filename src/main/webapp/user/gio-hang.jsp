<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang hệ Jakarta để chạy trên Tomcat 10 --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5" id="cart-container">
    <c:choose>
        <%-- TRƯỜNG HỢP CÓ SẢN PHẨM TRONG GIỎ --%>
        <c:when test="${not empty cartItems}">
            <h3 class="fw-bold mb-4 uppercase">GIỎ HÀNG CỦA BẠN</h3>
            <div class="row">
                <div class="col-lg-8">
                    <div class="card p-3 mb-4 border-0 shadow-sm">
                        <table class="table align-middle">
                            <thead>
                                <tr class="text-secondary small text-uppercase">
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Giá</th>
                                    <th class="text-center" style="width: 120px;">Số lượng</th>
                                    <th class="text-center">Tổng tiền</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="tempTotal" value="0" />
                                <c:forEach var="item" items="${cartItems}">
                                    <c:set var="subTotal" value="${item.gia_ban * item.so_luong}" />
                                    <c:set var="tempTotal" value="${tempTotal + subTotal}" />
                                    
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <a href="${pageContext.request.contextPath}/ProductDetailServlet?id=${item.id_san_pham}">
                                                    <img src="${pageContext.request.contextPath}/uploads/san-pham/${item.url_anh}" width="70" class="me-3 rounded shadow-sm border" alt="${item.ten_san_pham}">
                                                </a>
                                                <div>
                                                    <h6 class="mb-0">
                                                        <a href="${pageContext.request.contextPath}/ProductDetailServlet?id=${item.id_san_pham}" class="text-decoration-none text-dark fw-bold">
                                                            ${item.ten_san_pham}
                                                        </a>
                                                    </h6>
                                                    <small class="text-danger d-block fw-medium">Phiên bản: ${item.ten_bien_the}</small>
                                                    <small class="text-muted" style="font-size: 0.75rem;">
                                                        <i class="bi bi-clock-history"></i> Thêm ngày: <fmt:formatDate value="${item.ngay_them}" pattern="dd/MM/yyyy" />
                                                    </small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center fw-bold">
                                            <fmt:formatNumber value="${item.gia_ban}" pattern="#,###" />đ
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/UpdateCartServlet" method="post" class="d-flex align-items-center justify-content-center">
                                                <input type="hidden" name="cartItemId" value="${item.id_item}">
                                                <input type="number" name="quantity" value="${item.so_luong}" min="1" 
                                                       class="form-control form-control-sm text-center shadow-none" 
                                                       onchange="this.form.submit()">
                                            </form>
                                        </td>
                                        <td class="text-center text-danger fw-bold">
                                            <fmt:formatNumber value="${subTotal}" pattern="#,###" />đ
                                        </td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/RemoveFromCartServlet?id=${item.id_item}" class="btn btn-sm btn-outline-secondary border-0" onclick="return confirm('Bà có chắc muốn bỏ máy này khỏi giỏ không?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/trang-chu.jsp" class="text-decoration-none text-danger fw-bold small">
                        <i class="bi bi-arrow-left"></i> TIẾP TỤC MUA SẮM
                    </a>
                </div>

                <div class="col-lg-4">
                    <%-- VOUCHER --%>
                    <div class="card p-3 border-0 shadow-sm mb-3">
                        <label class="fw-bold mb-2 small">MÃ GIẢM GIÁ (VOUCHER)</label>
                        <form action="${pageContext.request.contextPath}/ApplyVoucherServlet" method="post" class="input-group">
                            <input type="text" name="voucherCode" class="form-control shadow-none" placeholder="Nhập mã..." value="${appliedVoucher}">
                            <button class="btn btn-danger px-3 fw-bold" type="submit">ÁP DỤNG</button>
                        </form>
                        <c:if test="${not empty voucherMsg}">
                            <small class="${voucherSuccess ? 'text-success' : 'text-danger'} mt-2 d-block">${voucherMsg}</small>
                        </c:if>
                    </div>

                    <%-- TÓM TẮT ĐƠN HÀNG --%>
                    <div class="card p-4 border-0 shadow-sm bg-light">
                        <h5 class="fw-bold mb-3">TÓM TẮT ĐƠN HÀNG</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tạm tính:</span>
                            <span class="fw-bold text-dark"><fmt:formatNumber value="${tempTotal}" pattern="#,###" />đ</span>
                        </div>
                        
                        <c:if test="${discountAmount > 0}">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Giảm giá:</span>
                                <span class="text-danger fw-bold">-<fmt:formatNumber value="${discountAmount}" pattern="#,###" />đ</span>
                            </div>
                        </c:if>

                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Phí vận chuyển:</span>
                            <span class="text-success fw-bold">Miễn phí</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-4">
                            <span class="fs-5 fw-bold text-dark">Tổng cộng:</span>
                            <span class="fs-4 fw-bold text-danger">
                                <fmt:formatNumber value="${tempTotal - discountAmount}" pattern="#,###" />đ
                            </span>
                        </div>
                        
                        <button class="btn btn-danger btn-lg w-100 fw-bold py-3 shadow" 
                                onclick="location.href='${pageContext.request.contextPath}/user/thanh-toan.jsp'">
                            THANH TOÁN NGAY
                        </button>
                        <p class="small text-center text-muted mt-3 fst-italic">(Giá đã bao gồm thuế VAT)</p>
                    </div>
                </div>
            </div>
        </c:when>

        <%-- TRƯỜNG HỢP GIỎ HÀNG ĐANG TRỐNG --%>
        <c:otherwise>
            <div class="text-center py-5">
                <div class="mb-4">
                    <i class="bi bi-cart-x text-muted" style="font-size: 5rem;"></i>
                </div>
                <h4 class="mt-4 fw-bold text-muted">Giỏ hàng của bạn đang trống</h4>
                <p class="text-secondary">Hãy chọn sản phẩm để tiếp tục mua sắm nhé!</p>
                <a href="${pageContext.request.contextPath}/user/trang-chu.jsp" class="btn btn-danger px-4 fw-bold mt-3 py-2 shadow">MUA SẮM NGAY</a>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="../common/footer.jsp" />
