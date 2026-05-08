<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<div class="sidebar">
    <div class="sidebar-brand">
        <a href="${pageContext.request.contextPath}/StaffServlet?action=dashboard">CLICKBUY Staff</a>
    </div>
    
    <ul class="sidebar-menu">
        <li>
            <a href="${pageContext.request.contextPath}/StaffServlet?action=dashboard">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/DonHangServlet?action=danhSach">
                <i class="bi bi-cart3"></i> Đơn hàng
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=danhSach">
                <i class="bi bi-tag"></i> Mã giảm giá
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/BaoHanhServlet?action=danhSach">
                <i class="bi bi-shield-check"></i> Bảo hành
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/KhieuNaiServlet?action=danhSach">
                <i class="bi bi-exclamation-triangle"></i> Khiếu nại
            </a>
        </li>
    </ul>
</div>