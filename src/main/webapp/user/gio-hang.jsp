<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/common/header.jsp" />
<jsp:include page="/common/navbar-user.jsp" />

<main class="container my-5" id="cart-container">
    <c:choose>
        <%-- 1. TRƯỜNG HỢP CÓ SẢN PHẨM TRONG GIỎ (Sử dụng attribute danhSachGioHang từ Servlet) --%>
        <c:when test="${not empty danhSachGioHang}">
            <h3 class="fw-bold mb-4 text-uppercase border-start border-4 border-danger ps-3">GIỎ HÀNG CỦA BẠN</h3>
            <div class="row">
                <div class="col-lg-8">
                    <div class="card p-3 mb-4 border-0 shadow-sm" style="border-radius: 15px;">
                        <table class="table align-middle">
                            <thead>
                                <tr class="text-secondary small text-uppercase">
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Giá</th>
                                    <th class="text-center" style="width: 120px;">Số lượng</th>
                                    <th class="text-center">Tổng tiền</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="tempTotal" value="0" />
                                <c:forEach var="item" items="${danhSachGioHang}">
                                    <%-- Tính toán tổng tiền ngay trên giao diện --%>
                                    <c:set var="subTotal" value="${item.giaBienThe * item.soLuong}" />
                                    <c:set var="tempTotal" value="${tempTotal + subTotal}" />
                                    
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <a href="${pageContext.request.contextPath}/san-pham?action=chi-tiet&id=${item.idBienThe}">
                                                    <img src="${pageContext.request.contextPath}/assets/images/${item.urlAnh}" 
                                                         width="70" class="me-3 rounded shadow-sm border" alt="${item.tenSanPham}">
                                                </a>
                                                <div>
                                                    <h6 class="mb-0">
                                                        <a href="${pageContext.request.contextPath}/san-pham?action=chi-tiet&id=${item.idBienThe}" class="text-decoration-none text-dark fw-bold">
                                                            ${item.tenSanPham}
                                                        </a>
                                                    </h6>
                                                    <small class="text-danger d-block fw-medium">Phiên bản: ${item.tenBienThe}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center fw-bold text-dark">
                                            <fmt:formatNumber value="${item.giaBienThe}" pattern="#,###" />đ
                                        </td>
                                        <td>
                                            <%-- Gửi về GioHangServlet với action=update --%>
                                            <form action="${pageContext.request.contextPath}/GioHangServlet" method="post" class="d-flex align-items-center justify-content-center">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="idBienThe" value="${item.idBienThe}">
                                                <input type="number" name="soLuong" value="${item.soLuong}" min="1" 
                                                       class="form-control form-control-sm text-center shadow-none border-secondary" 
                                                       style="border-radius: 8px;"
                                                       onchange="this.form.submit()">
                                            </form>
                                        </td>
                                        <td class="text-center text-danger fw-bold">
                                            <fmt:formatNumber value="${subTotal}" pattern="#,###" />đ
                                        </td>
                                        <td class="text-end">
                                            <%-- Gửi về GioHangServlet với action=remove --%>
                                            <a href="${pageContext.request.contextPath}/GioHangServlet?action=remove&idBienThe=${item.idBienThe}" 
                                               class="btn btn-sm btn-outline-secondary border-0" 
                                               onclick="return confirm('Bà có chắc muốn bỏ máy này khỏi giỏ không?')">
                                                <i class="bi bi-trash text-danger"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/TrangChuServlet" class="text-decoration-none text-danger fw-bold small">
                            <i class="bi bi-arrow-left"></i> TIẾP TỤC MUA SẮM
                        </a>
                        <%-- Nút xóa sạch giỏ hàng --%>
                        <a href="${pageContext.request.contextPath}/GioHangServlet?action=clear" class="text-muted small text-decoration-none" onclick="return confirm('Xóa hết giỏ hàng hả bà?')">
                            <i class="bi bi-x-circle"></i> Xóa sạch giỏ hàng
                        </a>
                    </div>
                </div>

                <div class="col-lg-4">
                    <%-- TÓM TẮT ĐƠN HÀNG --%>
                    <div class="card p-4 border-0 shadow-sm bg-white" style="border-radius: 20px;">
                        <h5 class="fw-bold mb-4">TÓM TẮT ĐƠN HÀNG</h5>
                        
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Tạm tính (${danhSachGioHang.size()} sản phẩm):</span>
                            <span class="fw-bold text-dark"><fmt:formatNumber value="${tempTotal}" pattern="#,###" />đ</span>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Phí vận chuyển:</span>
                            <span class="text-success fw-bold">Miễn phí</span>
                        </div>
                        
                        <hr class="my-4">
                        
                        <div class="d-flex justify-content-between mb-4">
                            <span class="fs-5 fw-bold text-dark">Tổng cộng:</span>
                            <span class="fs-4 fw-bold text-danger">
                                <fmt:formatNumber value="${tempTotal}" pattern="#,###" />đ
                            </span>
                        </div>
                        
                        <%-- Chuyển sang DonHangServlet để bắt đầu luồng Thanh toán --%>
                        <button class="btn btn-danger btn-lg w-100 fw-bold py-3 shadow" 
                                style="border-radius: 15px;"
                                onclick="location.href='${pageContext.request.contextPath}/DonHangServlet?action=checkout'">
                            THANH TOÁN NGAY
                        </button>
                        
                        <div class="mt-4 p-3 bg-light rounded-3 small">
                            <p class="mb-1 text-muted"><i class="bi bi-shield-check text-success me-2"></i>Bảo mật thanh toán 100%</p>
                            <p class="mb-0 text-muted"><i class="bi bi-arrow-counterclockwise text-success me-2"></i>Đổi trả trong 30 ngày nếu có lỗi</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>

        <%-- 2. TRƯỜNG HỢP GIỎ HÀNG ĐANG TRỐNG --%>
        <c:otherwise>
            <div class="text-center py-5">
                <div class="mb-4">
                    <i class="bi bi-cart-x text-muted opacity-25" style="font-size: 8rem;"></i>
                </div>
                <h4 class="fw-bold text-muted">Giỏ hàng của bạn đang trống</h4>
                <p class="text-secondary mb-4">Hãy chọn sản phẩm để tiếp tục mua sắm nhé!</p>
                <a href="${pageContext.request.contextPath}/TrangChuServlet" 
                   class="btn btn-danger px-5 fw-bold py-3 shadow rounded-pill">
                    MUA SẮM NGAY
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="/common/footer.jsp" />
