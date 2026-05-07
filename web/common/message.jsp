<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />

<div class="container my-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm p-5" style="border-radius: 15px;">
                
                <div class="mb-4">
                   
                    <c:choose>
                        <c:when test="${status == 'error'}">
                            <i class="bi bi-x-circle-fill text-danger" style="font-size: 80px;"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-check-circle-fill text-success" style="font-size: 80px;"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
             
                <h2 class="fw-bold mb-3" style="font-family: 'Segoe UI', sans-serif;">
                    ${title != null ? title : "Thông báo"}
                </h2>
                
                <p class="text-secondary mb-4">
                    ${message != null ? message : "Thao tác đã được hệ thống ghi nhận thành công."}
                </p>

                <div class="d-grid gap-2 d-md-block">
                   
                    <a href="${url != null ? url : pageContext.request.contextPath + '/user/trang-chu.jsp'}" 
                       class="btn btn-danger px-5 fw-bold shadow-sm">
                        TIẾP TỤC
                    </a>
                </div>

                <c:if test="${status == 'error' && not empty errorLog}">
                    <div class="mt-4 p-3 bg-light text-start small border-start border-danger border-3">
                        <strong class="text-danger font-monospace">SQL Error Log:</strong>
                        <div class="text-muted mt-1">${errorLog}</div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />