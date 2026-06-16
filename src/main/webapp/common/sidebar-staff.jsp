<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<div class="sidebar">
    <div class="sidebar-brand">
        <a href="${pageContext.request.contextPath}/StaffServlet">
            CLICKBUY Staff
        </a>
    </div>
    <ul class="sidebar-menu">

        <%-- DASHBOARD --%>
        <li>
            <a href="${pageContext.request.contextPath}/StaffServlet"
               class="${empty param.action ? 'active' : ''}">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>

        <%-- SẢN PHẨM — trỏ vào SanPhamServlet --%>
        <li>
            <a href="${pageContext.request.contextPath}/san-pham?action=list"
               class="${param.action=='list' ? 'active' : ''}">
                <i class="bi bi-phone"></i> Sản phẩm
            </a>
        </li>

        <%-- ĐƠN HÀNG — trỏ vào DonHangServlet --%>
        <li>
    <a href="${pageContext.request.contextPath}/DonHangServlet?action=staff-list"
       class="${(param.action == 'staff-list' || requestScope.activeAction == 'staff-list') ? 'active' : ''}">
        <i class="bi bi-cart3"></i> Đơn hàng
    </a>
        </li>

        <%-- NGƯỜI DÙNG — trỏ vào NguoiDungServlet --%>
        <li>
            <a href="${pageContext.request.contextPath}/NguoiDungServlet">
                <i class="bi bi-people"></i> Người dùng
            </a>
        </li>

        <%-- MÃ GIẢM GIÁ — trỏ vào MaGiamGiaServlet --%>
        <li>
            <a href="${pageContext.request.contextPath}/MaGiamGiaServlet?action=list">
                <i class="bi bi-tag"></i> Mã giảm giá
            </a>
        </li>

        <%-- BẢO HÀNH — trỏ vào BaoHanhServlet --%>
        <li>
            <a href="${pageContext.request.contextPath}/BaoHanhServlet?action=list">
                <i class="bi bi-shield-check"></i> Bảo hành
            </a>
        </li>

        <%-- KHIẾU NẠI — trỏ vào KhieuNaiServlet --%>
        <li>
            <a href="${pageContext.request.contextPath}/KhieuNaiServlet?action=staff-list">
                <i class="bi bi-exclamation-triangle"></i> Khiếu nại
            </a>
        </li>

        <%-- ĐĂNG XUẤT --%>
        <li>
            <a href="${pageContext.request.contextPath}/AuthServlet?action=logout">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
        </li>

    </ul>
</div>