<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
        font-weight: 400 !important;
    }
    .nav-link:hover { color: #d70018 !important; }
    .nav-link.active-custom {
        border-bottom: 2px solid #d70018 !important;
        padding-bottom: 5px;
        color: #ffffff !important;
    }
    /* Chỉnh sửa badge cho đẹp và chuẩn vị trí */
    .cart-badge, .noti-badge {
        font-family: Arial, sans-serif !important;
        font-size: 11px !important;
        font-weight: bold !important;
        padding: 2px 6px !important;
        top: 0 !important;
        left: 80% !important;
        border: 2px solid #212529;
        border-radius: 50rem !important;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
    <div class="container">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/TrangChuServlet">
            CLICKBUY
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/san-pham?action=danh-sach">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/BaoHanhServlet?action=mine">Bảo hành</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/khieu-nai?action=mine">Khiếu nại</a>
                </li>
            </ul>
       
            <ul class="navbar-nav ms-auto align-items-center">
                <%-- THÔNG BÁO --%>
                <li class="nav-item me-2">
                    <a class="nav-link position-relative d-inline-block p-2" 
                       href="${pageContext.request.contextPath}/ThongBaoServlet?action=list">
                        <i class="bi bi-bell fs-5"></i>
                        <c:if test="${not empty totalNoti && totalNoti > 0}">
                            <span class="position-absolute translate-middle badge bg-danger noti-badge">
                                ${totalNoti}
                            </span>
                        </c:if>
                    </a>
                </li>

                <%-- GIỎ HÀNG: Luôn giữ lại tag HTML để JavaScript có thể tìm thấy và update số lượng --%>
                <li class="nav-item me-3">
                    <a class="nav-link position-relative d-inline-block p-2" 
                       href="${pageContext.request.contextPath}/GioHangServlet?action=view">
                        <i class="bi bi-cart3 fs-5"></i>
                        
                        <span id="cart-badge" 
                              class="position-absolute translate-middle badge bg-danger cart-badge ${empty soLuongGio || soLuongGio == 0 ? 'd-none' : ''}">
                            ${not empty soLuongGio ? soLuongGio : 0}
                        </span>
                    </a>
                </li>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">

                        <%-- ✅ Đã sửa lỗi xuống dòng gây lỗi 404 link Admin --%>
                        <c:if test="${sessionScope.user.idVaiTro == 1}">
                            <li class="nav-item me-2">
                                <a class="btn btn-sm btn-outline-warning fw-bold" href="${pageContext.request.contextPath}/AdminServlet?action=dashboard">
                                    ⚙️ Admin
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.idVaiTro == 2}">
                            <li class="nav-item me-2">
                                <a class="btn btn-sm btn-outline-info fw-bold" href="${pageContext.request.contextPath}/StaffServlet?action=dashboard">
                                    🛠️ Staff
                                </a>
                            </li>
                        </c:if>
             
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-outline-danger btn-sm fw-bold px-3" href="${pageContext.request.contextPath}/dang-nhap.jsp">
                                Đăng nhập
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item me-2">
                            <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/DonHangServlet?action=history">
                                <i class="bi bi-person-circle me-1"></i> 
                                ${sessionScope.user.tenDayDu} 
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm rounded-pill px-3" href="${pageContext.request.contextPath}/AuthServlet?action=logout">
                                Đăng xuất
                            </a>
                        </li>
                    </c:when>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<script>
    (function() {
        function updateActive() {
            var path = window.location.pathname;
            var search = window.location.search;
            var links = document.querySelectorAll('.nav-link');
            
            links.forEach(function(item) {
                var href = item.getAttribute('href');
                if (href) {
                    if (path.includes("san-pham") && search.includes("action=danh-sach") && href.includes("action=danh-sach")) {
                        item.classList.add('active-custom');
                    } else if (path.includes("khieu-nai") && href.includes("khieu-nai")) { 
                        // Đã sửa từ KhieuNaiServlet thành khieu-nai khớp với href
                        item.classList.add('active-custom');
                    } else if (path.includes("BaoHanhServlet") && href.includes("BaoHanhServlet")) {
                        item.classList.add('active-custom');
                    } else {
                        item.classList.remove('active-custom');
                    }
                }
            });
        }
        window.addEventListener('load', updateActive);
    })();
</script>