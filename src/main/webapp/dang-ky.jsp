<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - ClickBuy</title>
    <jsp:include page="common/header.jsp" />
    <style>
        .back-to-home { color: #6c757d; text-decoration: none; font-size: 14px; transition: 0.3s; }
        .back-to-home:hover { color: #d70018; }
        .form-control:focus { border-color: #d70018; box-shadow: 0 0 0 0.25rem rgba(215, 0, 24, 0.25); }
        body { background-color: #f8f9fa; }
        /* Style nhỏ để nút mắt trông mượt hơn */
        .btn-outline-secondary { border-color: #dee2e6; color: #6c757d; }
        .btn-outline-secondary:hover { background-color: #f8f9fa; color: #d70018; border-color: #ced4da; }
    </style>
</head>
<body>
    <jsp:include page="common/navbar-user.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="mb-3">
                    <a href="${pageContext.request.contextPath}/TrangChuServlet" class="back-to-home">
                        <i class="bi bi-arrow-left"></i> Quay về trang chủ
                    </a>
                </div>
                <div class="card border-0 shadow-lg p-4" style="border-radius: 15px;">
                    <div class="text-center mb-4">
                        <h3 class="fw-bold text-danger">ĐĂNG KÝ TÀI KHOẢN</h3>
                        <p class="text-muted">Tham gia ClickBuy ngay hôm nay!</p>
                    </div>

                    <%-- Hiện lỗi bằng JSTL thay cho Scriptlet cũ --%>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger text-center py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        </div>
                    </c:if>

                    <%-- Form gửi dữ liệu đến AuthServlet --%>
                    <form action="${pageContext.request.contextPath}/AuthServlet" method="post">
                        <input type="hidden" name="action" value="register">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold small">Họ và tên</label>
                            <input type="text" name="ten_day_du" class="form-control shadow-none" 
                                   placeholder="Nhập tên của bạn" value="${param.ten_day_du}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold small">Email đăng nhập</label>
                            <input type="email" name="email" class="form-control shadow-none" 
                                   placeholder="example@gmail.com" value="${param.email}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold small">Số điện thoại</label>
                            <input type="text" name="sdt" class="form-control shadow-none" 
                                   placeholder="Nhập số điện thoại" value="${param.sdt}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold small">Mật khẩu</label>
                            <div class="input-group">
                                <input type="password" name="mat_khau" id="password" class="form-control shadow-none" 
                                       placeholder="********" required>
                                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold small">Xác nhận mật khẩu</label>
                            <div class="input-group">
                                <input type="password" name="confirmPassword" id="confirmPassword" class="form-control shadow-none" 
                                       placeholder="********" required>
                                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-danger w-100 fw-bold py-2 mt-2 shadow-sm">ĐĂNG KÝ NGAY</button>
                    </form>

                    <div class="text-center mt-4 small">
                        <span class="text-muted">Đã có tài khoản?</span> 
                        <a href="dang-nhap.jsp" class="text-danger fw-bold text-decoration-none">Đăng nhập</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="common/footer.jsp" />

    <%-- Script xử lý ẩn hiện mật khẩu --%>
    <script>
        function togglePassword(inputId, btn) {
            const passwordInput = document.getElementById(inputId);
            const icon = btn.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.replace('bi-eye', 'bi-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.replace('bi-eye-slash', 'bi-eye');
            }
        }
    </script>
</body>
</html>
