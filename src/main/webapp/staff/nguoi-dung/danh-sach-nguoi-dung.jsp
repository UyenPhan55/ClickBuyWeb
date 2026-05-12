<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Người dùng – CLICKBUY</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>
<body>
<div class="layout-wrapper">

    <jsp:include page="/common/sidebar-staff.jsp"/>

    <div class="main-content">
        <jsp:include page="/common/topnav-staff.jsp"/>

        <div class="page-content">
            <div class="alert alert-info">
                <i class="bi bi-info-circle-fill"></i>
                Nhân viên chỉ có quyền <strong>xem thông tin</strong> người dùng.
                Phân quyền và khóa tài khoản do <strong>Admin</strong> thực hiện.
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-people-fill"></i> Người dùng
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>SĐT</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty danhSachNguoiDung}">
                                    <c:forEach var="nd" items="${danhSachNguoiDung}" varStatus="st">
                                        <tr>
                                            <td class="text-muted">${st.index + 1}</td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div style="width:36px;height:36px;border-radius:50%;
                                                                background:#d70018;display:flex;
                                                                align-items:center;justify-content:center;
                                                                color:#fff;font-weight:700;font-size:13px;">
                                                        <%--  Sửa: tenDayDu thay hoTen --%>
                                                        ${nd.tenDayDu.charAt(0)}
                                                    </div>
                                                    <div class="fw-bold">${nd.tenDayDu}</div>
                                                </div>
                                            </td>
                                            <td style="font-size:13px">${nd.email}</td>
                                            <%--  Sửa: sdt thay soDienThoai --%>
                                            <td style="font-size:13px">${nd.sdt}</td>
                                            <%--  Sửa: idVaiTro là int --%>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${nd.idVaiTro == 1}">
                                                        <span class="badge bg-danger">Admin</span>
                                                    </c:when>
                                                    <c:when test="${nd.idVaiTro == 2}">
                                                        <span class="badge bg-warning text-dark">
                                                            Nhân viên
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Khách hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <%--  Sửa: trangThai là int 1/0 --%>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${nd.trangThai == 1}">
                                                        <span class="badge bg-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Bị khóa</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center py-4 text-muted">
                                            <i class="bi bi-people fs-4"></i>
                                            <div>Không có người dùng nào</div>
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