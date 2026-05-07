<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/trang-chu.jsp" class="text-decoration-none text-danger">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="#" class="text-decoration-none text-danger">${product.ten_danh_muc}</a></li>
            <li class="breadcrumb-item active">${product.ten_san_pham}</li>
        </ol>
    </nav>

    <div class="row mb-5">
        <div class="col-md-6 text-center">
            <div class="card border-0 shadow-sm p-4 sticky-top" style="top: 100px; z-index: 10;">
                <img src="${pageContext.request.contextPath}/uploads/san-pham/${product.url_anh}" 
                     class="img-fluid" style="max-height: 450px; object-fit: contain;" alt="${product.ten_san_pham}">
            </div>
        </div>

        <div class="col-md-6">
            <h2 class="fw-bold mb-1">${product.ten_san_pham}</h2>
            
            <div class="d-flex align-items-center gap-2 mb-3">
                <span class="text-muted small">Thương hiệu: <strong class="text-dark">${product.ten_thuong_hieu}</strong></span>
                <span class="text-muted">|</span>
                <%-- Trạng thái từ bảng san_pham --%>
                <c:choose>
                    <c:when test="${product.trang_thai == 1}">
                        <span class="badge bg-success-subtle text-success border border-success-subtle fw-bold">
                            <i class="bi bi-check-circle-fill me-1"></i>Đang bán
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle fw-bold">
                            <i class="bi bi-x-circle-fill me-1"></i>Ngừng kinh doanh
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>

            <p class="text-muted small mb-3">Mã sản phẩm: ${product.ma_san_pham}</p>
            
            <div class="d-flex align-items-center mb-3">
                <span class="text-warning me-2 small">
                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                </span>
                <span class="text-primary small">(${product.luot_danh_gia} đánh giá) | Đã bán ${product.so_luong_da_ban}+</span>
            </div>

            <h3 class="text-danger fw-bold mb-4" id="display-price">
                <fmt:formatNumber value="${variants[0].gia_ban}" type="currency" currencySymbol="đ" />
            </h3>
            
            <form action="${pageContext.request.contextPath}/CartServlet" method="post" id="purchase-form">
                <input type="hidden" name="action" value="add-to-cart">
                <input type="hidden" name="id_bien_the" id="selected-variant-id" value="${variants[0].id_bien_the}">

                <div class="mb-4">
                    <label class="fw-bold mb-2">Chọn phiên bản:</label>
                    <div class="d-flex gap-2 mb-2">
                        <c:forEach var="v" items="${variants}" varStatus="loop">
                            <input type="radio" class="btn-check" name="variant_radio" id="v${v.id_bien_the}" 
                                   ${loop.first ? 'checked' : ''}
                                   onclick="updateInfo('${v.id_bien_the}', '${v.gia_ban}', '${v.so_luong_ton}')">
                            <label class="btn btn-outline-danger px-4 fw-bold" for="v${v.id_bien_the}">${v.ten_bien_the}</label>
                        </c:forEach>
                    </div>
                    <p class="text-muted small">
                        <i class="bi bi-box-seam me-1"></i>Số lượng tồn: 
                        <strong id="display-stock" class="text-dark">${variants[0].so_luong_ton}</strong>
                    </p>
                </div>

                <div class="mb-4">
                    <label class="fw-bold mb-2">Số lượng:</label>
                    <div class="input-group shadow-sm" style="width: 130px;">
                        <button class="btn btn-outline-secondary" type="button" onclick="changeQty(-1)">-</button>
                        <input type="number" name="so_luong" id="buy-quantity" class="form-control text-center shadow-none border-secondary" value="1" min="1" max="${variants[0].so_luong_ton}">
                        <button class="btn btn-outline-secondary" type="button" onclick="changeQty(1)">+</button>
                    </div>
                </div>

                <div class="d-flex gap-3 mt-4">
                    <button type="submit" name="buy_now" value="true" class="btn btn-danger fw-bold px-4 py-2 shadow-sm" 
                            style="min-width: 180px; border-radius: 8px;" 
                            ${product.trang_thai == 0 ? 'disabled' : ''}>
                        MUA NGAY
                    </button>
    
                    <button type="submit" class="btn btn-outline-danger fw-bold px-3 py-2 shadow-sm" 
                            style="border-radius: 8px;"
                            ${product.trang_thai == 0 ? 'disabled' : ''}>
                        <i class="bi bi-cart-plus fs-5"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="row pt-5 border-top">
        <div class="col-12">
            <div class="card border-0 shadow-sm p-4 mb-4">
                <h5 class="fw-bold border-bottom pb-3 mb-3 text-uppercase">Mô tả sản phẩm</h5>
                <div class="content-detail" style="line-height: 1.8;">
                    ${product.mo_ta}
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    function updateInfo(id, price, stock) {
        document.getElementById('selected-variant-id').value = id;
        
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
        });
        
        document.getElementById('display-price').innerText = formatter.format(price).replace(/\u20AB/g, 'đ');
        document.getElementById('display-stock').innerText = stock;
        
        const qtyInput = document.getElementById('buy-quantity');
        qtyInput.max = stock;
        if (parseInt(qtyInput.value) > parseInt(stock)) {
            qtyInput.value = stock;
        }
    }

    function changeQty(val) {
        const input = document.getElementById('buy-quantity');
        let current = parseInt(input.value);
        let max = parseInt(input.max);
        if (val === 1 && current < max) input.value = current + 1;
        if (val === -1 && current > 1) input.value = current - 1;
    }
</script>

<jsp:include page="../common/footer.jsp" />