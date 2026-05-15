<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@page import="java.util.*, model.DanhGia, dao.DanhGiaDAO" %>

<%-- 
    BƯỚC 1: Lấy dữ liệu đánh giá thật từ Database
--%>
<%
    try {
        model.SanPham currentSp = (model.SanPham)request.getAttribute("detail");
        if (currentSp != null) {
            DanhGiaDAO dgDao = new DanhGiaDAO();
            // Lấy toàn bộ đánh giá (Bà có thể viết thêm hàm lọc theo idSanPham trong DAO nếu muốn tối ưu)
            List<DanhGia> allReviews = dgDao.getAllDanhGia();
            List<DanhGia> productReviews = new ArrayList<>();
            
            int totalStars = 0;
            for (DanhGia dg : allReviews) {
                // Giả định logic: Lấy các đánh giá thuộc về sản phẩm này và đã được duyệt (trang_thai = 1)
                if (dg.getTenSanPham().equals(currentSp.getTenSanPham()) && dg.getTrangThai() == 1) {
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

                <%-- PHẦN SAO VÀ ĐÁNH GIÁ THẬT --%>
                <div class="d-flex align-items-center mb-3">
                    <span class="text-warning me-2 small">
                        <c:forEach begin="1" end="5" var="i">
                            <i class="bi ${i <= avgStars ? 'bi-star-fill' : (i - 0.5 <= avgStars ? 'bi-star-half' : 'bi-star')}"></i>
                        </c:forEach>
                    </span>
                    <span class="text-primary small">
                        (${not empty reviews ? reviews.size() : 0} đánh giá) | 
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
                    <button type="button" class="btn ${detail.trangThai == 1 ? 'btn-danger' : 'btn-secondary'} fw-bold px-4 py-3 shadow-sm flex-grow-1" 
                            style="border-radius: 12px; font-size: 1.1rem;"
                            ${detail.trangThai == 1 ? 'data-bs-toggle="modal" data-bs-target="#checkoutModal" onclick="prepareCheckout()"' : 'disabled'}>
                        ${detail.trangThai == 1 ? 'MUA NGAY' : 'NGỪNG KINH DOANH'}
                    </button>
                    
                    <button type="button" class="btn btn-outline-danger fw-bold px-4 py-3 shadow-sm" 
                            style="border-radius: 12px;" 
                            ${detail.trangThai == 0 ? 'disabled' : ''}
                            onclick="addCartAjaxDetail()">
                        <i class="bi ${detail.trangThai == 1 ? 'bi-cart-plus' : 'bi-cart-x'} fs-4"></i>
                    </button>
                </div>
            </div>
        </div>

        <%-- MÔ TẢ CHI TIẾT --%>
        <div class="row pt-5 border-top">
            <div class="col-12">
                <div class="card border-0 shadow-sm p-4 mb-5" style="border-radius: 15px;">
                    <h5 class="fw-bold border-bottom pb-3 mb-3 text-uppercase text-danger">Thông tin chi tiết</h5>
                    <div class="content-detail" style="line-height: 1.8;">
                        ${not empty detail.moTa ? detail.moTa : "Đang cập nhật nội dung cho sản phẩm này..."}
                    </div>
                </div>
            </div>
        </div>

        <%-- DANH SÁCH ĐÁNH GIÁ THẬT TỪ SQL --%>
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm p-4" style="border-radius: 15px;">
                    <h5 class="fw-bold border-bottom pb-3 mb-4 text-uppercase text-danger">Đánh giá từ khách hàng</h5>
                    
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <c:forEach var="dg" items="${reviews}">
                                <div class="d-flex mb-4 border-bottom pb-3">
                                    <div class="flex-shrink-0">
                                        <div class="bg-danger-subtle text-danger rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 50px; height: 50px;">
                                            ${dg.tenNguoiDung.substring(0,1).toUpperCase()}
                                        </div>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="fw-bold mb-0">${dg.tenNguoiDung}</h6>
                                            <small class="text-muted"><fmt:formatDate value="${dg.ngayDanhGia}" pattern="dd/MM/yyyy HH:mm" /></small>
                                        </div>
                                        <div class="text-warning small mb-1">
                                            <c:forEach begin="1" end="${dg.soSao}"><i class="bi bi-star-fill"></i></c:forEach>
                                        </div>
                                        <p class="mb-1 text-dark">${dg.noiDung}</p>
                                        <c:if test="${not empty dg.tenBienThe}">
                                            <small class="text-muted d-block mb-2 italic">Phân loại: ${dg.tenBienThe}</small>
                                        </c:if>
                                        
                                        <%-- Trả lời của Shop --%>
                                        <c:if test="${not empty dg.traLoi}">
                                            <div class="bg-light p-3 rounded mt-2 border-start border-4 border-danger">
                                                <p class="mb-1 fw-bold small text-danger"><i class="bi bi-patch-check-fill"></i> Phản hồi từ ClickBuy</p>
                                                <p class="mb-0 small text-dark italic">"${dg.traLoi}"</p>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="bi bi-chat-dots fs-1 text-muted"></i>
                                <p class="text-muted mt-3">Chưa có đánh giá nào cho sản phẩm này.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:if>
</main>

<%-- ... Giữ nguyên các phần Toast, Iframe, Modal và Script ở phía dưới bà nhé ... --%>

<jsp:include page="/common/footer.jsp" />

<script>
    // Giữ nguyên toàn bộ phần script cũ của bà ở đây
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

    function addCartAjaxDetail() {
        const userLoggedIn = ${not empty sessionScope.user ? 'true' : 'false'};
        if (!userLoggedIn) {
            window.location.href = '${pageContext.request.contextPath}/dang-nhap.jsp';
            return;
        }
        const qty = document.getElementById('buy-quantity').value;
        isAdding = true;
        const url = '${pageContext.request.contextPath}/GioHangServlet?action=add&idBienThe=' + currentVariantId + '&soLuong=' + qty; 
        document.getElementById('hidden_iframe').src = url;
    }

    function handleIframeLoad() {
        const iframe = document.getElementById('hidden_iframe');
        if (isAdding && iframe.src !== "about:blank") {
            var toastEl = document.getElementById('cartToast');
            var toast = new bootstrap.Toast(toastEl);
            toast.show();
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
    /* CSS cũ của bà và tui thêm chút cho phần đánh giá */
    .variant-btn { border-radius: 10px; min-width: 90px; border: 2px solid #dee2e6; color: #333; transition: 0.2s; }
    .btn-check:checked + .variant-btn { border-color: #d70018 !important; color: #d70018 !important; background-color: #fff !important; box-shadow: 0 0 0 1px #d70018; }
    .btn-check:disabled + .variant-btn { opacity: 0.5; cursor: not-allowed; }
    .grayscale { filter: grayscale(100%); opacity: 0.6; }
    .breadcrumb-item + .breadcrumb-item::before { content: ">"; }
    .badge { padding: 0.5em 0.8em; border-radius: 8px; }
    .italic { font-style: italic; }
</style>
