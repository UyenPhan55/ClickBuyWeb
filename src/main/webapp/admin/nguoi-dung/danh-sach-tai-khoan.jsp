<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%--  Thêm check role ở đầu trang  --%>
<c:if test="${empty sessionScope.user || sessionScope.user.idVaiTro != 1}">
    <c:redirect url="${pageContext.request.contextPath}/AuthServlet?action=logout"/>
</c:if>
<c:set var="pageTitle" value="Quản lý tài khoản"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} – CLICKBUY</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">

    <jsp:include page="/common/sidebar-admin.jsp"/>

    <div class="main-content">
        <jsp:include page="/common/topnav-admin.jsp"/>

        <div class="page-content">
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill"></i> ${message}
                </div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <h5><i class="bi bi-people-fill"></i> Danh sách tài khoản</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>SĐT</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty userList}">
                                    <c:forEach items="${userList}" var="u">
                                        <tr>
                                            <td>#${u.idNguoiDung}</td>
                                            <td>${u.tenDayDu}</td>
                                            <td>${u.email}</td>
                                            <td>${u.sdt}</td>
                                            <%--  Sửa: idVaiTro là int, không có tenVaiTro --%>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.idVaiTro == 1}">
                                                        <span class="badge bg-danger">Admin</span>
                                                    </c:when>
                                                    <c:when test="${u.idVaiTro == 2}">
                                                        <span class="badge bg-warning text-dark">
                                                            Nhân viên
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">
                                                            Khách hàng
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>

                                                    <c:when test="${u.trangThai == 1}">
                                                        <form action="${pageContext.request.contextPath}/NguoiDungServlet"
                                                              method="post"
                                                              style="display:inline"
                                                              onsubmit="return confirm('Khóa tài khoản ${u.tenDayDu}?')">

                                                            <input type="hidden" name="action" value="lock">
                                                            <input type="hidden" name="id" value="${u.idNguoiDung}">

                                                            <button type="submit"
                                                                    class="btn btn-sm btn-outline-danger">

                                                                <i class="bi bi-lock-fill"></i> Khóa
                                                            </button>
                                                        </form>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <form action="${pageContext.request.contextPath}/NguoiDungServlet"
                                                              method="post"
                                                              style="display:inline">

                                                            <input type="hidden" name="action" value="unlock">
                                                            <input type="hidden" name="id" value="${u.idNguoiDung}">

                                                            <button type="submit"
                                                                    class="btn btn-sm btn-outline-success">

                                                                <i class="bi bi-unlock-fill"></i> Mở khóa
                                                            </button>
                                                        </form>
                                                    </c:otherwise>

                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center py-4 text-muted">
                                            <i class="bi bi-inbox fs-4"></i>
                                            <div>Chưa có tài khoản nào</div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>