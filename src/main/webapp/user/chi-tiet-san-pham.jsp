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
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb small">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/TrangChuServlet" class="text-decoration-none text-danger">Trang chủ</a></li>
                <li class="breadcrumb-item active">${detail.tenSanPham}</li>
            </ol>
        </nav>

        <div class="row mb-5">
            <%-- Ảnh sản phẩm --%>
            <div class="col-md-6 text-center">
                <div class="card border-0 shadow-sm p-4 sticky-top" style="top: 100px; z-index: 10; border-radius: 20px;">
                    <img src="${pageContext.request.contextPath}/assets/images/${detail.urlAnh}" 
                         class="img-fluid ${detail.trangThai == 0 ? 'grayscale' : ''}" 
                         style="max-height: 450px; object-fit: contain;" alt="${detail.tenSanPham}">
                </div>
            </div>

            <%-- Thông tin sản phẩm --%>
            <div class="col-md-6">
                <h2 class="fw-bold mb-1">${detail.tenSanPham}</h2>
                
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="text-muted small">NSX: <strong class="text-dark">${detail.nhaSanXuat}</strong></span>
                    <span class="text-muted">|</span>
                    <c:choose>
                        <c:when test="${detail.trangThai == 1}">
                            <span class="badge bg-success-subtle text-success fw-bold border border-success-subtle">Đang kinh doanh</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary text-white fw-bold border border-secondary">Ngừng kinh doanh</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="d-flex align-items-center mb-3">
                    <c:set var="stars" value="${(detail.idSanPham % 2 == 0) ? 5 : 4}" />
                    <span class="text-warning me-2 small">
                        <c:forEach begin="1" end="${stars}"><i class="bi bi-star-fill"></i></c:forEach>
                        <c:if test="${stars < 5}"><i class="bi bi-star-half"></i></c:if>
                    </span>
                    <span class="text-primary small">(${(detail.idSanPham * 7) + 21} đánh giá) | <span class="text-muted">Đã bán ${(detail.idSanPham * 13) + 50}+</span></span>
                </div>

                <h3 class="text-danger fw-bold mb-4" id="display-price">
                    <fmt:formatNumber value="${not empty variants ? variants[0].giaBienThe : detail.giaCoBan}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                </h3>

                <div class="mb-4 ${detail.trangThai == 0 ? 'opacity-50' : ''}">
                    <label class="fw-bold mb-2 small text-uppercase text-muted">Chọn phiên bản:</label>
                    <div class="d-flex flex-wrap gap-2">
                        <c:forEach var="bt" items="${variants}" varStatus="status">
                            <input type="radio" class="btn-check" name="variant_option" id="v_${bt.idBienThe}" 
                                   value="${bt.idBienThe}" ${status.first ? 'checked' : ''}
                                   ${detail.trangThai == 0 ? 'disabled' : ''}
                                   onchange="updatePrice('${bt.idBienThe}', ${bt.giaBienThe}, '${bt.tenBienThe}')">
                            <label class="btn btn-outline-danger px-3 py-2 fw-bold variant-btn" for="v_${bt.idBienThe}">${bt.tenBienThe}</label>
                        </c:forEach>
                    </div>
                </div>

                <div class="mb-4 ${detail.trangThai == 0 ? 'opacity-50' : ''}">
                    <label class="fw-bold mb-2 small text-uppercase text-muted">Số lượng mua:</label>
                    <div class="input-group shadow-sm" style="width: 120px;">
                        <button class="btn btn-outline-secondary" type="button" onclick="changeQty(-1)" ${detail.trangThai == 0 ? 'disabled' : ''}>-</button>
                        <input type="number" id="buy-quantity" class="form-control text-center shadow-none border-secondary" value="1" min="1" readonly>
                        <button class="btn btn-outline-secondary" type="button" onclick="changeQty(1)" ${detail.trangThai == 0 ? 'disabled' : ''}>+</button>
                    </div>
                </div>

                <div class="d-flex gap-3 mt-4">
                    <button type="button" class="btn ${detail.trangThai == 1 ? 'btn-danger' : 'btn-secondary'} fw-bold px-4 py-3 shadow-sm flex-grow-1" 
                            style="border-radius: 12px; font-size: 1.1rem;"
                            ${detail.trangThai == 1 ? 'data-bs-toggle="modal" data-bs-target="#checkoutModal" onclick="prepareCheckout()"' : 'disabled'}>
                        ${detail.trangThai == 1 ? 'MUA NGAY' : 'NGỪNG KINH DOANH'}
                    </button>
                    
                    <%-- SỬA TẠI ĐÂY: Nút thêm giỏ hàng gọi hàm Ajax ngầm --%>
                    <button type="button" class="btn btn-outline-danger fw-bold px-4 py-3 shadow-sm" 
                            style="border-radius: 12px;" 
                            ${detail.trangThai == 0 ? 'disabled' : ''}
                            onclick="addCartAjaxDetail()">
                        <i class="bi ${detail.trangThai == 1 ? 'bi-cart-plus' : 'bi-cart-x'} fs-4"></i>
                    </button>
                </div>
                <c:if test="${detail.trangThai == 0}">
                    <p class="text-danger mt-3 small fw-bold"><i class="bi bi-info-circle me-1"></i> Sản phẩm này hiện tại không còn bán.</p>
                </c:if>
            </div>
        </div>

        <%-- MÔ TẢ CHI TIẾT --%>
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

<%-- TOAST THÔNG BÁO --%>
<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1100">
    <div id="cartToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <i class="bi bi-check-circle-fill me-2"></i> Đã thêm vào giỏ hàng thành công!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<%-- IFRAME ẨN --%>
<iframe name="hidden_iframe" id="hidden_iframe" style="display:none;" src="about:blank" onload="handleIframeLoad()"></iframe>

<%-- MODAL THANH TOÁN (Giữ nguyên) --%>
<div class="modal fade" id="checkoutModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 20px; overflow: hidden;">
            <div class="modal-header border-0 bg-danger text-white">
                <h5 class="modal-title fw-bold">Xác nhận thanh toán</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/DonHangServlet" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="action" value="place">
                    <input type="hidden" name="idSanPham" value="${detail.idSanPham}">
                    <input type="hidden" name="id_bien_the" id="modal-id-bien-the">
                    <input type="hidden" name="so_luong" id="modal-so-luong">

                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/assets/images/${detail.urlAnh}" style="width: 60px; height: 60px; object-fit: contain;" class="me-3">
                        <div>
                            <h6 class="fw-bold mb-0">${detail.tenSanPham}</h6>
                            <small class="text-muted" id="modal-variant-name"></small>
                        </div>
                    </div>
                    <div class="p-3 bg-light rounded mb-3">
                        <div class="d-flex justify-content-between small mb-1">
                            <span>Đơn giá:</span>
                            <span id="modal-unit-price"></span>
                        </div>
                        <div class="d-flex justify-content-between small mb-1">
                            <span>Số lượng:</span>
                            <span id="modal-display-qty"></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between">
                            <span class="fw-bold">Tổng thanh toán:</span>
                            <span class="fw-bold text-danger fs-5" id="modal-total-price"></span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="small fw-bold">Địa chỉ nhận hàng:</label>
                        <textarea name="diaChi" class="form-control" rows="2" placeholder="Số nhà, tên đường..." required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="small fw-bold">Số điện thoại:</label>
                        <input type="text" name="sdtNguoiNhan" class="form-control" placeholder="Nhập SĐT..." required>
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="submit" class="btn btn-danger w-100 fw-bold py-2 shadow-sm" style="border-radius: 10px;">ĐẶT HÀNG NGAY</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script>
    let currentPrice = ${not empty variants ? variants[0].giaBienThe : detail.giaCoBan};
    let currentVariantId = "${not empty variants ? variants[0].idBienThe : ''}";
    let currentVariantName = "${not empty variants ? variants[0].tenBienThe : ''}";
    let isAdding = false;

    function updatePrice(id, price, name) {
        currentPrice = price;
        currentVariantId = id;
        currentVariantName = name;
        const formatter = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' });
        document.getElementById('display-price').innerText = formatter.format(price).replace('₫', 'đ');
    }

    function changeQty(val) {
        const input = document.getElementById('buy-quantity');
        let current = parseInt(input.value) || 1;
        if (val === 1) input.value = current + 1;
        else if (val === -1 && current > 1) input.value = current - 1;
    }

    // HÀM THÊM GIỎ HÀNG KHÔNG LOAD TRANG
    function addCartAjaxDetail() {
        const userLoggedIn = ${not empty sessionScope.user ? 'true' : 'false'};
        if (!userLoggedIn) {
            window.location.href = '${pageContext.request.contextPath}/dang-nhap.jsp';
            return;
        }

        const qty = document.getElementById('buy-quantity').value;
        isAdding = true;
        // Sử dụng currentVariantId được cập nhật khi click chọn radio
        const url = '${pageContext.request.contextPath}/GioHangServlet?action=add&idBienThe=' + currentVariantId + '&soLuong=' + qty; 
        document.getElementById('hidden_iframe').src = url;
    }

    function handleIframeLoad() {
        const iframe = document.getElementById('hidden_iframe');
        if (isAdding && iframe.src !== "about:blank") {
            // Hiện Toast
            var toastEl = document.getElementById('cartToast');
            var toast = new bootstrap.Toast(toastEl);
            toast.show();

            // Cập nhật số lượng Badge trên Menu
            const badge = document.getElementById('cart-badge');
            if (badge) {
                const qtyAdded = parseInt(document.getElementById('buy-quantity').value) || 1;
                let currentCount = parseInt(badge.innerText.trim()) || 0;
                badge.innerText = currentCount + qtyAdded;
            }
            isAdding = false;
        }
    }

    function prepareCheckout() {
        const qty = document.getElementById('buy-quantity').value;
        const total = currentPrice * qty;
        const formatter = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' });

        document.getElementById('modal-id-bien-the').value = currentVariantId;
        document.getElementById('modal-so-luong').value = qty;
        document.getElementById('modal-variant-name').innerText = currentVariantName;
        document.getElementById('modal-unit-price').innerText = formatter.format(currentPrice).replace('₫', 'đ');
        document.getElementById('modal-display-qty').innerText = "x" + qty;
        document.getElementById('modal-total-price').innerText = formatter.format(total).replace('₫', 'đ');
    }
</script>

<style>
    .variant-btn { border-radius: 10px; min-width: 90px; border: 2px solid #dee2e6; color: #333; transition: 0.2s; }
    .btn-check:checked + .variant-btn { border-color: #d70018 !important; color: #d70018 !important; background-color: #fff !important; box-shadow: 0 0 0 1px #d70018; }
    .btn-check:disabled + .variant-btn { opacity: 0.5; cursor: not-allowed; }
    .grayscale { filter: grayscale(100%); opacity: 0.6; }
    .breadcrumb-item + .breadcrumb-item::before { content: ">"; }
    .badge { padding: 0.5em 0.8em; border-radius: 8px; }
</style>
