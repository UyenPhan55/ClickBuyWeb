<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang hệ Jakarta --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông báo của tôi - ClickBuy</title>
    <jsp:include page="../common/header.jsp" />
    
    <style>
        .noti-card {
            border-radius: 12px;
            transition: 0.3s;
            border: 1px solid #eee;
            border-left: 5px solid #ccc; 
            background-color: #ffffff;
            text-decoration: none !important;
            display: block;
        }
        .noti-card:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        /* Style cho thông báo chưa đọc */
        .noti-unread {
            border-left-color: #d70018 !important;
            background-color: #fff5f6 !important;
            border: 1px solid #ffdadd;
        }
        .noti-read { opacity: 0.85; }
        .noti-icon {
            width: 48px; height: 48px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px;
        }
        .section-title {
            font-size: 14px;
            font-weight: bold;
            color: #888;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .back-link { text-decoration: none; color: #666; font-size: 14px; }
        .back-link:hover { color: #d70018; }
        
        /* Màu sắc động cho Badge & Icon */
        .bg-khuyen-mai { background-color: #ffc107 !important; color: #000; }
        .bg-don-hang { background-color: #0d6efd !important; color: #fff; }
        .bg-he-thong { background-color: #6c757d !important; color: #fff; }
    </style>
</head>
<body style="background-color: #f8f9fa;">

    <jsp:include page="../common/navbar-user.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                
                <div class="mb-4">
                    <a href="${pageContext.request.contextPath}/user/trang-chu.jsp" class="back-link">
                        <i class="bi bi-arrow-left"></i> Quay về trang chủ
                    </a>
                </div>

                <h4 class="fw-bold mb-5">THÔNG BÁO CỦA TÔI</h4>

                <c:choose>
                    <c:when test="${not empty notifications}">
                        <c:forEach var="n" items="${notifications}">
                            <%-- Thiết lập class và icon động dựa trên loại thông báo --%>
                            <c:set var="typeClass" value="${n.loai == 'KHUYEN_MAI' ? 'bg-khuyen-mai' : (n.loai == 'DON_HANG' ? 'bg-don-hang' : 'bg-he-thong')}" />
                            <c:set var="icon" value="${n.loai == 'KHUYEN_MAI' ? '🎁' : (n.loai == 'DON_HANG' ? '🚚' : '⚙️')}" />
                            <c:set var="typeName" value="${n.loai == 'KHUYEN_MAI' ? 'KHUYẾN MÃI' : (n.loai == 'DON_HANG' ? 'ĐƠN HÀNG' : 'HỆ THỐNG')}" />

                            <a href="${n.duong_dan}" class="card noti-card p-3 mb-3 ${n.da_doc == 0 ? 'noti-unread' : 'noti-read'}">
                                <div class="d-flex align-items-start">
                                    <div class="noti-icon ${typeClass} me-3 shadow-sm">${icon}</div>
                                    <div class="flex-grow-1">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="badge ${typeClass} small" style="font-size: 10px;">${typeName}</span>
                                            <span class="small text-muted">
                                                <fmt:formatDate value="${n.ngay_tao}" pattern="dd/MM HH:mm" />
                                            </span>
                                        </div>
                                        <h6 class="fw-bold mb-1 ${n.da_doc == 0 ? 'text-dark' : 'text-secondary'}">${n.tieu_de}</h6>
                                        <p class="small mb-0 text-secondary">${n.noi_dung}</p>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="bi bi-bell-slash fs-1 text-muted"></i>
                            <p class="text-muted mt-3">Bạn chưa có thông báo nào</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <c:if test="${not empty notifications}">
                    <div class="text-center mt-4">
                        <button class="btn btn-light btn-sm px-4 fw-bold border">Xem thông báo cũ hơn</button>
                    </div>
                </c:if>

            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>
