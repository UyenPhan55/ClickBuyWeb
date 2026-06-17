
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@page import="java.util.*, model.DanhGia, dao.DanhGiaDAO" %>

<%
    try {
        model.SanPham currentSp = (model.SanPham)request.getAttribute("detail");
        if (currentSp != null) {
            DanhGiaDAO dgDao = new DanhGiaDAO();
         
            List<DanhGia> allReviews = dgDao.getAllDanhGia();
            List<DanhGia> productReviews = new ArrayList<>();
            
            int totalStars = 0;
            for (DanhGia dg : allReviews) {
               
                if (dg.getTenSanPham() != null && dg.getTenSanPham().equals(currentSp.getTenSanPham()) && dg.getTrangThai() == 1) {
                    productReviews.add(dg);
                    totalStars += dg.getSoSao();
                }
            }
            
            double avg = productReviews.isEmpty() ? 5.0 : (double)totalStars / productReviews.size();
            request.setAttribute("reviews", productReviews);
            request.setAttribute("avgStars", avg);
        }
    } catch (Exception e) { e.printStackTrace(); }
%>

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
          
            <div class="col-md-6 text-center">
                <div class="card border-0 shadow-sm p-4 sticky-top" style="top: 100px; z-index: 10; border-radius: 20px;">
                    <img src="${pageContext.request.contextPath}${detail.urlAnh.contains('/') ? (detail.urlAnh.startsWith('/') ? '' : '/') : '/assets/images/'}${detail.urlAnh}" 
                         class="img-fluid ${detail.trangThai == 0 ? 'grayscale' : ''}" 
                         style="max-height: 450px; object-fit: contain;" alt="${detail.tenSanPham}">
                </div>
            </div>

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
                    <span class="text-warning me-2 small">
                        <c:forEach begin="1" end="5" var="i">
                            <i class="bi ${i <= avgStars ? 'bi-star-fill' : (i - 0.5 <= avgStars ? 'bi-star-half' : 'bi-star')}"></i>
                        </c:forEach>
                    </span>
                    <span class="text-primary small">
                        (${not empty reviews ? reviews.size() : 0} đánh giá thật) | 
                        <span class="text-muted">Đã bán ${(detail.idSanPham * 13) + 50}+</span>
                    </span>
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
                    <button type="button" class="btn ${(detail.trangThai == 1 && not empty variants) ? 'btn-danger' : 'btn-secondary'} fw-bold px-4 py-3 shadow-sm flex-grow-1" 
                            style="border-radius: 12px; font-size: 1.1rem;"
                            ${(detail.trangThai == 1 && not empty variants) ? 'onclick="buyNow()"' : 'disabled'}>
                        ${(detail.trangThai == 1 && not empty variants) ? 'MUA NGAY' : (empty variants ? 'CHƯA CÓ HÀNG' : 'NGỪNG KINH DOANH')}
                    </button>
                    
                    <button type="button" class="btn btn-outline-danger fw-bold px-4 py-3 shadow-sm" 
                            style="border-radius: 12px;" 
                            ${(detail.trangThai == 1 && not empty variants) ? '' : 'disabled'}
                            onclick="addCartAjaxDetail()">
                        <i class="bi ${(detail.trangThai == 1 && not empty variants) ? 'bi-cart-plus' : 'bi-cart-x'} fs-4"></i>
                    </button>
                </div>
                <c:if test="${detail.trangThai == 0}">
                    <p class="text-danger mt-3 small fw-bold"><i class="bi bi-info-circle me-1"></i> Sản phẩm này hiện tại không còn bán.</p>
                </c:if>
                <c:if test="${detail.trangThai == 1 && empty variants}">
                    <p class="text-danger mt-3 small fw-bold"><i class="bi bi-info-circle me-1"></i> Sản phẩm này chưa được cấu hình phiên bản bán hàng.</p>
                </c:if>
            </div>
        </div>

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

        <div class="row pt-2">
            <div class="col-12">
                <div class="card border-0 shadow-sm p-4 mb-4" style="border-radius: 15px;">
                    <h5 class="fw-bold border-bottom pb-3 mb-4 text-uppercase text-danger">Đánh giá từ khách hàng</h5>
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <c:forEach var="dg" items="${reviews}">
                                <div class="d-flex mb-4 border-bottom pb-3">
                                    <div class="flex-shrink-0">
                                        <div class="bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 45px; height: 45px;">
                                            ${dg.tenNguoiDung.substring(0,1).toUpperCase()}
                                        </div>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="fw-bold mb-0">${dg.tenNguoiDung}</h6>
                                            <small class="text-muted"><fmt:formatDate value="${dg.ngayDanhGia}" pattern="dd/MM/yyyy" /></small>
                                        </div>
                                        <div class="text-warning small mb-1">
                                            <c:forEach begin="1" end="${dg.soSao}"><i class="bi bi-star-fill"></i></c:forEach>
                                        </div>
                                        <p class="mb-1 text-dark">${dg.noiDung}</p>
                                        <c:if test="${not empty dg.traLoi}">
                                            <div class="bg-light p-3 rounded mt-2 border-start border-4 border-danger">
                                                <p class="mb-1 fw-bold small text-danger"><i class="bi bi-patch-check-fill"></i> Phản hồi từ ClickBuy</p>
                                                <p class="mb-0 small text-dark italic" style="font-style: italic;">"${dg.traLoi}"</p>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center text-muted py-3">Chưa có đánh giá nào cho sản phẩm này.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:if>
</main>

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

<iframe name="hidden_iframe" id="hidden_iframe" style="display:none;" src="about:blank" onload="handleIframeLoad()"></iframe>



<jsp:include page="/common/footer.jsp" />

<script>
    let currentPrice = ${not empty variants ? variants[0].giaBienThe : detail.giaCoBan};
    let currentVariantId = "${not empty variants ? variants[0].idBienThe : ''}";
    let currentVariantName = "${not empty variants ? variants[0].tenBienThe : ''}";
    let isAdding = false;
    let isBuyNow = false;

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

    function isVariantIdValid(variantId) {
        if (!variantId) return false;
        const trimmed = String(variantId).trim();
        if (trimmed === "" || trimmed === "0" || trimmed === "null" || trimmed === "undefined") {
            return false;
        }
        const parsed = parseInt(trimmed, 10);
        return !isNaN(parsed) && parsed > 0;
    }

    function addCartAjaxDetail() {
        const userLoggedIn = ${not empty sessionScope.user ? 'true' : 'false'};
        if (!userLoggedIn) {
            window.location.href = '${pageContext.request.contextPath}/dang-nhap.jsp';
            return;
        }

        if (!isVariantIdValid(currentVariantId)) {
            alert('Sản phẩm này chưa được chọn phiên bản hoặc chưa có phiên bản để bán. Vui lòng kiểm tra lại!');
            return;
        }

        const qty = document.getElementById('buy-quantity').value;
        isAdding = true;
        isBuyNow = false;

        // Gửi cả 2 cách đặt tên (idBienThe/id_bien_the) để dù Servlet gọi kiểu gì cũng nhận được
        const url = '${pageContext.request.contextPath}/GioHangServlet?action=add&idSanPham=${detail.idSanPham}&idBienThe=' + currentVariantId + '&id_bien_the=' + currentVariantId + '&soLuong=' + qty + '&so_luong=' + qty; 

        document.getElementById('hidden_iframe').src = url;
    }

    function buyNow() {
        const userLoggedIn = ${not empty sessionScope.user ? 'true' : 'false'};
        if (!userLoggedIn) {
            window.location.href = '${pageContext.request.contextPath}/dang-nhap.jsp';
            return;
        }

        if (!isVariantIdValid(currentVariantId)) {
            alert('Sản phẩm này chưa được chọn phiên bản hoặc chưa có phiên bản để bán. Vui lòng kiểm tra lại!');
            return;
        }

        const qty = document.getElementById('buy-quantity').value;
        isAdding = true;
        isBuyNow = true;

        const url = '${pageContext.request.contextPath}/GioHangServlet?action=add&idSanPham=${detail.idSanPham}&idBienThe=' + currentVariantId + '&id_bien_the=' + currentVariantId + '&soLuong=' + qty + '&so_luong=' + qty; 

        document.getElementById('hidden_iframe').src = url;
    }

    function handleIframeLoad() {
        const iframe = document.getElementById('hidden_iframe');
        if (isAdding && iframe.src !== "about:blank") {
            try {
                const iframeDocument = iframe.contentDocument || iframe.contentWindow.document;
                const responseText = iframeDocument.body.innerText.trim();
                
                if (responseText === "success") {
                    if (isBuyNow) {
                        isAdding = false;
                        isBuyNow = false;
                        window.location.href = '${pageContext.request.contextPath}/DonHangServlet?action=checkout';
                    } else {
                        var toastEl = document.getElementById('cartToast');
                        var toast = new bootstrap.Toast(toastEl);
                        toast.show();

                        const badge = document.getElementById('cart-badge');
                        if (badge) {
                            const qtyAdded = parseInt(document.getElementById('buy-quantity').value) || 1;
                            let currentCount = parseInt(badge.innerText.trim()) || 0;
                            badge.innerText = currentCount + qtyAdded;
                            badge.classList.remove('d-none');
                        }
                        isAdding = false;
                    }
                } else if (responseText === "error_auth") {
                    alert("Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại!");
                    isAdding = false;
                    isBuyNow = false;
                    window.location.href = '${pageContext.request.contextPath}/dang-nhap.jsp';
                } else {
                    let friendlyError = "Không thể thêm vào giỏ hàng.";
                    if (responseText === "error_format") {
                        friendlyError += " (Lỗi định dạng dữ liệu từ máy chủ)";
                    } else if (responseText === "error_missing_params") {
                        friendlyError += " (Thiếu thông tin biến thể)";
                    } else if (responseText === "error_invalid_id") {
                        friendlyError += " (Biến thể không hợp lệ)";
                    } else {
                        friendlyError += " Lỗi: " + responseText;
                    }
                    alert(friendlyError);
                    isAdding = false;
                    isBuyNow = false;
                }
            } catch (e) {
                console.error("Lỗi đọc phản hồi giỏ hàng:", e);
                isAdding = false;
                isBuyNow = false;
            }
        }
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
