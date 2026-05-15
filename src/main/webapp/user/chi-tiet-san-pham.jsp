<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/common/header.jsp" />
<jsp:include page="/common/navbar-user.jsp" />

<main class="container my-5">
    <c:if test="${empty detail}">
        <div class="alert alert-warning text-center shadow-sm" style="border-radius: 15px;">
            <i class="bi bi-exclamation-triangle fs-1 d-block mb-3"></i>
            <h4>Không tìm thấy sản phẩm!</h4>
            <p>Vui lòng kiểm tra lại ID hoặc <a href="${pageContext.request.contextPath}/TrangChuServlet" class="fw-bold text-danger">Quay lại trang chủ</a></p>
        </div>
    </c:if>

    <c:if test="${not empty detail}">
        <%-- Điều hướng --%>
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb small">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/TrangChuServlet" class="text-decoration-none text-danger">Trang chủ</a></li>
                <li class="breadcrumb-item active">${detail.tenSanPham}</li>
            </ol>
        </nav>

        <div class="row mb-5">
            <%-- Cột bên trái: Ảnh --%>
            <div class="col-md-6 text-center">
                <div class="card border-0 shadow-sm p-4 sticky-top" style="top: 100px; z-index: 10; border-radius: 20px;">
                    <img src="${pageContext.request.contextPath}/assets/images/${detail.urlAnh}" 
                         class="img-fluid" style="max-height: 450px; object-fit: contain;" alt="${detail.tenSanPham}">
                </div>
            </div>

            <%-- Cột bên phải: Thông tin --%>
            <div class="col-md-6">
                <h2 class="fw-bold mb-1">${detail.tenSanPham}</h2>
                
                <%-- 1. THÔNG TIN NSX & TRẠNG THÁI (Lấy từ DB) --%>
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="text-muted small">NSX: <strong class="text-dark">${not empty detail.nhaSanXuat ? detail.nhaSanXuat : 'Đang cập nhật'}</strong></span>
                    <span class="text-muted">|</span>
                    
                    <c:choose>
                        <c:when test="${detail.trangThai == 1}">
                            <span class="badge bg-success-subtle text-success border border-success-subtle fw-bold">
                                <i class="bi bi-check-circle-fill me-1"></i> Đang kinh doanh
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle fw-bold">
                                <i class="bi bi-x-circle-fill me-1"></i> Ngừng kinh doanh
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- 2. ĐÁNH GIÁ ẢO --%>
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

                <p class="text-muted small mb-3">Mã SP: SP00${detail.idSanPham}</p>

                <%-- 3. GIÁ BÁN --%>
                <h3 class="text-danger fw-bold mb-4" id="display-price">
                    <fmt:formatNumber value="${not empty variants ? variants[0].giaBienThe : detail.giaCoBan}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                </h3>

                <%-- 4. FORM MUA HÀNG --%>
                <form action="${pageContext.request.contextPath}/GioHangServlet" method="post" id="purchase-form">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="${detail.idSanPham}">
                    <input type="hidden" name="id_bien_the" id="selected-variant-id" value="${not empty variants ? variants[0].idBienThe : ''}">

                    <%-- Chọn biến thể --%>
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

                    <%-- Số lượng --%>
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

                    <%-- Nút bấm --%>
                    <div class="d-flex gap-3 mt-4">
                        <button type="submit" name="buy_now" value="true" 
                                class="btn btn-danger fw-bold px-4 py-3 shadow-sm flex-grow-1" 
                                style="border-radius: 12px; font-size: 1.1rem;">
                            MUA NGAY
                        </button>
                        <button type="submit" class="btn btn-outline-danger fw-bold px-4 py-3 shadow-sm" 
                                style="border-radius: 12px;">
                            <i class="bi bi-cart-plus fs-4"></i>
                        </button>
                    </div>
                </form>

                <div class="mt-4 p-3 bg-light rounded-3 small border">
                    <p class="mb-2 text-muted"><i class="bi bi-truck me-2 text-danger"></i>Miễn phí vận chuyển toàn quốc</p>
                    <p class="mb-0 text-muted"><i class="bi bi-shield-check me-2 text-danger"></i>Chính sách bảo hành 12 tháng tại ClickBuy</p>
                </div>
            </div>
        </div>
        
        <%-- 5. MÔ TẢ CHI TIẾT --%>
        <div class="row pt-5 border-top">
            <div class="col-12">
                <div class="card border-0 shadow-sm p-4 mb-4" style="border-radius: 15px;">
                    <h5 class="fw-bold border-bottom pb-3 mb-3 text-uppercase text-danger">Thông tin chi tiết</h5>
                    <div class="content-detail" style="line-height: 1.8;">
                        ${not empty detail.moTa ? detail.moTa : "Đang cập nhật nội dung cho sản phẩm này..."}
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</main>

<jsp:include page="/common/footer.jsp" />

<style>
    .variant-btn { border-radius: 10px; min-width: 90px; border: 2px solid #dee2e6; color: #333; transition: 0.2s; }
    .btn-check:checked + .variant-btn { border-color: #d70018 !important; color: #d70018 !important; background-color: #fff !important; box-shadow: 0 0 0 1px #d70018; }
    .breadcrumb-item + .breadcrumb-item::before { content: ">"; }
    .badge { padding: 0.5em 0.8em; border-radius: 8px; }
</style>

<script>
    function updatePrice(id, price) {
        document.getElementById('selected-variant-id').value = id;
        const formatter = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' });
        document.getElementById('display-price').innerText = formatter.format(price).replace('₫', 'đ');
    }

    function changeQty(val) {
        const input = document.getElementById('buy-quantity');
        let current = parseInt(input.value) || 1;
        if (val === 1) input.value = current + 1;
        else if (val === -1 && current > 1) input.value = current - 1;
    }
</script>
