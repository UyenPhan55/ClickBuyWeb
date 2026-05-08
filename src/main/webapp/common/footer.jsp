<%@page contentType="text/html" pageEncoding="UTF-8"%>
<footer class="bg-dark text-white pt-5 pb-4 mt-auto">
    <div class="container text-center text-md-start">
        <div class="row text-center text-md-start">
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-danger">ClickBuy</h5>
                <p>Hệ thống bán lẻ điện thoại toàn quốc. Chất lượng thật - Giá trị thật.</p>
            </div>

            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold">Hỗ trợ</h5>
                <p><a href="#" class="text-white text-decoration-none">Chính sách bảo hành</a></p>
                <p><a href="#" class="text-white text-decoration-none">Hình thức thanh toán</a></p>
            </div>

            <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold">Liên hệ</h5>
                <p><i class="bi bi-house-door-fill me-2"></i> Hà Nội, Việt Nam</p>
                <p><i class="bi bi-envelope-fill me-2"></i> abc@clickbuy.com</p>
                <p><i class="bi bi-telephone-fill me-2"></i> 1234.1234</p>
            </div>
        </div>
        
        <hr class="mb-4">
        <div class="row align-items-center">
            <div class="col-md-12 text-center">
                <p>WEBSITE KINH DOANH THIẾT BỊ DI ĐỘNG <strong class="text-danger">CLICKBUY</strong></p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var currentPage = window.location.pathname.split("/").pop();
            var navLinks = document.querySelectorAll('.nav-link');

            navLinks.forEach(function(link) {
                var linkPage = link.getAttribute('href').split("/").pop();

            // Nếu khớp trang thì mặc áo "active-custom"
                if (currentPage === linkPage) {
                    link.classList.add('active-custom');
                } else {
                    link.classList.remove('active-custom');
                }
            });
        });
    </script>
</footer>
</body> 
</html>