<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng - ClickBuy</title>
    <jsp:include page="../common/header.jsp" />
    <style>
        .track-line { height: 4px; background-color: #eee; position: relative; top: 20px; z-index: 1; }
        .track-line-active { 
            height: 100%; background-color: #28a745; 
 
            width: ${order.trangThai == 'CHO_XAC_NHAN' ? '25%' : 
                    order.trangThai == 'DA_XAC_NHAN' ? '50%' : 
                    order.trangThai == 'DANG_GIAO' ? '75%' : '100%'}; 
        }
        .step-item { position: relative; z-index: 2; text-align: center; width: 25%; }
        .step-icon { 
            width: 40px; height: 40px; background: #eee; color: #bbb; 
            border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 8px;
            border: 3px solid #fff;
        }
        .step-item.active .step-icon { background: #d70018; color: #fff; }
        .step-item.completed .step-icon { background: #28a745; color: #fff; }
        .step-text { font-size: 12px; font-weight: bold; color: #888; }
        .step-item.active .step-text { color: #d70018; }
        .step-item.completed .step-text { color: #28a745; }
        .back-link { text-decoration: none !important; color: inherit !important; transition: 0.2s; }
        .back-link:hover { color: #d70018 !important; }
    </style>
</head>
<body style="background-color: #f8f9fa;">
    <jsp:include page="../common/navbar-user.jsp" />

    <div class="container my-5">
        <div class="card border-0 shadow-sm p-4 mb-4" style="border-radius: 20px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="${pageContext.request.contextPath}/DonHangServlet?action=history" class="back-link">
                    <%-- Sửa id_don_hang -> idDonHang --%>
                    <h4 class="fw-bold mb-0"><i class="bi bi-arrow-left me-2"></i> CHI TIẾT ĐƠN #CB${order.idDonHang}</h4>
                </a>
                <a href="${pageContext.request.contextPath}/KhieuNaiServlet?action=mine&idDonHang=${order.idDonHang}" 
                   class="btn btn-outline-warning btn-sm fw-bold">
                    Gửi khiếu nại
                </a>
            </div>



            <div class="row pt-4 mt-4 border-top">
                <%-- CỘT TRÁI: DANH SÁCH SẢN PHẨM --%>
                <div class="col-md-7 border-end">
                    <h6 class="fw-bold mb-3 text-uppercase small text-secondary">Sản phẩm đã đặt</h6>
                    
                    <c:forEach var="item" items="${chiTietDonHang}">
                        <div class="d-flex align-items-center p-3 border rounded mb-3 bg-white shadow-sm">
                            <%-- SỬA: url_anh -> urlAnh, ten_san_pham -> tenSanPham --%>
                            <img src="${pageContext.request.contextPath}/assets/images/${item.urlAnh}" 
                                 width="80" class="me-3 rounded border" 
                                 onerror="this.src='https://placehold.co/80x80?text=Phone'">
                            <div>
                                <div class="fw-bold text-dark">${item.tenSanPham}</div>
                                <div class="small text-muted">Biến thể: ${item.tenBienThe} | SL: ${item.soLuong}</div>
                                <div class="text-danger fw-bold">
                                    <fmt:formatNumber value="${item.donGia}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </div>
                                <c:if test="${order.trangThai == 'DA_GIAO' || order.trangThai == 'HOAN_THANH'}">
                                    <a href="${pageContext.request.contextPath}/user/them-danh-gia.jsp?idDonHang=${order.idDonHang}&idBienThe=${item.idBienThe}"
                                       class="btn btn-sm btn-outline-danger mt-2">
                                        <i class="bi bi-star-fill"></i> Đánh giá
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                
                <div class="col-md-5 ps-md-4">
                    <h6 class="fw-bold mb-3 text-uppercase small text-secondary">Thông tin nhận hàng</h6>
                    
                    <div class="d-flex mb-2">
                        <i class="bi bi-person me-2 text-danger"></i>
                       
                        <span class="fw-bold text-dark">${sessionScope.user.tenDayDu} (ID: #USR${sessionScope.user.idNguoiDung})</span>
                    </div>
                    <div class="d-flex mb-3">
                        <i class="bi bi-telephone me-2 text-danger"></i>
                       
                        <span class="fw-bold text-dark">${order.sdtNguoiNhan != null ? order.sdtNguoiNhan : sessionScope.user.sdt}</span>
                    </div>
                    
                    <div class="d-flex mb-4">
                        <i class="bi bi-geo-alt me-2 text-danger"></i>
                        <div class="small text-muted">
                            <span class="fw-bold text-dark">Địa chỉ nhận hàng:</span><br>
                       
                            ${order.diaChi != null ? order.diaChi : sessionScope.user.diaChi}
                        </div>
                    </div>

                    <div class="pt-3 border-top mt-3">
                        <h6 class="fw-bold mb-3 text-uppercase small text-secondary">Tóm tắt thanh toán</h6>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted small">Tạm tính:</span>
                            <span class="fw-bold text-dark small">
                                <fmt:formatNumber value="${order.tamTinh}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted small">Giảm giá:</span>
                            <span class="fw-bold text-success small">
                                -<fmt:formatNumber value="${order.giamGia}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <hr class="my-2">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="fw-bold text-dark fs-6">Tổng thanh toán:</span>
                            <span class="fw-bold text-danger fs-5">
                                <fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="small text-muted">Thời gian đặt:</span>
                            <span class="small fw-bold text-dark">
                                <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm:ss" />
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
