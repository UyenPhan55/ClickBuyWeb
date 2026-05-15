<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="mx-auto" style="max-width: 850px;">
        <div class="card border-0 shadow-sm p-4 text-center">
            <h3 class="fw-bold text-danger mb-4 text-uppercase">Tra cứu bảo hành</h3>
            <p class="mb-4 text-muted">Nhập mã bảo hành (in trên thẻ) để kiểm tra thiết bị của bạn</p>
            
            <%-- Form gửi mã về BaoHanhServlet --%>
            <form action="${pageContext.request.contextPath}/BaoHanhServlet" method="get">
                <input type="hidden" name="action" value="lookup">
                
                <div class="input-group mb-4 shadow-sm" style="border-radius: 10px; overflow: hidden;">
                    <input type="text" name="code" class="form-control form-control-lg border-danger-subtle shadow-none" 
                           placeholder="Nhập mã bảo hành (VD: BH001)..." 
                           value="${param.code}" required>
                    <button class="btn btn-danger px-4 fw-bold" type="submit">
                        <i class="bi bi-search me-1"></i> TRA CỨU
                    </button>
                </div>
            </form>

            <c:if test="${not empty baoHanh}">
                <%-- 
                    BƯỚC KIỂM TRA BẢO MẬT: 
                    Chỉ hiện thông tin nếu ID người dùng của bảo hành khớp với ID người dùng đang đăng nhập 
                --%>
                <c:choose>
                    <c:when test="${baoHanh.idNguoiDung == sessionScope.user.idNguoiDung}">
                        <div id="warrantyResult" class="text-start border-top pt-4 mt-2 animate__animated animate__fadeIn">
                            
                            <%-- 1. Alert tình trạng bảo hành --%>
                            <c:choose>
                                <c:when test="${baoHanh.trangThai == 'CON_HAN'}">
                                    <div class="alert alert-success d-flex align-items-center shadow-sm border-0">
                                        <i class="bi bi-shield-check-fill fs-1 me-3"></i>
                                        <div>
                                            <h5 class="fw-bold mb-0">Tình trạng: CÒN HẠN BẢO HÀNH</h5>
                                            <p class="mb-0 small">Thiết bị của bạn đang trong thời gian bảo hành chính hãng tại ClickBuy.</p>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-secondary d-flex align-items-center shadow-sm border-0">
                                        <i class="bi bi-calendar-x-fill fs-1 me-3"></i>
                                        <div>
                                            <h5 class="fw-bold mb-0">Tình trạng: ${baoHanh.trangThai == 'HET_HAN' ? 'HẾT HẠN' : baoHanh.trangThai}</h5>
                                            <p class="mb-0 small">Vui lòng liên hệ hotline ClickBuy để được hỗ trợ chi tiết.</p>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <h6 class="fw-bold mb-3"><i class="bi bi-info-circle-fill me-2 text-danger"></i>THÔNG TIN CHI TIẾT</h6>
                                    <table class="table table-bordered align-middle">
                                        <tbody>
                                            <tr>
                                                <th class="bg-light w-35 text-secondary fw-medium">Mã bảo hành</th>
                                                <td class="fw-bold text-dark">${baoHanh.maBaoHanhCode}</td>
                                            </tr>
                                            <tr>
                                                <th class="bg-light text-secondary fw-medium">Sản phẩm</th>
                                                <td>
                                                    <div class="fw-bold text-dark text-uppercase">${baoHanh.tenSanPham}</div>
                                                    <div class="badge bg-light text-dark border mt-1 fw-normal">
                                                        Phân loại: ${baoHanh.tenBienThe}
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="bg-light text-secondary fw-medium">Ngày kích hoạt</th>
                                                <td class="text-primary fw-bold">
                                                    <fmt:formatDate value="${baoHanh.ngayBatDau}" pattern="dd/MM/yyyy" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="bg-light text-secondary fw-medium">Ngày hết hạn</th>
                                                <td class="text-danger fw-bold">
                                                    <fmt:formatDate value="${baoHanh.ngayKetThuc}" pattern="dd/MM/yyyy" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="bg-light text-secondary fw-medium">Đơn hàng gốc</th>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/DonHangServlet?action=detail&id=${baoHanh.idDonHang}" 
                                                       class="btn btn-sm btn-outline-danger py-0 fw-bold">
                                                        #CB${baoHanh.idDonHang} <i class="bi bi-arrow-right-short"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </c:when>

                    <%-- TRƯỜNG HỢP: Có mã nhưng KHÔNG phải của người đang đăng nhập --%>
                    <c:otherwise>
                        <div class="alert alert-warning mt-4 border-0 shadow-sm animate__animated animate__shakeX">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-shield-lock-fill fs-2 me-3 text-warning"></i>
                                <div>
                                    <h6 class="fw-bold mb-1">Từ chối truy cập!</h6>
                                    <p class="mb-0 small">Mã bảo hành <strong>${param.code}</strong> không thuộc quyền sở hữu của bạn. Vui lòng kiểm tra lại.</p>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <%-- THÔNG BÁO LỖI: Không tìm thấy mã trong Database --%>
            <c:if test="${empty baoHanh && not empty param.code}">
                <div class="alert alert-danger mt-4 border-0 shadow-sm animate__animated animate__shakeX">
                    <i class="bi bi-x-circle-fill me-2"></i> 
                    Hệ thống không tìm thấy thông tin cho mã: <strong>${param.code}</strong>.
                </div>
            </c:if>
        </div>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />
