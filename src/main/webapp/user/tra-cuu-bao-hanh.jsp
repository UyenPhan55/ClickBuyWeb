<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang hệ Jakarta cho Tomcat 10 --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="mx-auto" style="max-width: 850px;">
        <div class="card border-0 shadow-sm p-4 text-center">
            <h3 class="fw-bold text-danger mb-4 text-uppercase">Tra cứu bảo hành</h3>
            <p class="mb-4 text-muted">Nhập mã bảo hành (in trên thẻ) hoặc IMEI để kiểm tra thiết bị của bạn</p>
            
            <%-- Form gửi mã về BaoHanhServlet --%>
            <form action="${pageContext.request.contextPath}/BaoHanhServlet" method="get">
                <%-- CHỈNH SỬA 1: Thêm action lookup để Servlet chạy đúng case --%>
                <input type="hidden" name="action" value="lookup">
                
                <div class="input-group mb-4 shadow-sm" style="border-radius: 10px; overflow: hidden;">
                    <%-- CHỈNH SỬA 2: name="code" và value="${param.code}" để đồng bộ với Servlet --%>
                    <input type="text" name="code" class="form-control form-control-lg border-danger-subtle shadow-none" 
                           placeholder="Nhập mã bảo hành (VD: BH001)..." 
                           value="${param.code}" required>
                    <button class="btn btn-danger px-4 fw-bold" type="submit">
                        <i class="bi bi-search me-1"></i> TRA CỨU
                    </button>
                </div>
            </form>

            <%-- HIỂN THỊ KẾT QUẢ - CHỈNH SỬA 3: Đổi từ warrantyInfo sang baoHanh cho khớp Servlet --%>
            <c:if test="${not empty baoHanh}">
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
                        <c:when test="${baoHanh.trangThai == 'HET_HAN'}">
                            <div class="alert alert-secondary d-flex align-items-center shadow-sm border-0">
                                <i class="bi bi-calendar-x-fill fs-1 me-3"></i>
                                <div>
                                    <h5 class="fw-bold mb-0">Tình trạng: HẾT HẠN BẢO HÀNH</h5>
                                    <p class="mb-0 small">Thiết bị đã quá thời gian bảo hành. Vui lòng liên hệ để được hỗ trợ sửa chữa dịch vụ.</p>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-warning d-flex align-items-center shadow-sm border-0">
                                <i class="bi bi-exclamation-triangle-fill fs-1 me-3"></i>
                                <div>
                                    <h5 class="fw-bold mb-0">Tình trạng: ${baoHanh.trangThai}</h5>
                                    <p class="mb-0 small">Vui lòng liên hệ hotline để được hỗ trợ chi tiết về trường hợp này.</p>
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
                                            <%-- CHỈNH SỬA 4: Nếu DAO chưa join bảng SanPham thì tạm thời để ID hoặc MaCode --%>
                                            <div class="fw-bold text-dark text-uppercase">${baoHanh.maBaoHanhCode}</div>
                                            <div class="badge bg-light text-dark border mt-1 fw-normal">
                                                ID Biến thể: ${baoHanh.idBienThe}
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
                                            <a href="${pageContext.request.contextPath}/chi-tiet-don-hang?id=${baoHanh.idDonHang}" 
                                               class="btn btn-sm btn-outline-danger py-0 fw-bold">
                                                #CB${baoHanh.idDonHang} <i class="bi bi-arrow-right-short"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="p-3 bg-light rounded-3 text-center small text-muted border border-dashed">
                        <i class="bi bi-patch-exclamation me-1"></i> 
                        <strong>Lưu ý:</strong> ClickBuy hỗ trợ bảo hành điện tử. Quý khách chỉ cần đọc Mã bảo hành hoặc SĐT khi đến cửa hàng.
                    </div>
                </div>
            </c:if>

            <%-- THÔNG BÁO LỖI - CHỈNH SỬA 5: Kiểm tra đúng mã code nhập vào --%>
            <c:if test="${empty baoHanh && not empty param.code}">
                <div class="alert alert-danger mt-4 border-0 shadow-sm animate__animated animate__shakeX">
                    <i class="bi bi-x-circle-fill me-2"></i> 
                    Hệ thống không tìm thấy thông tin cho mã: <strong>${param.code}</strong>. Vui lòng kiểm tra lại!
                </div>
            </c:if>
        </div>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />
