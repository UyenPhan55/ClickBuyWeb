<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Nếu đã đăng nhập rồi thì không vào trang này nữa
    if (session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/TrangChuServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - ClickBuy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .login-box {
            background: #fff;
            border-radius: 16px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
        }
        .logo {
            text-align: center;
            margin-bottom: 28px;
        }
        .logo h1 {
            font-size: 32px;
            font-weight: 900;
            color: #d70018;
            letter-spacing: 3px;
        }
        .logo p {
            color: #888;
            font-size: 13px;
            margin: 0;
        }
        .form-label { font-weight: 600; font-size: 13px; color: #444; }
        .form-control {
            border-radius: 10px;
            padding: 11px 14px;
            font-size: 14px;
            border: 1.5px solid #e0e0e0;
        }
        .form-control:focus {
            border-color: #d70018;
            box-shadow: 0 0 0 3px rgba(215,0,24,0.1);
        }
        .btn-login {
            background: #d70018;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 700;
            font-size: 15px;
            width: 100%;
            transition: 0.2s;
        }
        .btn-login:hover {
            background: #b50014;
            transform: translateY(-1px);
        }
        .divider {
            text-align: center;
            color: #aaa;
            font-size: 13px;
            margin: 16px 0;
            position: relative;
        }
        .divider::before, .divider::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 40%;
            height: 1px;
            background: #e0e0e0;
        }
        .divider::before { left: 0; }
        .divider::after  { right: 0; }
        .link-register {
            color: #d70018;
            font-weight: 600;
            text-decoration: none;
        }
        .link-register:hover { text-decoration: underline; }
        .alert { border-radius: 10px; font-size: 14px; }
        .password-toggle {
            position: relative;
        }
        .password-toggle .toggle-btn {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #888;
            background: none;
            border: none;
            font-size: 16px;
        }
    </style>
</head>
<body>
<div class="login-box">
    <div class="logo">
        <h1>CLICKBUY</h1>
        <p>Điện thoại chính hãng, giá tốt nhất</p>
    </div>

    <%-- Hiển thị thông báo sau khi đăng ký thành công --%>
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success">
            ${sessionScope.successMessage}
            <% session.removeAttribute("successMessage"); %>
        </div>
    </c:if>

    <%-- Hiển thị lỗi --%>
    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
    </c:if>

    <c:if test="${param.error == 'access-denied'}">
        <div class="alert alert-warning">Bạn không có quyền truy cập trang đó!</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/AuthServlet" method="post">
        <input type="hidden" name="action" value="login">

        <div class="mb-3">
            <label class="form-label">Email hoặc Số điện thoại</label>
            <input type="text" name="user_input" class="form-control"
                   placeholder="Nhập email hoặc SĐT" required autofocus>
        </div>

        <div class="mb-4">
            <label class="form-label">Mật khẩu</label>
            <div class="password-toggle">
                <input type="password" name="mat_khau" id="matKhau"
                       class="form-control" placeholder="Nhập mật khẩu" required>
                <button type="button" class="toggle-btn" onclick="togglePass()">👁</button>
            </div>
        </div>

        <button type="submit" class="btn-login">Đăng nhập</button>
    </form>

    <div class="divider">hoặc</div>

    <div class="text-center" style="font-size:14px; color:#555;">
        Chưa có tài khoản?
        <a href="${pageContext.request.contextPath}/dang-ky.jsp" class="link-register">
            Đăng ký ngay
        </a>
    </div>
</div>

<script>
    function togglePass() {
        const input = document.getElementById('matKhau');
        input.type = input.type === 'password' ? 'text' : 'password';
    }
</script>
</body>
</html>