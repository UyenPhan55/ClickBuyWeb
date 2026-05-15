<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <%-- Thông báo từ Session (nếu có) --%>
    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4" role="alert" style="border-radius: 12px;">
            <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="msg" scope="session" />
    </c:if>

    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-uppercase">Tất cả điện thoại</h4>
                <%-- Logic chọn danh sách từ các Servlet khác nhau --%>
                <c:set var="finalList" value="${not empty listSP ? listSP : latestProducts}" />
                <span class="text-muted small">Tìm thấy <strong>${not empty finalList ? finalList.size() : 0}</strong> sản phẩm</span>
            </div>
            
            <div class="row">
                <c:choose>
                    <c:when test="${not empty finalList}">
                        <c:forEach var="p" items="${finalList}">
                            <div class="col-md-3 mb-4">
                                <div class="card p-3 border-0 shadow-sm h-100 text-center product-card" style="border-radius: 15px; transition: 0.3s;">
                                    
                                    <%-- Link vào trang chi tiết --%>
                                    <a href="${pageContext.request.contextPath}/san-pham?action=chi-tiet&id=${p.idSanPham}" class="text-decoration-none text-dark">
                                        <div class="mb-3 position-relative" style="height: 180px;">
                                            <img src="${pageContext.request.contextPath}/assets/images/${not empty p.urlAnh ? p.urlAnh : 'no-image.png'}" 
                                                 class="img-fluid h-100" style="object-fit: contain;" alt="${p.tenSanPham}">
                                        </div>
                                        <h6 class="fw-bold mb-1 text-truncate">${p.tenSanPham}</h6>
                                        <p class="text-muted small mb-1">${p.nhaSanXuat}</p>
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
                                                <%-- Nút thêm giỏ hàng: Đổi sang GioHangServlet để Filter bắt lỗi đăng nhập --%>
                                                <button class="btn btn-outline-danger btn-sm w-100 fw-bold py-2" style="border-radius: 8px;"
                                                        onclick="location.href='${pageContext.request.contextPath}/GioHangServlet?action=add&id=${p.idSanPham}'">
                                                    <i class="bi bi-cart-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <%-- Nút MUA NGAY: Đổi sang GioHangServlet (hoặc DonHangServlet nếu ông muốn) --%>
                                        <button class="btn btn-danger btn-sm fw-bold py-2" style="border-radius: 8px;"
                                                onclick="location.href='${pageContext.request.contextPath}/GioHangServlet?action=add&id=${p.idSanPham}&buy_now=true'">
                                            MUA NGAY
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5">
                            <i class="bi bi-box-seam fs-1 text-muted"></i>
                            <p class="mt-3 text-muted">Hiện chưa có sản phẩm nào để hiển thị.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<style>
    .product-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 24px rgba(0,0,0,0.12) !important;
    }
    .product-card img { transition: 0.3s; }
    .product-card:hover img { transform: scale(1.05); }
</style>

<jsp:include page="../common/footer.jsp" />
