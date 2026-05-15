<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Dùng đường dẫn / để đảm bảo load đúng resource --%>
<jsp:include page="/common/header.jsp" />
<jsp:include page="/common/navbar-user.jsp" />

<main class="container my-5">
    <%-- Điều hướng (Breadcrumb) --%>
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/TrangChuServlet" class="text-decoration-none text-danger">Trang chủ</a></li>
            <li class="breadcrumb-item active">${detail.tenSanPham}</li>
        </ol>
    </nav>

    <div class="row mb-5">
        <%-- Ảnh sản phẩm --%>
        <div class="col-md-6 text-center">
            <div class="card border-0 shadow-sm p-4 sticky-top" style="top: 100px; z-index: 10; border-radius: 20px;">
                <img src="${pageContext.request.contextPath}/assets/images/${detail.urlAnh}" 
                     class="img-fluid" style="max-height: 450px; object-fit: contain;" alt="${detail.tenSanPham}">
            </div>
        </div>

        <%-- Thông tin sản phẩm --%>
        <div class="col-md-6">
            <h2 class="fw-bold mb-1">${detail.tenSanPham}</h2>
            
            <div class="d-flex align-items-center gap-2 mb-3">
                <span class="text-muted small">NSX: <strong class="text-dark">${detail.nhaSanXuat}</strong></span>
                <span class="text-muted">|</span>
                
                <%-- HIỂN THỊ SỐ LƯỢNG TỒN (Lấy từ soLuongTon bà mới thêm) --%>
                <c:choose>
                    <c:when test="${detail.soLuongTon > 0}">
                        <span class="text-muted small">Kho còn: <strong class="text-success">${detail.soLuongTon}</strong> sản phẩm</span>
                    </c:when>
                    <c:otherwise>
                        <span class="text-danger small fw-bold">Hiện đã hết hàng</span>
                    </c:otherwise>
                </c:choose>
                <span class="text-muted">|</span>

                <%-- Trạng thái từ DAO --%>
                <c:choose>
                    <c:when test="${detail.trangThai == 1}">
                        <span class="badge bg-success-subtle text-success border border-success-subtle fw-bold">Đang kinh doanh</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle fw-bold">Ngừng kinh doanh</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <p class="text-muted small mb-3">Mã SP: SP00${detail.idSanPham}</p>
            
            <div class="d-flex align-items-center mb-3">
                <span class="text-warning me-2 small">
                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                </span>
                <span class="text-primary small">(4.5 đánh giá) | Đã bán 100+</span>
            </div>

            <%-- Giá bán --%>
            <h3 class="text-danger fw-bold mb-4">
                <fmt:formatNumber value="${detail.giaCoBan}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
            </h3>
            
            <form action="${pageContext.request.contextPath}/gio-hang" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="id" value="${detail.idSanPham}">

                <div class="mb-4">
                    <label class="fw-bold mb-2">Số lượng mua:</label>
                    <div class="input-group shadow-sm" style="width: 130px;">
                        <button class="btn btn-outline-secondary" type="button" onclick="changeQty(-1)">-</button>
                        <%-- max được giới hạn bởi soLuongTon để khách không mua lố --%>
                        <input type="number" name="so_luong" id="buy-quantity" 
                               class="form-control text-center shadow-none border-secondary" 
                               value="1" min="1" max="${detail.soLuongTon}">
                        <button class="btn btn-outline-secondary" type="button" onclick="changeQty(1)">+</button>
                    </div>
                </div>

                <div class="d-flex gap-3 mt-4">
                    <%-- Nếu hết hàng (soLuongTon <= 0) thì disable nút bấm --%>
                    <button type="submit" name="buy_now" value="true" 
                            class="btn btn-danger fw-bold px-4 py-3 shadow-sm" 
                            style="min-width: 200px; border-radius: 12px;"
                            ${detail.soLuongTon <= 0 ? 'disabled' : ''}>
                        ${detail.soLuongTon <= 0 ? 'HẾT HÀNG' : 'MUA NGAY'}
                    </button>
                    
                    <button type="submit" class="btn btn-outline-danger fw-bold px-4 py-3 shadow-sm" 
                            style="border-radius: 12px;"
                            ${detail.soLuongTon <= 0 ? 'disabled' : ''}>
                        <i class="bi bi-cart-plus fs-4"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <%-- Mô tả chi tiết --%>
    <div class="row pt-5 border-top">
        <div class="col-12">
            <div class="card border-0 shadow-sm p-4 mb-4" style="border-radius: 15px;">
                <h5 class="fw-bold border-bottom pb-3 mb-3 text-uppercase text-danger">Thông tin chi tiết</h5>
                <div class="content-detail" style="line-height: 1.8;">
                    ${detail.moTa != null ? detail.moTa : "Đang cập nhật nội dung..."}
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/common/footer.jsp" />

<script>
    function changeQty(val) {
        const input = document.getElementById('buy-quantity');
        const maxAvailable = parseInt(input.getAttribute('max')) || 1;
        let current = parseInt(input.value);
        
        if (val === 1 && current < maxAvailable) {
            input.value = current + 1;
        } else if (val === -1 && current > 1) {
            input.value = current - 1;
        }
    }
</script>
