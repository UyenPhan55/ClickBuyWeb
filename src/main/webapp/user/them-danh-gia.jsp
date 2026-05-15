<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
        color: #ffc107;
        cursor: pointer;
        margin-bottom: 25px;
        display: flex;
        justify-content: center;
        gap: 15px;
    }
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
            <p class="text-muted mt-3">Bạn cảm thấy sản phẩm thế nào?</p>
        </div>

        <form id="simpleForm">
            <div class="star-rating" id="starContainer">
                <i class="bi bi-star-fill" data-value="1"></i>
                <i class="bi bi-star-fill" data-value="2"></i>
                <i class="bi bi-star-fill" data-value="3"></i>
                <i class="bi bi-star-fill" data-value="4"></i>
                <i class="bi bi-star-fill" data-value="5"></i>
            </div>

            <div class="mb-4 text-start">
                <label class="form-label fw-bold small text-uppercase text-secondary">Cảm nhận</label>
                <textarea class="form-control shadow-none" rows="4" 
                          placeholder="Viết đánh giá..." 
                          style="border-radius: 10px; border: 1px solid #ddd;"></textarea>
            </div>

            <button type="button" onclick="showSimpleToast()" class="btn btn-submit-eval shadow-sm">
                GỬI ĐÁNH GIÁ
            </button>
        </form>
    </div>
</main>

<script>
    const stars = document.querySelectorAll('#starContainer i');
    stars.forEach(star => {
        star.addEventListener('click', function() {
            const val = parseInt(this.getAttribute('data-value'));
            stars.forEach(s => {
                s.style.color = (parseInt(s.getAttribute('data-value')) <= val) ? '#ffc107' : '#ccc';
            });
        });
    });

    function showSimpleToast() {
        Swal.fire({
            toast: true,
            position: 'bottom-end', // Góc dưới bên phải
            icon: 'success',
            title: 'Đã gửi đánh giá',
            showConfirmButton: false,
            timer: 2000, // Hiện 2 giây thôi cho nhanh
            timerProgressBar: false, // Bỏ thanh chạy
            showClass: { popup: 'animate__animated animate__fadeInUp' }, // Hiệu ứng hiện lên nhẹ nhàng
            hideClass: { popup: 'animate__animated animate__fadeOutDown' } // Hiệu ứng biến mất nhẹ nhàng
        });
    }
</script>

<jsp:include page="../common/footer.jsp" />
