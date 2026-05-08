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