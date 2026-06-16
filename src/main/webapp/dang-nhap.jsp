<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - ClickBuy</title>
    
    <jsp:include page="common/header.jsp" />
    
    <style>
        body { background: #f8f9fa; }
        .login-card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            background: #ffffff;
        }
        .btn-login {
            background: #d70018;
            color: white;
            font-weight: bold;
            transition: 0.3s;
            border: none;
        }
        .btn-login:hover { background: #b80014; color: white; transform: translateY(-2px); }
        .back-to-home {
            text-decoration: none;
            color: #6c757d;
            font-size: 14px;
            transition: 0.3s;
        }
        .back-to-home:hover { color: #d70018; }
        .form-control:focus { border-color: #d70018; box-shadow: 0 0 0 0.25rem rgba(215, 0, 24, 0.1); }
    </style>
</head>
<body>
    
    <jsp:include page="common/navbar-user.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-4 col-sm-8">
                
                <div class="mb-3">
                    <a href="${pageContext.request.contextPath}/TrangChuServlet" class="back-to-home">
                        <i class="bi bi-arrow-left"></i> Quay về trang chủ
                    </a>
                </div>

                <div class="card login-card p-4">
                    <div class="text-center mb-4">
                        <h3 class="fw-bold text-danger mb-1">CLICKBUY LOGIN</h3>
                        <p class="text-muted small">Vui lòng đăng nhập để tiếp tục mua sắm</p>
                    </div>

                    <%-- Thông báo lỗi từ AuthServlet --%>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger text-center py-2 small mb-3 border-0">
                            <i class="bi bi-exclamation-circle-fill me-1"></i> ${error}
                        </div>
                    </c:if>

                    <%-- Thông báo thành công --%>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success text-center py-2 small mb-3 border-0">
                            <i class="bi bi-check-circle-fill me-1"></i> ${message}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/AuthServlet" method="post">
                        <%-- Định danh hành động cho Servlet --%>
                        <input type="hidden" name="action" value="login">
                        
                        <div class="mb-3">
                            <label class="fw-bold mb-1 small">Email hoặc Số điện thoại</label>
                            <%-- value="${param.user_input}" giúp giữ lại tên đăng nhập khi gõ sai mật khẩu --%>
                            <input type="text" name="user_input" class="form-control shadow-none" 
                                   placeholder="Nhập email hoặc SĐT" value="${param.user_input}" required>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label class="fw-bold small mb-0">Mật khẩu</label>
                                <a href="quen-mat-khau.jsp" class="text-danger text-decoration-none" style="font-size: 12px;">Quên mật khẩu?</a>
                            </div>
                            <input type="password" name="mat_khau" class="form-control shadow-none" placeholder="********" required>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="remember">
                            <label class="form-check-label small text-muted" for="rememberMe">Ghi nhớ đăng nhập</label>
                        </div>

                        <button type="submit" class="btn btn-login w-100 py-2 mt-2 shadow-sm">ĐĂNG NHẬP</button>
                    </form>

                    <div class="text-center mt-4 small">
                        <span class="text-muted">Chưa có tài khoản?</span> 
                        <a href="dang-ky.jsp" class="text-danger fw-bold text-decoration-none">Đăng ký ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="common/footer.jsp" />

</body>
</html>
