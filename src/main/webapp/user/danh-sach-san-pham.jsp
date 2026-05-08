<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang hệ Jakarta --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="row">
        <%-- Cột bên trái: Bộ lọc --%>
        <div class="col-md-3">
            <div class="card p-3 mb-4 border-0 shadow-sm">
                <h5 class="fw-bold mb-3"><i class="bi bi-filter-left me-2"></i>Bộ lọc sản phẩm</h5>
                
                <form action="${pageContext.request.contextPath}/ProductListServlet" method="get">
                    <p class="fw-bold small mb-2 text-uppercase text-muted">Nhà sản xuất</p>
                    <div class="d-flex flex-column gap-2 mb-3">
                        <c:forEach var="brand" items="${brands}">
                            <div class="form-check">
                                <%-- Logic giữ trạng thái checked của bà rất chuẩn --%>
                                <input class="form-check-input" type="checkbox" name="brandId" 
                                       value="${brand.id_thuong_hieu}" id="brand${brand.id_thuong_hieu}"
                                       <c:if test="${paramValues.brandId != null}">
                                           <c:forEach var="selectedId" items="${paramValues.brandId}">
                                               <c:if test="${selectedId == brand.id_thuong_hieu}">checked</c:if>
                                           </c:forEach>
                                       </c:if>>
                                <label class="form-check-label" for="brand${brand.id_thuong_hieu}">
                                    ${brand.ten_thuong_hieu}
                                </label>
                            </div>
                        </c:forEach>
                    </div>

                    <button type="submit" class="btn btn-danger w-100 btn-sm fw-bold py-2 mt-2">ÁP DỤNG LỌC</button>
                </form>
            </div>
        </div>

        <%-- Cột bên phải: Danh sách sản phẩm --%>
        <div class="col-md-9">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-uppercase">
                    <c:choose>
                        <c:when test="${not empty categoryName}">${categoryName}</c:when>
                        <c:otherwise>Tất cả điện thoại</c:otherwise>
                    </c:choose>
                </h4>
                <span class="text-muted small">Tìm thấy <strong>${products.size()}</strong> sản phẩm</span>
            </div>
            
            <div class="row">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="p" items="${products}">
                            <div class="col-md-4 mb-4">
                                <div class="card p-3 border-0 shadow-sm h-100 text-center">
                                    <a href="${pageContext.request.contextPath}/ProductDetailServlet?id=${p.id_san_pham}" class="text-decoration-none text-dark">
                                        <div class="mb-3" style="height: 180px;">
                                            <img src="${pageContext.request.contextPath}/uploads/san-pham/${p.url_anh}" 
                                                 class="img-fluid h-100" style="object-fit: contain;" alt="${p.ten_san_pham}">
                                        </div>
                                        <h6 class="fw-bold mb-1 text-truncate">${p.ten_san_pham}</h6>
                                        <p class="text-danger fw-bold mb-3">
                                            <fmt:formatNumber value="${p.gia_thap_nhat}" type="currency" currencySymbol="đ" />
                                        </p>
                                    </a>
                                    
                                    <div class="d-grid gap-2">
                                        <button class="btn btn-outline-dark btn-sm fw-bold py-2" 
                                                onclick="location.href='${pageContext.request.contextPath}/ProductDetailServlet?id=${p.id_san_pham}'">
                                            CHI TIẾT
                                        </button>
                                        <button class="btn btn-danger btn-sm fw-bold py-2" 
                                                onclick="location.href='${pageContext.request.contextPath}/ProductDetailServlet?id=${p.id_san_pham}'">
                                            MUA NGAY
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5">
                            <i class="bi bi-search fs-1 text-muted"></i>
                            <p class="mt-3 text-muted">Không tìm thấy sản phẩm nào.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />
<<<<<<< HEAD
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách Điện thoại</title>
        <style>
            .product-card { border: 1px solid #ccc; padding: 15px; margin: 10px; width: 200px; display: inline-block; text-align: center; }
            .price { color: red; font-weight: bold; }
        </style>
    </head>
    <body>
        <h2>Sản phẩm nổi bật</h2>
        
        <c:forEach items="${listP}" var="sp">
            <div class="product-card">
                <h4>${sp.tenSanPham}</h4>
                <p class="price">${sp.giaGoc} VNĐ</p>
                <p>${sp.moTa}</p>
                <button>Thêm vào giỏ</button>
            </div>
        </c:forEach>
        
    </body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="row">
        <div class="col-md-3">
            <div class="card p-3 mb-4 border-0 shadow-sm">
                <h5 class="fw-bold mb-3"><i class="bi bi-filter-left me-2"></i>Bộ lọc sản phẩm</h5>
                
                <form action="${pageContext.request.contextPath}/ProductListServlet" method="get">
                    <p class="fw-bold small mb-2 text-uppercase text-muted">Nhà sản xuất</p>
                    <div class="d-flex flex-column gap-2 mb-3">
                        <c:forEach var="brand" items="${brands}">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="brandId" 
                                       value="${brand.id_thuong_hieu}" id="brand${brand.id_thuong_hieu}"
                                       <c:if test="${paramValues.brandId != null}">
                                           <c:forEach var="selectedId" items="${paramValues.brandId}">
                                               <c:if test="${selectedId == brand.id_thuong_hieu}">checked</c:if>
                                           </c:forEach>
                                       </c:if>>
                                <label class="form-check-label" for="brand${brand.id_thuong_hieu}">
                                    ${brand.ten_thuong_hieu}
                                </label>
                            </div>
                        </c:forEach>
                    </div>

                    <button type="submit" class="btn btn-danger w-100 btn-sm fw-bold py-2 mt-2">ÁP DỤNG LỌC</button>
                </form>
            </div>
        </div>

        <div class="col-md-9">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-uppercase">
                    <c:choose>
                        <c:when test="${not empty categoryName}">${categoryName}</c:when>
                        <c:otherwise>Tất cả điện thoại</c:otherwise>
                    </c:choose>
                </h4>
                <span class="text-muted small">Tìm thấy <strong>${products.size()}</strong> sản phẩm</span>
            </div>
            
            <div class="row">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="p" items="${products}">
                            <div class="col-md-4 mb-4">
                                <div class="card p-3 border-0 shadow-sm h-100 text-center">
                                    <a href="${pageContext.request.contextPath}/ProductDetailServlet?id=${p.id_san_pham}" class="text-decoration-none text-dark">
                                        <div class="mb-3" style="height: 180px;">
                                            <img src="${pageContext.request.contextPath}/uploads/san-pham/${p.url_anh}" 
                                                 class="img-fluid h-100" style="object-fit: contain;" alt="${p.ten_san_pham}">
                                        </div>
                                        <h6 class="fw-bold mb-1 text-truncate">${p.ten_san_pham}</h6>
                                        <p class="text-danger fw-bold mb-3">
                                            <fmt:formatNumber value="${p.gia_thap_nhat}" type="currency" currencySymbol="đ" />
                                        </p>
                                    </a>
                                    
                                    <div class="d-grid gap-2">
                                        <button class="btn btn-outline-dark btn-sm fw-bold py-2" 
                                                onclick="location.href='${pageContext.request.contextPath}/ProductDetailServlet?id=${p.id_san_pham}'">
                                            CHI TIẾT
                                        </button>
                                        <button class="btn btn-danger btn-sm fw-bold py-2" 
                                                onclick="location.href='${pageContext.request.contextPath}/ProductDetailServlet?id=${p.id_san_pham}'">
                                            MUA NGAY
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5">
                            <i class="bi bi-search fs-1 text-muted"></i>
                            <p class="mt-3 text-muted">Không tìm thấy sản phẩm nào.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />
=======
>>>>>>> 33ebaca7d2c49db05c2e70428446b2bc26631a54
