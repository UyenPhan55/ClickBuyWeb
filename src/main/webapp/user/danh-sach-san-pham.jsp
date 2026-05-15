<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-uppercase">Tất cả điện thoại</h4>
                <c:set var="finalList" value="${not empty listSP ? listSP : latestProducts}" />
                <span class="text-muted small">Tìm thấy <strong>${not empty finalList ? finalList.size() : 0}</strong> sản phẩm</span>
            </div>
            
            <div class="row">
                <c:choose>
                    <c:when test="${not empty finalList}">
                        <c:forEach var="p" items="${finalList}">
                            <div class="col-md-3 mb-4">
                                <div class="card p-3 border-0 shadow-sm h-100 text-center product-card" style="border-radius: 15px;">
                                    <a href="${pageContext.request.contextPath}/san-pham?action=chi-tiet&id=${p.idSanPham}" class="text-decoration-none text-dark">
                                        <div class="mb-3 position-relative" style="height: 180px;">
                                            <img src="${pageContext.request.contextPath}/assets/images/${not empty p.urlAnh ? p.urlAnh : 'no-image.png'}" 
                                                 class="img-fluid h-100" style="object-fit: contain;" alt="${p.tenSanPham}">
                                        </div>
                                        <h6 class="fw-bold mb-1 text-truncate">${p.tenSanPham}</h6>
                                        <p class="text-danger fw-bold mb-3">
                                            <fmt:formatNumber value="${p.giaCoBan}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </p>
                                    </a>
                                    
                                    <div class="d-grid gap-2 mt-auto">
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <button class="btn btn-outline-dark btn-sm w-100 fw-bold py-2" style="border-radius: 8px;"
                                                        onclick="location.href='${pageContext.request.contextPath}/san-pham?action=chi-tiet&id=${p.idSanPham}'">
                                                    CHI TIẾT
                                                </button>
                                            </div>
                                            <div class="col-6">
                                                <%-- NÚT THÊM GIỎ HÀNG QUAN TRỌNG --%>
                                                <button class="btn btn-outline-danger btn-sm w-100 fw-bold py-2" style="border-radius: 8px;"
                                                        onclick="addCartAjax('${p.idSanPham}')">
                                                    <i class="bi bi-cart-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<%-- TOAST THÔNG BÁO --%>
<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1100">
    <div id="cartToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <i class="bi bi-check-circle-fill me-2"></i> Đã thêm vào giỏ hàng thành công!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<%-- IFRAME ẨN: Chỗ này tui đã sửa src mặc định để tránh lỗi 404 khi vừa load trang --%>
<iframe name="hidden_iframe" id="hidden_iframe" style="display:none;" src="about:blank" onload="handleIframeLoad()"></iframe>

<script>
    let isAdding = false;

    function addCartAjax(id) {
        <%-- 1. Kiểm tra đăng nhập --%>
        <c:if test="${empty sessionScope.user}">
            window.location.href = '${pageContext.request.contextPath}/dang-nhap.jsp';
            return;
        </c:if>

        isAdding = true;
        
        <%-- 2. Sửa link cực kỳ quan trọng: Phải là GioHangServlet (viết hoa chuẩn) --%>
        <%-- Tui thêm action=add và idBienThe khớp với Servlet của ông --%>
        const url = '${pageContext.request.contextPath}/GioHangServlet?action=add&idBienThe=' + id + '&soLuong=1'; 
        
        document.getElementById('hidden_iframe').src = url;
    }

    function handleIframeLoad() {
        const iframe = document.getElementById('hidden_iframe');
        // Tránh chạy lúc vừa load trang (khi src là about:blank)
        if (isAdding && iframe.src !== "about:blank") {
            
            // A. Hiện Toast thành công
            var toastEl = document.getElementById('cartToast');
            var toast = new bootstrap.Toast(toastEl);
            toast.show();

            // B. Cập nhật số lượng trên Menu (id cart-badge trong navbar-user.jsp)
            const badge = document.getElementById('cart-badge');
            if (badge) {
                let currentCount = parseInt(badge.innerText.trim()) || 0;
                badge.innerText = currentCount + 1;
            }

            isAdding = false;
        }
    }
</script>

<jsp:include page="../common/footer.jsp" />
