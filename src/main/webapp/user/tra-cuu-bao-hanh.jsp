<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="mx-auto" style="max-width: 800px;">
        <div class="card border-0 shadow-sm p-4 text-center">
            <h3 class="fw-bold text-danger mb-4 text-uppercase">Tra cứu bảo hành</h3>
            <p class="mb-4 text-muted">Nhập mã bảo hành (in trên thẻ) hoặc IMEI để kiểm tra máy</p>
            
            <%-- Form gửi mã về BaoHanhServlet --%>
            <form action="${pageContext.request.contextPath}/BaoHanhServlet" method="get">
                <div class="input-group mb-4 shadow-sm" style="border-radius: 8px; overflow: hidden;">
                    <input type="text" name="ma_tra_cuu" class="form-control form-control-lg border-danger-subtle shadow-none" 
                           placeholder="Nhập mã bảo hành (VD: BH123456)..." 
                           value="${param.ma_tra_cuu}" required>
                    <button class="btn btn-danger px-4 fw-bold" type="submit">TRA CỨU</button>
                </div>
            </form>

            <%-- HIỂN THỊ KẾT QUẢ: Chỉ hiện khi object 'warrantyInfo' có dữ liệu từ Servlet --%>
            <c:if test="${not empty warrantyInfo}">
                <div id="warrantyResult" class="text-start border-top pt-4 mt-2">
                    
                    <%-- 1. Alert tình trạng bảo hành (Dựa vào ENUM trang_thai) --%>
                    <c:choose>
                        <c:when test="${warrantyInfo.trangThai == 'CON_HAN'}">
                            <div class="alert alert-success d-flex align-items-center shadow-sm">
                                <i class="bi bi-shield-check-fill fs-3 me-3"></i>
                                <div>
                                    <h5 class="fw-bold mb-0">Tình trạng: CÒN HẠN BẢO HÀNH</h5>
                                    <small>Thiết bị của bạn đang trong diện bảo hành chính hãng tại ClickBuy.</small>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-warning d-flex align-items-center shadow-sm">
                                <i class="bi bi-exclamation-triangle-fill fs-3 me-3"></i>
                                <div>
                                    <h5 class="fw-bold mb-0">Tình trạng: ${warrantyInfo.trangThai}</h5>
                                    <small>Vui lòng liên hệ cửa hàng để được hỗ trợ chi tiết.</small>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="row mt-4">
                        <div class="col-md-12">
                            <table class="table table-hover border">
                                <tbody>
                                    <tr>
                                        <th class="bg-light w-35 text-secondary"><i class="bi bi-qr-code me-2"></i>Mã bảo hành</th>
                                        <td class="fw-bold text-dark">${warrantyInfo.maBaoHanhCode}</td>
                                    </tr>
                                    <tr>
                                        <th class="bg-light text-secondary"><i class="bi bi-laptop me-2"></i>Sản phẩm</th>
                                        <td>
                                            <div class="fw-bold text-dark">${warrantyInfo.tenSanPham}</div>
                                            <small class="text-muted">Biến thể: ${warrantyInfo.tenBienThe} (ID: #${warrantyInfo.idBienThe})</small>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="bg-light text-secondary"><i class="bi bi-calendar-check me-2"></i>Ngày kích hoạt</th>
                                        <td><fmt:formatDate value="${warrantyInfo.ngayBatDau}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                    <tr>
                                        <th class="bg-light text-secondary"><i class="bi bi-calendar-x me-2"></i>Ngày hết hạn</th>
                                        <td class="text-danger fw-bold"><fmt:formatDate value="${warrantyInfo.ngayKetThuc}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                    <tr>
                                        <th class="bg-light text-secondary"><i class="bi bi-person-badge me-2"></i>Nhân viên xử lý</th>
                                        <td>${warrantyInfo.tenNhanVien} (Kỹ thuật viên)</td>
                                    </tr>
                                    <tr>
                                        <th class="bg-light text-secondary"><i class="bi bi-receipt me-2"></i>Mã đơn đặt hàng</th>
                                        <td><a href="chi-tiet-don-hang.jsp?id=${warrantyInfo.idDonHang}" class="text-decoration-none text-danger fw-bold">#CB${warrantyInfo.idDonHang}</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="p-3 bg-light rounded text-center small text-muted">
                        <i class="bi bi-info-circle me-1"></i> Lưu ý: Quý khách vui lòng mang theo thẻ bảo hành hoặc ảnh chụp mã bảo hành khi đến cửa hàng.
                    </div>
                </div>
            </c:if>

            <%-- THÔNG BÁO NẾU KHÔNG TÌM THẤY --%>
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-4">
                    <i class="bi bi-x-circle me-2"></i> Không tìm thấy thông tin bảo hành cho mã: <strong>${param.ma_tra_cuu}</strong>
                </div>
            </c:if>
        </div>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />