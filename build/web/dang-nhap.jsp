<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - ClickBuy</title>
    
    <jsp:include page="common/header.jsp" />
    
    <style>
        body { background: #f5f5f5; }
        .login-card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
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
            color: #666;
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
            <div class="col-md-4">
                
                <div class="mb-3">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="back-to-home">
                        <i class="bi bi-arrow-left"></i> Quay về trang chủ
                    </a>
                </div>

                <div class="card login-card p-4">
                    <h3 class="text-center fw-bold text-danger mb-4">CLICKBUY LOGIN</h3>

                    <%-- Thông báo lỗi từ AuthServlet (Sai mật khẩu, tài khoản bị khóa...) --%>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger text-center py-2 small mb-3">
                            <i class="bi bi-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>

                    <%-- Thông báo thành công (Dùng sau khi đăng ký xong rồi nhảy sang đây) --%>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success text-center py-2 small mb-3">
                            ${message}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/AuthServlet" method="post">
                      
                        <input type="hidden" name="action" value="login">
                        
                        <div class="mb-3">
                            <label class="fw-bold mb-1 small">Email hoặc Số điện thoại</label>
                          
                            <input type="text" name="user_input" class="form-control" placeholder="Nhập email hoặc SĐT" required>
                        </div>

                        <div class="mb-3">
                            <label class="fw-bold mb-1 small">Mật khẩu</label>
                           
                            <input type="password" name="mat_khau" class="form-control" placeholder="********" required>
                        </div>

                        <%-- Checkbox ghi nhớ đăng nhập (Tùy chọn thêm cho xịn) --%>
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