<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang hệ Jakarta --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<style>
    .star-rating i { 
        cursor: pointer; 
        transition: 0.2s; 
        margin: 0 5px;
    }
    .star-rating i:hover { transform: scale(1.3); }
    /* Màu vàng cho sao đã chọn, màu xám cho sao chưa chọn */
    .text-warning { color: #ffc107 !important; }
    .text-muted { color: #ccc !important; }
</style>

<main class="container my-5">
    <div class="mx-auto" style="max-width: 600px;">
        <div class="card border-0 shadow-sm p-4 text-center">
            <h3 class="fw-bold mb-3 text-danger text-uppercase">Đánh giá sản phẩm</h3>
            
            <%-- Hiển thị thông tin sản phẩm đang đánh giá --%>
            <img src="${pageContext.request.contextPath}${productToEval.urlAnh}" width="120" class="mx-auto mb-3 rounded border shadow-sm">
            <h5 class="fw-bold">${productToEval.tenSanPham}</h5>
            <p class="text-muted small">${productToEval.tenBienThe}</p>
            
            <form action="${pageContext.request.contextPath}/DanhGiaServlet" method="post" id="evaluationForm" class="mt-4">

                <%-- Các thông tin ẩn gửi về server --%>
                <input type="hidden" name="id_don_hang" value="${param.idDonHang}">
                <input type="hidden" name="id_bien_the" value="${param.idBienThe}">

                <p class="mb-2 fw-bold text-secondary">Bạn thấy sản phẩm này thế nào?</p>
                
                <%-- Phần chọn sao - Mặc định hiện 5 sao --%>
                <div class="mb-4 star-rating" id="starContainer">
                    <i class="bi bi-star-fill text-warning" data-value="1"></i>
                    <i class="bi bi-star-fill text-warning" data-value="2"></i>
                    <i class="bi bi-star-fill text-warning" data-value="3"></i>
                    <i class="bi bi-star-fill text-warning" data-value="4"></i>
                    <i class="bi bi-star-fill text-warning" data-value="5"></i>
                </div>
                
                <%-- Input này lưu số lượng sao để gửi về --%>
                <input type="hidden" name="so_sao" id="ratingValue" value="5">

                <div class="mb-3 text-start">
                    <label class="form-label fw-bold">Cảm nhận của bạn</label>
                    <textarea class="form-control border-danger-subtle shadow-none" 
                              name="noi_dung" rows="4" required
                              placeholder="Hãy chia sẻ trải nghiệm của bạn về sản phẩm này nhé..."></textarea>
                </div>
                
                <button type="submit" class="btn btn-danger w-100 py-3 fw-bold shadow-sm">
                    GỬI ĐÁNH GIÁ NGAY
                </button>
            </form>
        </div>
    </div>
</main>

<%-- MODAL CẢM ƠN SAU KHI GỬI THÀNH CÔNG --%>
<c:if test="${param.status == 'success'}">
    <div class="modal fade show" id="evalSuccessModal" tabindex="-1" style="display: block; background: rgba(0,0,0,0.5); z-index: 1060;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-body text-center p-5">
                    <div class="mb-4">
                        <i class="bi bi-heart-fill text-danger" style="font-size: 4rem;"></i>
                    </div>
                    <h4 class="fw-bold mb-3">Cảm ơn bà nhiều nha!</h4>
                    <p class="text-muted mb-4">
                        Đánh giá của bà cực kỳ hữu ích với ClickBuy và các khách hàng khác đó.
                    </p>
                    <button type="button" class="btn btn-danger px-5 fw-bold" 
                            onclick="window.location.href='${pageContext.request.contextPath}/user/lich-su-don-hang.jsp'">
                        QUAY LẠI ĐƠN HÀNG
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script>
    // Script xử lý hiệu ứng chọn sao mượt mà
    const stars = document.querySelectorAll('#starContainer i');
    const ratingInput = document.getElementById('ratingValue');

    stars.forEach(star => {
        star.addEventListener('click', function() {
            const val = parseInt(this.getAttribute('data-value'));
            ratingInput.value = val;
            
            // Cập nhật giao diện sao: vàng cho sao đã chọn, xám cho sao còn lại
            stars.forEach(s => {
                const sVal = parseInt(s.getAttribute('data-value'));
                if(sVal <= val) {
                    s.classList.remove('bi-star', 'text-muted');
                    s.classList.add('bi-star-fill', 'text-warning');
                } else {
                    s.classList.remove('bi-star-fill', 'text-warning');
                    s.classList.add('bi-star', 'text-muted');
                }
            });
        });
    });
</script>

<jsp:include page="../common/footer.jsp" />
