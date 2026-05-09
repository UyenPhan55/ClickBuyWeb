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
        .product-link {
            text-decoration: none;
            color: inherit;
        }
        .btn-buy {
            background-color: #d70018;
            color: white;
            transition: 0.2s;
        }
        .btn-buy:hover {
            background-color: #b50014;
            color: white;
        }
        .nav-link {
            transition: all 0.3s ease;
            color: rgba(255,255,255,0.8) !important;
        }
        .nav-link.active-custom {
            font-weight: 800 !important;
            font-size: 1.15rem !important;
            color: #ffc107 !important;
            text-shadow: 0px 0px 12px rgba(255, 193, 7, 0.8) !important;
            transform: scale(1.1);
            border-bottom: 2px solid #ffc107;
        }
    </style>
</head>
<body style="background-color: #f8f9fa;">

    <jsp:include page="../common/navbar-user.jsp" />

    <main class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold border-start border-4 border-danger ps-3 text-uppercase mb-0">
                Sản phẩm mới nhất
            </h3>
            <a href="${pageContext.request.contextPath}/tat-ca-san-pham" class="text-danger text-decoration-none fw-bold small">
                Xem tất cả <i class="bi bi-chevron-right"></i>
            </a>
        </div>
        
        <div class="row">
            <c:forEach var="p" items="${latestProducts}">
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="card p-3 border-0 shadow-sm h-100 product-card">
                        <%-- Link đến trang chi tiết --%>
                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.idSanPham}" class="product-link">
                            <img src="${pageContext.request.contextPath}/uploads/san-pham/${p.urlAnh}" 
                                 class="card-img-top img-fluid mb-3" 
                                 style="height: 180px; object-fit: contain;" 
                                 alt="${p.tenSanPham}">
                            
                            <div class="card-body p-0 d-flex flex-column text-center">
                                <h6 class="card-title fw-bold text-dark mb-2" style="height: 40px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                    ${p.tenSanPham}
                                </h6>
                                <p class="text-danger fw-bold fs-5">
                                    <fmt:formatNumber value="${p.giaNiemYet}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </p>
                            </div>
                        </a>
                        
                        <div class="d-grid gap-2 mt-3">
                            <button type="button" class="btn btn-buy fw-bold py-2 shadow-sm rounded-3" 
                                    onclick="location.href='${pageContext.request.contextPath}/thanh-toan?id=${p.idSanPham}'">
                                <i class="bi bi-cart-plus me-1"></i> MUA NGAY
                            </button>
                            <button type="button" class="btn btn-outline-secondary fw-bold btn-sm rounded-3" 
                                    onclick="location.href='${pageContext.request.contextPath}/product-detail?id=${p.idSanPham}'">
                                CHI TIẾT
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty latestProducts}">
                <div class="col-12 text-center py-5">
                    <i class="bi bi-box-seam fs-1 text-muted d-block mb-3"></i>
                    <p class="text-muted fst-italic">Đang cập nhật những sản phẩm mới nhất...</p>
                </div>
            </c:if>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>