<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Tổng quan hệ thống"/>
<c:set var="breadcrumb" value="Trang chủ / Dashboard"/>

<%@ include file="/common/header-admin.jsp" %>

<div class="page-content">
    <c:if test="${not empty message}">
        <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill"></i> ${error}</div>
    </c:if>

    <%-- Stat cards --%>
    <div class="row g-3 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="stat-card">
                <div class="stat-icon ic-blue"><i class="bi bi-box-seam-fill"></i></div>
                <div>
                    <div class="stat-val">${tongSanPham != null ? tongSanPham : 0}</div>
                    <div class="stat-lbl">Tổng sản phẩm</div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>