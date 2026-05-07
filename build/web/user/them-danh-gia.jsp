<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<style>
    .star-rating i { cursor: pointer; transition: 0.2s; }
    .star-rating i:hover { transform: scale(1.2); }
</style>

<main class="container my-5">
    <div class="mx-auto" style="max-width: 600px;">
        <div class="card border-0 shadow-sm p-4 text-center">
            <h3 class="fw-bold mb-3 text-danger text-uppercase">Đánh giá sản phẩm</h3>
            
           
            <img src="${pageContext.request.contextPath}${productToEval.urlAnh}" width="120" class="mx-auto mb-3 rounded border">
            <h5 class="fw-bold">${productToEval.tenSanPham}</h5>
            <p class="text-muted small">${productToEval.tenBienThe}</p>
            
            <form action="${pageContext.request.contextPath}/DanhGiaServlet" method="post" id="evaluationForm" class="mt-4">

                <input type="hidden" name="id_don_hang" value="${param.idDonHang}">
                <input type="hidden" name="id_bien_the" value="${param.idBienThe}">

                <p class="mb-2 fw-bold text-secondary">Bạn thấy sản phẩm này thế nào?</p>
                
                <%-- Phần chọn sao --%>
                <div class="mb-4 text-warning fs-2 star-rating" id="starContainer">
                    <i class="bi bi-star-fill" data-value="1"></i>
                    <i class="bi bi-star-fill" data-value="2"></i>
                    <i class="bi bi-star-fill" data-value="3"></i>
                    <i class="bi bi-star-fill" data-value="4"></i>
                    <i class="bi bi-star-fill" data-value="5"></i>
                </div>
                <%-- Input này sẽ lưu số sao để gửi về Server --%>
                <input type="hidden" name="so_sao" id="ratingValue" value="5">

                <div class="mb-3 text-start">
                    <label class="form-label fw-bold">Nội dung</label>
                    <textarea class="form-control border-danger-subtle shadow-none" 
                              name="noi_dung" rows="4" required
                              placeholder="Hãy đánh giá đơn hàng..."></textarea>
                </div>
                
                <button type="submit" class="btn btn-danger w-100 py-3 fw-bold shadow-sm">
                    GỬI ĐÁNH GIÁ NGAY
                </button>
            </form>
        </div>
    </div>
</main>

<%-- Hiện Modal khi các bạn Java xử lý xong và quay lại trang kèm status=success --%>
<c:if test="${param.status == 'success'}">
    <div class="modal fade show" id="evalSuccessModal" tabindex="-1" style="display: block; background: rgba(0,0,0,0.5);">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-body text-center p-5">
                    <div class="mb-4">
                        <i class="bi bi-heart-fill text-danger" style="font-size: 4rem;"></i>
                    </div>
                    <h4 class="fw-bold mb-3">Cảm ơn bạn nhiều</h4>
                    <p class="text-muted mb-4">
                        Đánh giá của bạn cực kỳ hữu tích với ClickBuy và các khách hàng khác
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
  
    const stars = document.querySelectorAll('#starContainer i');
    const ratingInput = document.getElementById('ratingValue');

    stars.forEach(star => {
        star.addEventListener('click', function() {
            const val = this.getAttribute('data-value');
            ratingInput.value = val;
            
            stars.forEach(s => {
                if(parseInt(s.getAttribute('data-value')) <= parseInt(val)) {
                    s.classList.replace('bi-star', 'bi-star-fill');
                } else {
                    s.classList.replace('bi-star-fill', 'bi-star');
                }
            });
        });
    });
</script>

<jsp:include page="../common/footer.jsp" />