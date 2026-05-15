<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- 1. HEADER & NAVBAR --%>
<jsp:include page="/common/header.jsp" />
<jsp:include page="/common/navbar-user.jsp" />

<main class="container my-5">
    <%-- 2. KIỂM TRA DỮ LIỆU SẢN PHẨM --%>
    <c:if test="${empty detail}">
        <div class="alert alert-warning text-center shadow-sm" style="border-radius: 15px;">
            <i class="bi bi-exclamation-triangle fs-1 d-block mb-3"></i>
            <h4>Không tìm thấy sản phẩm!</h4>
            <p>Vui lòng kiểm tra lại đường dẫn hoặc <a href="${pageContext.request.contextPath}/TrangChuServlet" class="fw-bold text-danger">Quay lại trang chủ</a></p>
        </div>
    </c:if>

    <c:if test="${not empty detail}">
        <%-- 3. BREADCRUMB (ĐIỀU HƯỚNG) --%>
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb small">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/TrangChuServlet" class="text-decoration-none text-danger">Trang chủ</a>
                </li>
                <li class="breadcrumb-item active">${detail.tenSanPham}</li>
            </ol>
        </nav>

        <div class="row mb-5">
            <%-- 4. CỘT TRÁI: ẢNH SẢN PHẨM --%>
            <div class="col-md-6 text-center">
                <div class="card border-0 shadow-sm p-4 sticky-top" style="top: 100px; z-index: 10; border-radius: 20px;">
                    <img src="${pageContext.request.contextPath}/assets/images/${detail.urlAnh}" 
                         class="img-fluid" style="max-height: 450px; object-fit: contain;" alt="${detail.tenSanPham}">
                </div>
            </div>

            <%-- 5. CỘT PHẢI: THÔNG TIN CHI TIẾT --%>
            <div class="col-md-6">
                <h2 class="fw-bold mb-1">${detail.tenSanPham}</h2>
                
                <%-- 5.1 FAKE ĐÁNH GIÁ & LƯỢT BÁN --%>
                <div class="d-flex align-items-center mb-3">
                    <c:set var="stars" value="${(detail.idSanPham % 2 == 0) ? 5 : 4}" />
                    <span class="text-warning me-2 small">
                        <c:forEach begin="1" end="${stars}"><i class="bi bi-star-fill"></i></c:forEach>
                        <c:if test="${stars < 5}"><i class="bi bi-star-half"></i></c:if>
                    </span>
                    <span class="text-primary small">
                        (${(detail.idSanPham * 7) + 21} đánh giá) | 
                        <span class="text-muted">Đã bán ${(detail.idSanPham * 13) + 50}+</span>
                    </span>
                </div>

                <%-- 5.2 GIÁ BÁN (Hiển thị giá của biến thể đầu tiên nếu có) --%>
                <h3 class="text-danger fw-bold mb-4" id="display-price">
                    <c:choose>
                        <c:when test="${not empty variants}">
                            <fmt:formatNumber value="${variants[0].giaBienThe}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${detail.giaCoBan}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </c:otherwise>
                    </c:choose>
                </h3>

                <form action="${pageContext.request.contextPath}/gio-hang" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="${detail.idSanPham}">
                    
                    <%-- Hidden input lưu ID biến thể đang chọn --%>
                    <input type="hidden" name="id_bien_the" id="selected-variant-id" value="${not empty variants ? variants[0].idBienThe : ''}">

                    <%-- 5.3 LỰA CHỌN BIẾN THỂ (DUNG LƯỢNG) --%>
                    <c:if test="${not empty variants}">
                        <div class="mb-4">
                            <label class="fw-bold mb-2 small text-uppercase text-muted">Chọn phiên bản:</label>
                            <div class="d-flex flex-wrap gap-2">
                                <c:forEach var="bt" items="${variants}" varStatus="status">
                                    <input type="radio" class="btn-check" name="variant_option" 
                                           id="v_${bt.idBienThe}" value="${bt.idBienThe}" 
                                           ${status.first ? 'checked' : ''} 
                                           onchange="updatePrice('${bt.idBienThe}', ${bt.giaBienThe})">
                                    <label class="btn btn-outline-danger px-3 py-2 fw-bold variant-btn" for="v_${bt.idBienThe}">
                                        ${bt.tenBienThe}
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <%-- 5.4 CHỌN SỐ LƯỢNG --%>
                    <div class="mb-4">
                        <label class="fw-bold mb-2 small text-uppercase text-muted">Số lượng mua:</label>
                        <div class="input-group shadow-sm" style="width: 120px;">
                            <button class="btn btn-outline-secondary" type="button" onclick="changeQty(-1)">-</button>
                            <input type="number" name="so_luong" id="buy-quantity" 
                                   class="form-control text-center shadow-none border-secondary" 
                                   value="1" min="1" readonly>
                            <button class="btn btn-outline-secondary" type="button" onclick="changeQty(1)">+</button>
                        </div>
                    </div>

                    <%-- 5.5 NÚT HÀNH ĐỘNG --%>
                    <div class="d-flex gap-3 mt-4">
                        <button type="submit" name="buy_now" value="true" 
                                class="btn btn-danger fw-bold px-4 py-3 shadow-sm flex-grow-1" 
                                style="border-radius: 12px; font-size: 1.1rem;">
                            MUA NGAY
                        </button>
                        <button type="submit" class="btn btn-outline-danger fw-bold px-4 py-3 shadow-sm" 
                                style="border-radius: 12px;" title="Thêm vào giỏ hàng">
                            <i class="bi bi-cart-plus fs-4"></i>
                        </button>
                    </div>
                </form>

                <%-- 5.6 CAM KẾT --%>
                <div class="mt-4 p-3 bg-light rounded-3 small border">
                    <p class="mb-2 text-muted"><i class="bi bi-truck me-2 text-danger"></i>Miễn phí vận chuyển toàn quốc</p>
                    <p class="mb-0 text-muted"><i class="bi bi-shield-check me-2 text-danger"></i>Chính sách bảo hành 12 tháng tại ClickBuy</p>
                </div>
            </div>
        </div>

        <%-- 6. MÔ TẢ CHI TIẾT SẢN PHẨM --%>
        <div class="row pt-5 border-top">
            <div class="col-12">
                <div class="card border-0 shadow-sm p-4 mb-4" style="border-radius: 15px;">
                    <h5 class="fw-bold border-bottom pb-3 mb-3 text-uppercase text-danger">Thông tin chi tiết</h5>
                    <div class="content-detail" style="line-height: 1.8; color: #444;">
                        ${not empty detail.moTa ? detail.moTa : "Nội dung đang được cập nhật..."}
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</main>

<%-- 7. FOOTER --%>
<jsp:include page="/common/footer.jsp" />

<%-- 8. CSS TÙY CHỈNH --%>
<style>
    .variant-btn {
        border-radius: 10px;
        min-width: 90px;
        border: 2px solid #dee2e6;
        color: #333;
        transition: 0.2s ease-in-out;
    }
    .btn-check:checked + .variant-btn {
        border-color: #d70018 !important;
        color: #d70018 !important;
        background-color: #fff !important;
        box-shadow: 0 4px 10px rgba(215, 0, 24, 0.15);
    }
    .variant-btn:hover {
        border-color: #d70018;
    }
    .breadcrumb-item + .breadcrumb-item::before {
        content: ">";
    }
    .content-detail img {
        max-width: 100%;
        height: auto;
    }
</style>

<%-- 9. JAVASCRIPT XỬ LÝ SỰ KIỆN --%>
<script>
    /**
     * Cập nhật ID biến thể và giá hiển thị khi người dùng chọn dung lượng khác
     */
    function updatePrice(id, price) {
        // Cập nhật ID vào hidden input để gửi Form
        const variantInput = document.getElementById('selected-variant-id');
        if (variantInput) {
            variantInput.value = id;
        }
        
        // Định dạng tiền tệ VNĐ (vd: 25.000.000 đ)
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
        });
        
        const priceElement = document.getElementById('display-price');
        if (priceElement) {
            priceElement.innerText = formatter.format(price).replace('₫', 'đ');
        }
    }

    /**
     * Tăng/Giảm số lượng mua
     */
    function changeQty(val) {
        const input = document.getElementById('buy-quantity');
        let current = parseInt(input.value) || 1;
        if (val === 1) {
            input.value = current + 1;
        } else if (val === -1 && current > 1) {
            input.value = current - 1;
        }
    }
</script>
