<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
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
    <title>Đăng ký - ClickBuy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Arial, sans-serif;
            padding: 30px 0;
        }
        .register-box {
            background: #fff;
            border-radius: 16px;
            padding: 40px;
            width: 100%;
            max-width: 460px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
        }
        .logo {
            text-align: center;
            margin-bottom: 24px;
        }
        .logo h1 {
            font-size: 28px;
            font-weight: 900;
            color: #d70018;
            letter-spacing: 3px;
        }
        .logo p { color: #888; font-size: 13px; margin: 0; }
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
        .btn-register {
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
        .btn-register:hover {
            background: #b50014;
            transform: translateY(-1px);
        }
        .link-login { color: #d70018; font-weight: 600; text-decoration: none; }
        .link-login:hover { text-decoration: underline; }
        .alert { border-radius: 10px; font-size: 14px; }
        .pass-hint { font-size: 11px; color: #aaa; margin-top: 4px; }
    </style>
</head>
<body>
<div class="register-box">
    <div class="logo">
        <h1>CLICKBUY</h1>
        <p>Tạo tài khoản mới</p>
    </div>

    <%-- Hiển thị lỗi --%>
    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/AuthServlet" method="post"
          onsubmit="return validateForm()">
        <input type="hidden" name="action" value="register">

        <div class="mb-3">
            <label class="form-label">Họ và tên *</label>
            <input type="text" name="ten_day_du" class="form-control"
                   placeholder="Nguyễn Văn A" required
                   value="${param.ten_day_du}">
        </div>

        <div class="mb-3">
            <label class="form-label">Email *</label>
            <input type="email" name="email" class="form-control"
                   placeholder="email@gmail.com" required
                   value="${param.email}">
        </div>

        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <input type="tel" name="sdt" class="form-control"
                   placeholder="0901234567"
                   value="${param.sdt}">
        </div>

        <div class="mb-3">
            <label class="form-label">Mật khẩu *</label>
            <input type="password" name="mat_khau" id="matKhau"
                   class="form-control" placeholder="Ít nhất 6 ký tự" required minlength="6">
            <div class="pass-hint">Tối thiểu 6 ký tự</div>
        </div>

        <div class="mb-4">
            <label class="form-label">Xác nhận mật khẩu *</label>
            <input type="password" name="confirm_mat_khau" id="confirmMK"
                   class="form-control" placeholder="Nhập lại mật khẩu" required>
            <div id="matchMsg" class="pass-hint"></div>
        </div>

        <button type="submit" class="btn-register">Đăng ký</button>
    </form>

    <div class="text-center mt-3" style="font-size:14px; color:#555;">
        Đã có tài khoản?
        <a href="${pageContext.request.contextPath}/dang-nhap.jsp" class="link-login">
            Đăng nhập
        </a>
    </div>
</div>

<script>
    // Kiểm tra mật khẩu khớp realtime
    document.getElementById('confirmMK').addEventListener('input', function () {
        const mk  = document.getElementById('matKhau').value;
        const msg = document.getElementById('matchMsg');
        if (this.value === '') {
            msg.textContent = '';
        } else if (this.value === mk) {
            msg.textContent = '✅ Mật khẩu khớp';
            msg.style.color = 'green';
        } else {
            msg.textContent = '❌ Mật khẩu chưa khớp';
            msg.style.color = 'red';
        }
    });

    // Validate trước khi submit
    function validateForm() {
        const mk      = document.getElementById('matKhau').value;
        const confirm = document.getElementById('confirmMK').value;
        if (mk !== confirm) {
            alert('Mật khẩu xác nhận không khớp!');
            return false;
        }
        if (mk.length < 6) {
            alert('Mật khẩu phải có ít nhất 6 ký tự!');
            return false;
        }
        return true;
    }
</script>
</body>
</html>