<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClickBuy - Hệ thống bán lẻ điện thoại toàn quốc</title>
    
    <jsp:include page="../common/header.jsp" />
    
    <style>
        .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            border-radius: 15px;
            overflow: hidden;
            background: #fff;
        }
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1) !important;
        }
        /* Sửa lỗi lệch chữ: Thêm hiển thị flex để thẻ <a> chiếm toàn bộ chiều rộng card */
        .product-link { 
            text-decoration: none; 
            color: inherit; 
            display: flex; 
            flex-direction: column; 
            flex-grow: 1; 
        }
        .btn-buy { background-color: #d70018; color: white; transition: 0.2s; border: none; }
        .btn-buy:hover { background-color: #b50014; color: white; }
        .pagination .page-link { color: #d70018; border-radius: 5px; margin: 0 3px; }
        .pagination .page-item.active .page-link { background-color: #d70018; border-color: #d70018; color: white; }
    </style>
</head>
<body style="background-color: #f8f9fa;">

    <jsp:include page="../common/navbar-user.jsp" />

    <main class="container my-5">
        <c:if test="${not empty welcomeMsg}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                ${welcomeMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold border-start border-4 border-danger ps-3 text-uppercase mb-0">
                Sản phẩm nổi bật
            </h3>
            <span class="text-muted small">
                Trang <strong>${not empty currentPage ? currentPage : 1}</strong> / ${not empty totalPages ? totalPages : 0}
            </span>
        </div>
        
        <div class="row">
            <c:forEach var="p" items="${latestProducts}">
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="card p-3 border-0 shadow-sm h-100 product-card d-flex flex-column">
                        <%-- Link chi tiết --%>
                        <a href="${pageContext.request.contextPath}/san-pham?action=chi-tiet&id=${p.idSanPham}" class="product-link">
                            
                            <div class="d-flex align-items-center justify-content-center mb-3" style="height: 160px; width: 100%;">
                                <img src="${pageContext.request.contextPath}/${not empty p.urlAnh ? p.urlAnh : 'assets/images/no-image.png'}" 
                                     class="img-fluid" 
                                     style="max-height: 100%; max-width: 100%; object-fit: contain;" 
                                     alt="${p.tenSanPham}">
                            </div>
                            
                            <div class="card-body p-0 d-flex flex-column text-center flex-grow-1">
                                <h6 class="card-title fw-bold text-dark mb-2" 
                                    style="height: 45px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                    ${p.tenSanPham}
                                </h6>
                                <p class="text-danger fw-bold fs-5 mb-0 mt-auto">
                                    <fmt:formatNumber value="${p.giaCoBan}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </p>
                            </div>

                        </a>
                        
                        <div class="d-grid gap-2 mt-3">
                 
                            <button type="button" class="btn btn-buy fw-bold py-2 shadow-sm rounded-3" 
                                    onclick="location.href='${pageContext.request.contextPath}/san-pham?action=chi-tiet&id=${p.idSanPham}'">
                                <i class="bi bi-cart-plus me-1"></i> MUA NGAY
                            </button>
                            
                            <button type="button" class="btn btn-outline-secondary fw-bold btn-sm rounded-3" 
                                    onclick="location.href='${pageContext.request.contextPath}/san-pham?action=chi-tiet&id=${p.idSanPham}'">
                                CHI TIẾT
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty latestProducts}">
                <div class="col-12 text-center py-5">
                    <i class="bi bi-box-seam display-1 text-muted"></i>
                    <h5 class="text-muted mt-3">Hiện tại chưa có sản phẩm nào.</h5>
                </div>
            </c:if>
        </div>

        <%-- PHÂN TRANG --%>
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/TrangChuServlet?page=${currentPage - 1}">
                            <i class="bi bi-chevron-left"></i> Trước
                        </a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <%-- Sửa link số trang --%>
                            <a class="page-link" href="${pageContext.request.contextPath}/TrangChuServlet?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/TrangChuServlet?page=${currentPage + 1}">
                            Sau <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </main>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>