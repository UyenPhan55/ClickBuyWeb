<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng - ClickBuy</title>
    <%-- Đường dẫn include header --%>
    <jsp:include page="../common/header.jsp" />
    <style>
        .track-line { height: 4px; background-color: #eee; position: relative; top: 20px; z-index: 1; }
        
        .track-line-active { 
            height: 100%; background-color: #28a745; 
            width: ${order.trang_thai == 'CHO_XAC_NHAN' ? '25%' : 
                    order.trang_thai == 'DA_XAC_NHAN' ? '50%' : 
                    order.trang_thai == 'DANG_GIAO' ? '75%' : '100%'}; 
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
        .border-dashed { border-style: dashed !important; }
    </style>
</head>
<body style="background-color: #f8f9fa;">
    <jsp:include page="../common/navbar-user.jsp" />

    <div class="container my-5">
        <div class="card border-0 shadow-sm p-4 mb-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="${pageContext.request.contextPath}/user/lich-su-don-hang.jsp" class="back-link">
                    <h4 class="fw-bold mb-0"> CHI TIẾT ĐƠN #CB${order.id_don_hang}</h4>
                </a>
                <a href="${pageContext.request.contextPath}/user/gui-khieu-nai.jsp?orderId=${order.id_don_hang}" 
                   class="btn btn-outline-warning btn-sm fw-bold">
                    Gửi khiếu nại
                </a>
            </div>

            <div class="position-relative mb-5 px-5">
                <div class="track-line">
                    <div class="track-line-active"></div> 
                </div>
                <div class="d-flex justify-content-between">
                    <div class="step-item ${order.trang_thai != null ? 'completed' : ''}">
                        <div class="step-icon">📦</div>
                        <div class="step-text">Đã đặt hàng</div>
                    </div>
                    <div class="step-item ${order.trang_thai == 'DA_XAC_NHAN' || order.trang_thai == 'DANG_GIAO' || order.trang_thai == 'DA_GIAO' ? 'completed' : ''}">
                        <div class="step-icon">💳</div>
                        <div class="step-text">Đã xác nhận</div>
                    </div>
                    <div class="step-item ${order.trang_thai == 'DANG_GIAO' ? 'active' : (order.trang_thai == 'DA_GIAO' ? 'completed' : '')}">
                        <div class="step-icon">🚚</div>
                        <div class="step-text">Đang giao</div>
                    </div>
                    <div class="step-item ${order.trang_thai == 'DA_GIAO' ? 'completed' : ''}">
                        <div class="step-icon">✅</div>
                        <div class="step-text">Đã nhận hàng</div>
                    </div>
                </div>
            </div>

            <div class="row pt-4 mt-4 border-top">
                <div class="col-md-7 border-end">
                    <h6 class="fw-bold mb-3 text-uppercase small text-secondary">Sản phẩm đã đặt</h6>
                    
                    <c:forEach var="item" items="${orderItems}">
                        <div class="d-flex align-items-center p-3 border rounded mb-3 bg-white shadow-sm">
                            <img src="${pageContext.request.contextPath}/uploads/san-pham/${item.url_anh}" width="80" class="me-3 rounded border" alt="${item.ten_san_pham}">
                            <div>
                                <div class="fw-bold text-dark">${item.ten_san_pham}</div>
                                <div class="small text-muted">Biến thể: ${item.ten_bien_the} | SL: ${item.so_luong}</div>
                                <div class="text-danger fw-bold">
                                    <fmt:formatNumber value="${item.don_gia}" type="currency" currencySymbol="đ" />
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${not empty voucher}">
                        <div class="p-3 rounded border border-dashed bg-light d-flex align-items-center">
                            <div class="me-3 fs-3 text-danger">
                                <i class="bi bi-ticket-perforated"></i>
                            </div>
                            <div>
                                <div class="small fw-bold text-dark text-uppercase">Voucher đã áp dụng</div>
                                <div class="badge bg-danger">${voucher.ma_code}</div>
                                <div class="small text-muted">Giảm: <fmt:formatNumber value="${voucher.gia_tri_giam}" type="number"/> ${voucher.loai_giam == 'PHAN_TRAM' ? '%' : 'đ'}</div>
                            </div>
                        </div>
                    </c:if>
                </div>

                <div class="col-md-5 ps-md-4">
                    <h6 class="fw-bold mb-3 text-uppercase small text-secondary">Thông tin nhận hàng</h6>
                    
                    <div class="d-flex mb-2">
                        <i class="bi bi-person me-2 text-danger"></i>
                        <span class="fw-bold text-dark">${sessionScope.user.ten_day_du} (ID: #USR${sessionScope.user.id_nguoi_dung})</span>
                    </div>
                    <div class="d-flex mb-3">
                        <i class="bi bi-telephone me-2 text-danger"></i>
                        <span class="small text-muted">${order.sdt_nguoi_nhan}</span>
                    </div>
                    
                    <div class="d-flex mb-4">
                        <i class="bi bi-geo-alt me-2 text-danger"></i>
                        <div class="small text-muted">
                            <span class="fw-bold text-dark">Địa chỉ nhận hàng:</span><br>
                            ${order.dia_chi}
                        </div>
                    </div>

                    <div class="pt-3 border-top mt-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <span class="small text-muted italic text-uppercase" style="font-size: 0.7rem;">Ngày tạo đơn:</span>
                            <span class="small fw-bold text-dark">
                                <fmt:formatDate value="${order.ngay_dat}" pattern="dd/MM/yyyy HH:mm:ss" />
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
