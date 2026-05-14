<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .navbar { padding: 10px 0 !important; }
    .navbar-brand {
        font-size: 24px !important;
        font-weight: 900 !important;
        color: #d70018 !important;
        text-decoration: none !important;
    }
    .nav-link {
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
        font-size: 10px !important;
        padding: 2px 5px !important;
        top: 5px !important;
        left: 75% !important;
        border: 1.5px solid #212529;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
    <div class="container">

        <%--  Sửa: TrangChuServlet --%>
        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/TrangChuServlet">
            CLICKBUY
        </a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <%--  Sửa: SanPhamServlet --%>
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/SanPhamServlet">
                        Sản phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <%-- Sửa: BaoHanhServlet --%>
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/BaoHanhServlet">
                        Bảo hành
                    </a>
                </li>
                <li class="nav-item">
                    <%--  Sửa: KhieuNaiServlet --%>
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/KhieuNaiServlet">
                        Khiếu nại
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-2">
                    <%--  Sửa: ThongBaoServlet --%>
                    <a class="nav-link position-relative d-inline-block p-2"
                       href="${pageContext.request.contextPath}/ThongBaoServlet">
                        <span style="font-size:20px;">🔔</span>
                        <c:if test="${not empty totalNoti && totalNoti > 0}">
                            <span class="position-absolute translate-middle
                                         badge rounded-pill bg-danger noti-badge">
                                ${totalNoti}
                            </span>
                        </c:if>
                    </a>
                </li>

                <li class="nav-item me-3">
                    <%-- ✅ Sửa: GioHangServlet --%>
                    <a class="nav-link position-relative d-inline-block p-2"
                       href="${pageContext.request.contextPath}/GioHangServlet">
                        <span style="font-size:20px;">🛒</span>
                        <c:if test="${not empty cartCount && cartCount > 0}">
                            <span class="position-absolute translate-middle
                                         badge rounded-pill bg-danger cart-badge">
                                ${cartCount}
                            </span>
                        </c:if>
                    </a>
                </li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-warning fw-bold"
                               href="#" data-bs-toggle="dropdown">
                                👤 ${sessionScope.user.tenDayDu}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0"
                                style="border-radius:12px;">
                                <li>
                                    <%-- ✅ Sửa: DonHangServlet --%>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/DonHangServlet?action=history">
                                        🛍️ Đơn hàng của tôi
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/BaoHanhServlet">
                                        🛡️ Tra cứu bảo hành
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/KhieuNaiServlet">
                                        📩 Gửi khiếu nại
                                    </a>
                                </li>
                                <c:if test="${sessionScope.user.idVaiTro == 1 ||
                                             sessionScope.user.idVaiTro == 2}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item text-primary fw-bold"
                                           href="${pageContext.request.contextPath}/StaffServlet">
                                            ⚙️ Trang quản lý
                                        </a>
                                    </li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger"
                                       href="${pageContext.request.contextPath}/AuthServlet?action=logout">
                                        🚪 Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-outline-danger btn-sm fw-bold px-3"
                               href="${pageContext.request.contextPath}/dang-nhap.jsp">
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
    (function () {
        function updateActive() {
            var path = window.location.pathname;
            document.querySelectorAll('.nav-link').forEach(function (link) {
                var href = link.getAttribute('href');
                if (href && path.indexOf(href.split('?')[0]) !== -1
                    && href !== '#' && href.length > 1) {
                    link.classList.add('active-custom');
                }
            });
        }
        window.addEventListener('load', updateActive);
    })();
</script>