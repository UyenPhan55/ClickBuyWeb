<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<style>
    .eval-container {
        max-width: 600px;
        margin: 50px auto;
        background: #fff;
        border-radius: 20px;
        padding: 40px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
    }
    .eval-header { text-align: center; margin-bottom: 30px; }
    .star-rating {
        font-size: 2.8rem;
        color: #ccc;
        cursor: pointer;
        margin-bottom: 25px;
        display: flex;
        justify-content: center;
        gap: 15px;
    }
    .star-rating .active { color: #ffc107; }
    .btn-submit-eval {
        background-color: #d70018;
        color: #fff;
        font-weight: bold;
        padding: 15px;
        border-radius: 12px;
        border: none;
        width: 100%;
        transition: 0.3s;
    }
    .btn-submit-eval:hover { background-color: #b50014; color: #fff; }
</style>

<main class="container">
    <div class="eval-container">
        <div class="eval-header">
            <h3 class="fw-bold text-danger text-uppercase mb-2">Đánh giá sản phẩm</h3>
            <p class="text-muted mt-3">Đơn hàng #${param.idDonHang}</p>
        </div>

        <c:if test="${empty sessionScope.user}">
            <div class="alert alert-warning">Vui lòng <a href="${pageContext.request.contextPath}/dang-nhap.jsp">đăng nhập</a> để đánh giá.</div>
        </c:if>

        <c:if test="${not empty sessionScope.user}">
            <form action="${pageContext.request.contextPath}/danh-gia" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="idDonHang" value="${param.idDonHang}">
                <input type="hidden" name="idBienThe" value="${param.idBienThe}">
                <input type="hidden" name="soSao" id="soSao" value="5">

                <div class="star-rating" id="starContainer">
                    <i class="bi bi-star-fill active" data-value="1"></i>
                    <i class="bi bi-star-fill active" data-value="2"></i>
                    <i class="bi bi-star-fill active" data-value="3"></i>
                    <i class="bi bi-star-fill active" data-value="4"></i>
                    <i class="bi bi-star-fill active" data-value="5"></i>
                </div>

                <div class="mb-4 text-start">
                    <label class="form-label fw-bold small text-uppercase text-secondary">Cảm nhận</label>
                    <textarea name="noiDung" class="form-control shadow-none" rows="4"
                              placeholder="Viết đánh giá..."
                              style="border-radius: 10px; border: 1px solid #ddd;" required></textarea>
                </div>

                <button type="submit" class="btn btn-submit-eval shadow-sm">
                    GỬI ĐÁNH GIÁ
                </button>
            </form>
        </c:if>
    </div>
</main>

<script>
    const stars = document.querySelectorAll('#starContainer i');
    const soSaoInput = document.getElementById('soSao');
    let selected = 5;

    function paintStars(val) {
        stars.forEach(s => {
            const v = parseInt(s.getAttribute('data-value'));
            s.classList.toggle('active', v <= val);
        });
    }

    stars.forEach(star => {
        star.addEventListener('click', function() {
            selected = parseInt(this.getAttribute('data-value'));
            soSaoInput.value = selected;
            paintStars(selected);
        });
    });
</script>

<jsp:include page="../common/footer.jsp" />
