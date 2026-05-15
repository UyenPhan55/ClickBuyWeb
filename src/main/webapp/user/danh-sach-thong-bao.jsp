<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        .back-link { text-decoration: none; color: #666; font-size: 14px; }
        .back-link:hover { color: #d70018; }
        
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
                
                <div class="mb-4 d-flex justify-content-between align-items-center">
                    <a href="${pageContext.request.contextPath}/TrangChuServlet" class="back-link">
                        <i class="bi bi-arrow-left"></i> Quay về trang chủ
                    </a>
                    <c:if test="${soThongBaoChuaDoc > 0}">
                        <a href="${pageContext.request.contextPath}/ThongBaoServlet?action=readAll" class="small text-danger text-decoration-none fw-bold">
                            <i class="bi bi-check2-all"></i> Đánh dấu tất cả đã đọc
                        </a>
                    </c:if>
                </div>

                <h4 class="fw-bold mb-5">THÔNG BÁO CỦA TÔI (${not empty soThongBaoChuaDoc ? soThongBaoChuaDoc : 0})</h4>

                <c:choose>
                    <c:when test="${not empty danhSachThongBao}">
                        <c:forEach var="n" items="${danhSachThongBao}">
                            
                            <%-- LOGIC HIỂN THỊ DỰA TRÊN MODEL CỦA BÀ --%>
                            <c:set var="isUnread" value="${n.daDoc == 0}" />
                            <c:set var="typeClass" value="${n.loaiThongBao == 'KHUYEN_MAI' ? 'bg-khuyen-mai' : (n.loaiThongBao == 'DON_HANG' ? 'bg-don-hang' : 'bg-he-thong')}" />
                            <c:set var="icon" value="${n.loaiThongBao == 'KHUYEN_MAI' ? '🎁' : (n.loaiThongBao == 'DON_HANG' ? '🚚' : '⚙️')}" />
                            <c:set var="typeName" value="${n.loaiThongBao == 'KHUYEN_MAI' ? 'KHUYẾN MÃI' : (n.loaiThongBao == 'DON_HANG' ? 'ĐƠN HÀNG' : 'HỆ THỐNG')}" />

                            <a href="${pageContext.request.contextPath}/ThongBaoServlet?action=read&id=${n.idThongBao}" 
                               class="card noti-card p-3 mb-3 ${isUnread ? 'noti-unread' : 'noti-read'}">
                                <div class="d-flex align-items-start">
                                    <div class="noti-icon ${typeClass} me-3 shadow-sm">${icon}</div>
                                    <div class="flex-grow-1">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="badge ${typeClass} small" style="font-size: 10px;">${typeName}</span>
                                            <span class="small text-muted">
                                                <fmt:formatDate value="${n.ngayTao}" pattern="dd/MM HH:mm" />
                                            </span>
                                        </div>
                                        <h6 class="fw-bold mb-1 ${isUnread ? 'text-dark' : 'text-secondary'}">${n.tieuDe}</h6>
                                        <p class="small mb-0 text-secondary">${n.noiDung}</p>
                                    </div>
                                    <c:if test="${isUnread}">
                                        <span class="p-1 bg-danger border border-light rounded-circle mt-2" style="width: 10px; height: 10px;"></span>
                                    </c:if>
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

            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>
