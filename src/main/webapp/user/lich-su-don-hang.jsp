<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang Jakarta --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <h3 class="fw-bold mb-4 border-start border-4 border-danger ps-3">LỊCH SỬ ĐƠN HÀNG CỦA TÔI</h3>
    
    <div class="card shadow-sm border-0 overflow-hidden">
        <table class="table table-hover align-middle mb-0">
            <thead class="bg-light">
                <tr>
                    <th class="ps-3">Mã đơn</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th class="text-end pe-3">Hành động</th>
                </tr>
            </thead>
            <tbody>
               
                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <td class="ps-3 fw-bold text-primary">#${order.idDonHang}</td>
                        <td>
                            <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy" />
                        </td>
                        <td class="text-danger fw-bold">
                            <%-- Định dạng tiền tệ theo chuẩn VNĐ --%>
                            <fmt:formatNumber value="${order.tongTien}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">
                                    <span class="badge rounded-pill bg-warning text-dark">Chờ xác nhận</span>
                                </c:when>
                                <c:when test="${order.trangThai == 'DA_GIAO'}">
                                    <span class="badge rounded-pill bg-success">Đã giao hàng</span>
                                </c:when>
                                <c:when test="${order.trangThai == 'DA_HUY'}">
                                    <span class="badge rounded-pill bg-secondary">Đã hủy</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge rounded-pill bg-info text-dark">${order.trangThai}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end pe-3">
                            <a href="${pageContext.request.contextPath}/chi-tiet-don-hang?id=${order.idDonHang}" 
                               class="btn btn-sm btn-dark shadow-sm">
                                <i class="bi bi-eye me-1"></i> Chi tiết
                            </a>
                            
                            <c:if test="${order.trangThai == 'DA_GIAO'}">
                                <a href="${pageContext.request.contextPath}/them-danh-gia?id=${order.idDonHang}" 
                                   class="btn btn-sm btn-outline-danger shadow-sm">
                                    <i class="bi bi-star-fill me-1"></i> Đánh giá
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty orderList}">
                    <tr>
                        <td colspan="5" class="text-center py-5 text-muted">
                            <i class="bi bi-cart-x fs-1 d-block mb-3 text-secondary"></i>
                            <h5>Bạn chưa có đơn hàng nào</h5>
                            <p class="small mb-4">Hãy tiếp tục khám phá các sản phẩm công nghệ mới nhất nhé!</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-danger px-4 fw-bold">Mua sắm ngay</a>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />
