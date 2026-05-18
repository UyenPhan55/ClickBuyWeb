<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="card border-0 shadow-sm mb-5" style="border-radius: 20px; background: linear-gradient(to right, #ffffff, #fffafa);">
        <div class="card-body p-4">
            <div class="d-flex align-items-center mb-4">
                <div class="bg-danger text-white rounded-circle d-flex align-items-center justify-content-center me-3 shadow-sm" style="width: 60px; height: 60px;">
                    <i class="bi bi-person-vcard fs-3"></i>
                </div>
                <div>
                    <h4 class="fw-bold mb-0 text-dark">HỒ SƠ CỦA TÔI</h4>
                    <div class="mt-1">
                        <c:choose>
                            <c:when test="${sessionScope.user.trangThai == 1}">
                                <span class="badge bg-success-subtle text-success border border-success-subtle px-3 rounded-pill">
                                    <i class="bi bi-check-circle-fill me-1"></i> Đang hoạt động
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 rounded-pill">
                                    <i class="bi bi-lock-fill me-1"></i> Đang bị khóa
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4 border-end">
                    <label class="text-muted small fw-bold d-block mb-1 text-uppercase">Họ và tên</label>
                    <span class="fs-5 fw-bold text-dark">${not empty sessionScope.user.tenDayDu ? sessionScope.user.tenDayDu : 'Chưa cập nhật'}</span>
                </div>
                <div class="col-md-4 border-end">
                    <label class="text-muted small fw-bold d-block mb-1 text-uppercase">Email liên lạc</label>
                    <span class="fs-5 fw-bold text-dark">${not empty sessionScope.user.email ? sessionScope.user.email : 'Chưa cập nhật'}</span>
                </div>
                <div class="col-md-4">
                    <label class="text-muted small fw-bold d-block mb-1 text-uppercase">Số điện thoại</label>
                    <span class="fs-5 fw-bold text-danger">${not empty sessionScope.user.sdt ? sessionScope.user.sdt : 'N/A'}</span>
                </div>
            </div>
        </div>
    </div>

    <h4 class="fw-bold mb-4 border-start border-4 border-danger ps-3 text-uppercase">Lịch sử hoạt động</h4>
    
    <div class="card shadow-sm border-0 overflow-hidden" style="border-radius: 15px;">
        <table class="table table-hover align-middle mb-0">
            <thead class="bg-light">
                <tr class="text-uppercase small" style="letter-spacing: 0.5px;">
                    <th class="ps-4 py-3">Mã đơn</th>
                    <th class="py-3">Ngày đặt</th>
                    <th class="py-3">Tổng tiền</th>
                    <th class="py-3">Trạng thái</th>
                    <th class="py-3 text-center">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${danhSachDonHang}">
                    <tr>
                        <td class="ps-4 fw-bold text-primary">#${order.idDonHang}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty order.ngayDat}">
                                    <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy" />
                                </c:when>
                                <c:otherwise><span class="text-muted">N/A</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-danger fw-bold">
                            <fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">
                                    <span class="badge rounded-pill bg-warning text-dark px-3">
                                        <i class="bi bi-clock me-1"></i> Chờ xác nhận
                                    </span>
                                </c:when>
                                <c:when test="${order.trangThai == 'DA_GIAO'}">
                                    <span class="badge rounded-pill bg-success px-3">
                                        <i class="bi bi-check-lg me-1"></i> Đã giao hàng
                                    </span>
                                </c:when>
                                <c:when test="${order.trangThai == 'DA_HUY'}">
                                    <span class="badge rounded-pill bg-secondary px-3">
                                        <i class="bi bi-x-circle me-1"></i> Đã hủy
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge rounded-pill bg-info text-dark px-3">${order.trangThai}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <div class="d-flex justify-content-center gap-2">
                                <%-- NÚT CHI TIẾT --%>
                                <a href="${pageContext.request.contextPath}/don-hang?action=detail&id=${order.idDonHang}" 
                                   class="btn btn-sm btn-outline-primary px-3 shadow-sm" style="border-radius: 8px;">
                                    <i class="bi bi-eye-fill"></i> Chi tiết
                                </a>

                                <%-- NÚT ĐÁNH GIÁ (Chỉ hiện khi đã giao hàng) --%>
                                <c:if test="${order.trangThai == 'DA_GIAO'}">
                                    <a href="user/them-danh-gia.jsp?idSanPham=${item.idSanPham}&idDonHang=${item.idDonHang}" 
                                        class="btn btn-danger">
                                        Đánh giá
                                    </a>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty danhSachDonHang}">
                    <tr>
                        <td colspan="5" class="text-center py-5">
                            <i class="bi bi-cart-x fs-1 text-muted d-block mb-3"></i>
                            <h5 class="fw-bold text-muted">Bạn chưa có đơn hàng nào</h5>
                            <a href="${pageContext.request.contextPath}/TrangChuServlet" class="btn btn-danger px-5 mt-3 fw-bold py-2" style="border-radius: 10px;">
                                MUA SẮM NGAY
                            </a>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />
