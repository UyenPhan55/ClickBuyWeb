<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Chuyển URI sang Jakarta để chạy được logic session và giỏ hàng --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .navbar { padding: 10px 0 !important; }

    .navbar-brand {
        font-family: system-ui, -apple-system, sans-serif !important;
        font-size: 24px !important;
        font-weight: 900 !important;
        color: #d70018 !important;
        text-decoration: none !important;
        transition: 0.3s;
    }

    .nav-link {
        font-family: system-ui, -apple-system, sans-serif !important;
        font-size: 15px;
        color: #ffffff !important;
        transition: 0.2s;
    }

    .nav-link:hover { color: #d70018 !important; }

    .nav-link.active-custom {
        font-weight: 700 !important;
        border-bottom: 2px solid #d70018;
        padding-bottom: 5px;
    }

    .cart-badge, .noti-badge {
        font-family: Arial, sans-serif !important;
        font-size: 10px !important;
        padding: 2px 5px !important;
        top: 5px !important;
        left: 75% !important;
        border: 1.5px solid #212529;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
    <div class="container">
        
        <a class="navbar-brand" href="${pageContext.request.contextPath}/user/trang-chu.jsp">
            CLICKBUY
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/danh-sach-san-pham.jsp">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/tra-cuu-bao-hanh.jsp">Bảo hành</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/gui-khieu-nai.jsp">Khiếu nại</a>
                </li>
            </ul>
       
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-2">
                    <a class="nav-link position-relative d-inline-block p-2" href="${pageContext.request.contextPath}/user/danh-sach-thong-bao.jsp">
                        <span style="font-size: 20px;">🔔</span>
                        <c:if test="${not empty totalNoti && totalNoti > 0}">
                            <span class="position-absolute translate-middle badge rounded-pill bg-danger noti-badge">
                                ${totalNoti}
                            </span>
                        </c:if>
                    </a>
                </li>

                <li class="nav-item me-3">
                    <a class="nav-link position-relative d-inline-block p-2" href="${pageContext.request.contextPath}/user/gio-hang.jsp">
                        <span style="font-size: 20px;">🛒</span>
                        <c:if test="${not empty cartCount && cartCount > 0}">
                            <span class="position-absolute translate-middle badge rounded-pill bg-danger cart-badge">
                                ${cartCount}
                            </span>
                        </c:if>
                    </a>
                </li>

                <%-- Dùng Jakarta để kiểm tra thông tin user trong session --%>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item me-2">
                            <a class="nav-link text-warning" href="${pageContext.request.contextPath}/user/lich-su-don-hang.jsp">
                                👤 ${sessionScope.user.TenDayDu} 
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/AuthServlet?action=logout">Đăng xuất</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-outline-danger btn-sm fw-bold px-3" href="${pageContext.request.contextPath}/dang-nhap.jsp">
                                Đăng nhập
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<script>
    (function() {
        function updateActive() {
            var path = window.location.pathname;
            var currentPage = path.split("/").pop();
            if (currentPage === "" || path.endsWith("/user/")) {
                currentPage = "trang-chu.jsp";
            }
            var links = document.querySelectorAll('.nav-link, .navbar-brand');
            links.forEach(function(item) {
                var href = item.getAttribute('href');
                if (href) {
                    var linkPage = href.split("/").pop();
                    if (currentPage === linkPage) {
                        item.classList.add('active-custom');
                    }
                }
            });
        }
        window.addEventListener('load', updateActive);
    })();
</script>
