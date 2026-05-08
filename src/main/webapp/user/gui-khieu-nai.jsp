<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                            <option value="${order.idDonHang}">
                                Đơn hàng #${order.maDonHang} - <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy" />
                            </option>
                        </c:forEach>
                        <%-- Option dự phòng nếu các bạn Java chưa đổ dữ liệu --%>
                        <c:if test="${empty orders}">
                            <option value="0">Chưa có dữ liệu đơn hàng</option>
                        </c:if>
                    </select>
                </div>

                <%-- 2. Nội dung (Khớp với cột 'noi_dung' trong DB) --%>
                <div class="mb-3">
                    <label class="form-label fw-bold">Nội dung</label>
                    <textarea class="form-control border-danger-subtle shadow-none" 
                              name="noi_dung" rows="5" required
                              placeholder="Mô tả chi tiết vấn đề..."></textarea>
                </div>

                <%-- 3. Yêu cầu trả hàng (Khớp với cột 'yeu_cau_tra_hang' - kiểu tinyint) --%>
                <div class="mb-3 p-3 bg-light rounded border border-dashed" style="border-style: dashed !important;">
                    <div class="form-check form-switch">
                        <%-- Value là 1 tương ứng với YES trong Database --%>
                        <input class="form-check-input" type="checkbox" name="yeu_cau_tra_hang" 
                               id="returnRequest" value="1">
                        <label class="form-check-label fw-bold text-danger" for="returnRequest">
                            Tôi muốn trả hàng / hoàn tiền
                        </label>
                    </div>
                </div>

                <%-- Các thông tin ẩn/mặc định hiển thị cho user --%>
                <div class="mb-4 d-flex justify-content-between align-items-center">
                    <small class="text-muted">Ngày gửi: 27/04/2026</small>
                    <span class="badge bg-warning text-dark">CHỜ TIẾP NHẬN</span>
                </div>

                <button type="submit" class="btn btn-danger w-100 py-3 fw-bold shadow-sm">
                    GỬI KHIẾU NẠI NGAY
                </button>
            </form>
        </div>
    </div>
</main>

<%-- MODAL THÔNG BÁO (Hiện ra khi các bạn Servlet redirect kèm status=success) --%>
<c:if test="${param.status == 'success'}">
    <div class="modal fade show" id="successModal" tabindex="-1" style="display: block; background: rgba(0,0,0,0.5);">
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