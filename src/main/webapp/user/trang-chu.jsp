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
        }
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15) !important;
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
<body style="background-color: #f4f4f4;">

    <jsp:include page="../common/navbar-user.jsp" />

    <main class="container my-5">
        <h3 class="mb-4 fw-bold border-start border-4 border-danger ps-3 text-uppercase">
            Sản phẩm mới nhất
        </h3>
        
        <div class="row">
            
            <c:forEach var="p" items="${latestProducts}">
                <div class="col-md-4 mb-4">
                    <div class="card p-3 border-0 shadow-sm h-100 product-card">
                        <%-- Link đến trang chi tiết kèm theo ID sản phẩm --%>
                        <a href="chi-tiet-san-pham.jsp?id=${p.idSanPham}" class="product-link">
                            <img src="${pageContext.request.contextPath}/uploads/san-pham/${p.urlAnh}" 
                                 class="card-img-top img-fluid" style="max-height: 200px; object-fit: contain;" alt="${p.tenSanPham}">
                            <div class="card-body text-center d-flex flex-column">
                                <h5 class="card-title fw-bold">${p.tenSanPham}</h5>
                                <p class="text-danger fw-bold fs-5">
                                    <fmt:formatNumber value="${p.giaNiemYet}" type="number"/>đ
                                </p>
                            </div>
                        </a>
                        <div class="d-grid gap-2 mt-auto">
                            <%-- Nút Mua Ngay đẩy thẳng tới thanh toán với ID biến thể mặc định --%>
                            <button type="button" class="btn btn-buy fw-bold py-2 shadow-sm" 
                                    onclick="location.href='thanh-toan.jsp?id=${p.idSanPham}'">
                                MUA NGAY
                            </button>
                            <button type="button" class="btn btn-outline-dark fw-bold btn-sm" 
                                    onclick="location.href='chi-tiet-san-pham.jsp?id=${p.idSanPham}'">
                                XEM CHI TIẾT
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <%-- Nếu chưa có sản phẩm nào --%>
            <c:if test="${empty latestProducts}">
                <div class="col-12 text-center py-5">
                    <p class="text-muted italic">Đang cập nhật sản phẩm mới nhất</p>
                </div>
            </c:if>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>
