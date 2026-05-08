<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Danh sách khiếu nại"/>
<c:set var="breadcrumb" value="Khiếu nại"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">
    <%@ include file="/common/sidebar-staff.jsp" %>
    <div class="main-content">
        <%@ include file="/common/topnav-staff.jsp" %>
        <div class="page-content">
            <div class="card">
                <div class="card-header"><div class="card-title"><i class="bi bi-exclamation-triangle"></i> Danh sách khiếu nại</div></div>
                <div class="card-body p0">
                    <table class="tbl">
                        <thead><tr><th>ID</th><th>Người gửi</th><th>Nội dung</th><th>Trạng thái</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>#KN001</td>
                                <td>User A</td>
                                <td>Sản phẩm bị lỗi màn hình</td>
                                <td><span class="badge badge-danger">Chưa xử lý</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>