<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="pageTitle" value="Lịch sử hoạt động"/>
<c:set var="breadcrumb" value="Hệ thống / Lịch sử"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">
    <%@ include file="/common/sidebar-admin.jsp" %>
    <div class="main-content">
        <%@ include file="/common/topnav-admin.jsp" %>
        <div class="page-content">
            <div class="card">
                <div class="card-header"><h5>Nhật ký hoạt động</h5></div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID Log</th>
                                <th>ID người dùng</th>
                                <th>Hành động</th>
                                <th>Bảng tác động</th>
                                <th>ID đối tượng</th>
                                <th>Địa chỉ IP</th>
                                <th>Thời gian</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Dữ liệu mẫu (xóa khi ghép Servlet) --%>
                            <tr>
                                <td>1</td>
                                <td>1</td>
                                <td><span class="badge badge-success">Thêm SP</span></td>
                                <td><code>san_pham</code></td>
                                <td>1</td>
                                <td>192.168.1.1</td>
                                <td>01/01/2025 09:00</td>
                            </tr>

                            <%-- Uncomment khi ghép Servlet
                            <c:choose>
                                <c:when test="${not empty listLog}">
                                    <c:forEach items="${listLog}" var="log">
                                    <tr>
                                        <td>${log.idLog}</td>
                                        <td>${log.idNguoiDung}</td>
                                        <td>${log.hanhDong}</td>
                                        <td><code>${log.bangTacDong}</code></td>
                                        <td>${log.idDoiTuong}</td>
                                        <td>${log.diaChiIp}</td>
                                        <td><fmt:formatDate value="${log.thoiGian}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="tbl-no-data">
                                            <i class="bi bi-inbox"></i> Chưa có log nào
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            --%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>