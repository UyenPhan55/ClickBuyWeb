<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                        <td class="ps-3 fw-bold">#${order.idDonHang}</td>
                        <td>
                            <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy" />
                        </td>
                        <td class="text-danger fw-bold">
                            <fmt:formatNumber value="${order.tongTien}" type="number"/>đ
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">
                                    <span class="badge bg-warning text-dark">Chờ xác nhận</span>
                                </c:when>
                                <c:when test="${order.trangThai == 'DA_GIAO'}">
                                    <span class="badge bg-success">Đã giao hàng</span>
                                </c:when>
                                <c:when test="${order.trangThai == 'DA_HUY'}">
                                    <span class="badge bg-secondary">Đã hủy</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-info text-dark">${order.trangThai}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end pe-3">
                            <button class="btn btn-sm btn-dark" 
                                    onclick="location.href='chi-tiet-don-hang.jsp?id=${order.idDonHang}'">Chi tiết</button>
                            
                            <%-- Chỉ cho phép đánh giá nếu đơn hàng đã giao thành công --%>
                            <c:if test="${order.trangThai == 'DA_GIAO'}">
                                <button class="btn btn-sm btn-outline-danger" 
                                        onclick="location.href='them-danh-gia.jsp?id=${order.idDonHang}'">Đánh giá</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                <%-- Hiển thị thông báo nếu khách chưa mua gì --%>
                <c:if test="${empty orderList}">
                    <tr>
                        <td colspan="5" class="text-center py-5 text-muted">
                            <i class="bi bi-cart-x fs-1 d-block mb-2"></i>
                            Bạn chưa có đơn hàng nào 
                            <a href="${pageContext.request.contextPath}/user/trang-chu.jsp" class="text-danger fw-bold">Mua sắm ngay</a>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />