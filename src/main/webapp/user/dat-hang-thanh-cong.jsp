<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Cập nhật URI sang hệ Jakarta --%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar-user.jsp" />

<main class="container my-5 text-center py-5">
    <div class="card border-0 shadow-sm p-5 mx-auto" style="max-width: 550px;">
  
        <i class="bi bi-bag-check-fill text-success" style="font-size: 5rem;"></i>
        
        <h2 class="fw-bold mt-3">CHÚC MỪNG BẠN!</h2>
        
        <p class="fs-5 text-muted">
            Đơn hàng <strong class="text-dark">#CB${newOrderId}</strong> của bạn đã được hệ thống ghi nhận.
        </p>
        
        <p class="small text-secondary mb-4">
            Cảm ơn bạn đã tin tưởng chọn <strong>ClickBuy</strong>. Nhân viên sẽ sớm liên hệ để xác nhận đơn hàng.
        </p>

        <hr class="my-4">

        <div class="d-grid gap-3 d-md-flex justify-content-center">
            <button class="btn btn-outline-secondary px-4 fw-bold" 
                    onclick="location.href='${pageContext.request.contextPath}/user/trang-chu.jsp'">
                TIẾP TỤC MUA SẮM
            </button>
            
            <button class="btn btn-danger px-4 fw-bold shadow-sm" 
                    onclick="location.href='${pageContext.request.contextPath}/OrderDetailServlet?id=${newOrderId}'">
                XEM CHI TIẾT ĐƠN HÀNG
            </button>
        </div>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />
