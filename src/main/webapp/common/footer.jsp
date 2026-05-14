<%@page contentType="text/html" pageEncoding="UTF-8"%>

<footer class="bg-dark text-white pt-5 pb-4 mt-auto">
    <div class="container text-center text-md-start">
        <div class="row text-center text-md-start">
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold text-danger">ClickBuy</h5>
                <p>Hệ thống bán lẻ điện thoại toàn quốc. Chất lượng thật - Giá trị thật.</p>
            </div>
            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold">Hỗ trợ</h5>
                <p>
                    <a href="${pageContext.request.contextPath}/BaoHanhServlet"
                       class="text-white text-decoration-none">Chính sách bảo hành</a>
                </p>
                <p>
                    <a href="#" class="text-white text-decoration-none">
                        Hình thức thanh toán
                    </a>
                </p>
            </div>
            <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold">Liên hệ</h5>
                <p><i class="bi bi-house-door-fill me-2"></i> Hà Nội, Việt Nam</p>
                <p><i class="bi bi-envelope-fill me-2"></i> abc@clickbuy.com</p>
                <p><i class="bi bi-telephone-fill me-2"></i> 1234.1234</p>
            </div>
        </div>

        <hr class="mb-4">
        <div class="row align-items-center">
            <div class="col-md-12 text-center">
                <p>WEBSITE KINH DOANH THIẾT BỊ DI ĐỘNG
                    <strong class="text-danger">CLICKBUY</strong>
                </p>
            </div>
        </div>
    </div>
</footer>

<%--  Script chỉ load 1 lần ở đây --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

<%--  Xóa hết phần </div></div> thừa của admin layout --%>
</body>
</html>