<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang hệ Jakarta --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5">
    <div class="mx-auto" style="max-width: 700px;">
        <div class="card shadow-sm border-0 p-4">
            <h3 class="fw-bold text-center mb-4 text-danger">GỬI KHIẾU NẠI</h3>
            <p class="text-center text-muted mb-4">Bạn gặp vấn đề gì hãy nói cho ClickBuy biết nhé!</p>
            
            <form action="${pageContext.request.contextPath}/KhieuNaiServlet" method="post">
                
                <div class="mb-3">
                    <label class="form-label fw-bold"><i class="bi bi-box-seam me-1"></i> Chọn đơn hàng cần khiếu nại</label>
                    <select class="form-select border-danger-subtle shadow-none" name="id_don_hang" required>
                        <option value="" selected disabled>-- Chọn đơn hàng --</option>
                        <c:forEach var="order" items="${orders}">
                            <%-- Lưu ý: Kiểm tra xem Uyên đặt tên là idDonHang hay id_don_hang để sửa cho khớp nhé --%>
                            <option value="${order.idDonHang}">
                                Đơn hàng #${order.maDonHang} - <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy" />
                            </option>
                        </c:forEach>
                        
                        <c:if test="${empty orders}">
                            <option value="0">Chưa có dữ liệu đơn hàng</option>
                        </c:if>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Nội dung</label>
                    <textarea class="form-control border-danger-subtle shadow-none" 
                              name="noi_dung" rows="5" required
                              placeholder="Mô tả chi tiết vấn đề..."></textarea>
                </div>

                <div class="mb-3 p-3 bg-light rounded border border-dashed" style="border-style: dashed !important;">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="yeu_cau_tra_hang" 
                               id="returnRequest" value="1">
                        <label class="form-check-label fw-bold text-danger" for="returnRequest">
                            Tôi muốn trả hàng / hoàn tiền
                        </label>
                    </div>
                </div>

                <div class="mb-4 d-flex justify-content-between align-items-center">
                    <%-- Dùng JSP để lấy ngày hiện tại tự động luôn cho xịn bà nè --%>
                    <small class="text-muted">Ngày gửi: <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy" /></small>
                    <span class="badge bg-warning text-dark">CHỜ TIẾP NHẬN</span>
                </div>

                <button type="submit" class="btn btn-danger w-100 py-3 fw-bold shadow-sm">
                    GỬI KHIẾU NẠI NGAY
                </button>
            </form>
        </div>
    </div>
</main>

<%-- MODAL THÔNG BÁO THÀNH CÔNG --%>
<c:if test="${param.status == 'success'}">
    <div class="modal fade show" id="successModal" tabindex="-1" style="display: block; background: rgba(0,0,0,0.5); z-index: 1060;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-body text-center p-5">
                    <div class="mb-4">
                        <i class="bi bi-check-circle-fill text-success" style="font-size: 4rem;"></i>
                    </div>
                    <h4 class="fw-bold mb-3">Gửi khiếu nại thành công!</h4>
                    <p class="text-muted mb-4">
                        ClickBuy đã tiếp nhận phản hồi. Chúng tôi sẽ xử lý và trả lời bạn sớm nhất
                    </p>
                    <button type="button" class="btn btn-danger px-5 fw-bold" 
                            onclick="location.href='${pageContext.request.contextPath}/user/lich-su-don-hang.jsp'">
                        ĐÓNG VÀ XEM ĐƠN HÀNG
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<jsp:include page="../common/footer.jsp" />
