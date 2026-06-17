<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <c:choose>
        <%-- TRƯỜNG HỢP CÓ SẢN PHẨM TRONG GIỎ --%>
        <c:when test="${not empty danhSachGioHang}">
            <h3 class="fw-bold mb-4 uppercase">GIỎ HÀNG CỦA BẠN</h3>
            <div class="row">
                <div class="col-lg-8">
                    <div class="card p-3 mb-4 border-0 shadow-sm" style="border-radius: 15px;">
                        <table class="table align-middle">
                            <thead>
                                <tr class="text-secondary small text-uppercase">
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Giá</th>
                                    <th class="text-center" style="width: 120px;">Số lượng</th>
                                    <th class="text-center">Thành tiền</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- ĐÃ SỬA: Tạo biến tạm để cộng dồn tổng tiền giỏ hàng --%>
                                <c:set var="tempTotal" value="0" />
                                
                                <c:forEach var="item" items="${danhSachGioHang}">
                                    <%-- ĐÃ SỬA: Lấy hàm getThanhTien() từ Model và cộng dồn vào tổng --%>
                                    <c:set var="tempTotal" value="${tempTotal + item.thanhTien}" />
                                    
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/assets/images/${item.urlAnh}" 
                                                     width="60" class="me-3 rounded border" alt="${item.tenSanPham}">
                                                <div>
                                                    <h6 class="mb-0 fw-bold">${item.tenSanPham}</h6>
                                                    <small class="text-danger">PB: ${item.tenBienThe}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <fmt:formatNumber value="${item.giaBienThe}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/GioHangServlet" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="idBienThe" value="${item.idBienThe}">
                                                <input type="number" name="soLuong" value="${item.soLuong}" min="1" 
                                                       class="form-control form-control-sm text-center" 
                                                       onchange="this.form.submit()">
                                            </form>
                                        </td>
                                        <%-- ĐÃ SỬA: Sửa lại cú pháp gọi thành tiền từng món (${item.thanhTien}) --%>
                                        <td class="text-center text-danger fw-bold">
                                            <fmt:formatNumber value="${item.thanhTien}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/GioHangServlet?action=remove&idBienThe=${item.idBienThe}" 
                                               class="text-danger" onclick="return confirm('Xóa món này hả bà?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card p-4 border-0 shadow-sm" style="border-radius: 20px;">
                        <h5 class="fw-bold mb-3">TỔNG CỘNG</h5>
                        <div class="d-flex justify-content-between mb-4">
                            <span>Tạm tính:</span>
                            <%-- ĐÃ SỬA: Thay thế biến lỗi bằng biến tính tổng tempTotal ở vòng lặp trên --%>
                            <span class="fs-4 fw-bold text-danger">
                                <fmt:formatNumber value="${tempTotal}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/DonHangServlet?action=checkout" 
                           class="btn btn-danger btn-lg w-100 fw-bold py-3 shadow">
                            TIẾN HÀNH THANH TOÁN
                        </a>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <i class="bi bi-cart-x text-muted" style="font-size: 5rem;"></i>
                <h4 class="mt-3">Giỏ hàng trống</h4>
                <a href="${pageContext.request.contextPath}/TrangChuServlet" class="btn btn-danger mt-3">MUA SẮM NGAY</a>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="../common/footer.jsp" />