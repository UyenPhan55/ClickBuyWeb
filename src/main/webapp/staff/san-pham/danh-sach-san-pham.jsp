<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"
         language="java" %>

<%--
    Khai báo JSTL Core:
    dùng cho c:if, c:choose, c:when, c:otherwise, c:forEach.
--%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%--
    Khai báo JSTL Format:
    dùng fmt:formatNumber để định dạng giá tiền.
--%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<%--
    Khai báo JSTL Functions.
    Hiện file chưa dùng nhiều, nhưng vẫn giữ vì có thể dùng trong layout/sidebar.
--%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%--
    Hai biến mô tả trang hiện tại.
    Có thể được sidebar hoặc layout dùng để làm nổi bật menu tương ứng.
--%>
<c:set var="pageTitle" value="Danh sách sản phẩm"/>
<c:set var="breadcrumb" value="Sản phẩm / Danh sách"/>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">

    <%-- Giúp giao diện co giãn đúng trên điện thoại và máy tính bảng --%>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Danh sách sản phẩm – CLICKBUY</title>

    <%-- Bootstrap dùng cho button, form, alert và một số class tiện ích --%>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <%-- Bootstrap Icons dùng cho các biểu tượng kính lúp, hộp, bút sửa... --%>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <%-- CSS riêng của giao diện nhân viên --%>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/staff.css">
</head>

<body>

<%--
    layout-wrapper là khung lớn nhất của trang:
    - bên trái là sidebar
    - bên phải là main-content
--%>
<div class="layout-wrapper">

    <%--
        Dùng jsp:include thay cho include tĩnh.

        jsp:include sẽ gọi sidebar tại thời điểm request chạy,
        phù hợp khi sidebar cần đọc session hoặc dữ liệu động.
    --%>
    <jsp:include page="/common/sidebar-staff.jsp"/>

    <%-- Toàn bộ phần nội dung bên phải sidebar --%>
    <div class="main-content">

        <%-- ================= TOP NAVIGATION ================= --%>
        <div class="topnav">

            <%-- Phía trái topnav: tiêu đề và breadcrumb --%>
            <div class="topnav-left">
                <div>

                    <div class="page-title">
                        Danh sách sản phẩm
                    </div>

                    <div class="breadcrumb">

                        <%--
                            Sau khi kiểm tra StaffServlet:
                            Servlet tự forward đến /staff/dashboard.jsp,
                            vì vậy link không cần action=dashboard.
                        --%>
                        <a href="${pageContext.request.contextPath}/StaffServlet">
                            Trang chủ
                        </a>

                        <span>/</span>
                        <span>Sản phẩm</span>
                        <span>/</span>
                        <span>Danh sách</span>

                    </div>
                </div>
            </div>

            <%-- Phía phải topnav: thông tin nhân viên hiện tại --%>
            <div class="topnav-right">

                <div class="topnav-user">

                    <%--
                        Nếu session có user:
                        lấy ký tự đầu trong tên đầy đủ làm avatar.

                        Nếu session chưa có user:
                        hiển thị chữ N đại diện cho "Nhân viên".
                    --%>
                    <div class="avatar">
                        <c:choose>

                            <c:when test="${not empty sessionScope.user}">
                                ${sessionScope.user.tenDayDu.charAt(0)}
                            </c:when>

                            <c:otherwise>
                                N
                            </c:otherwise>

                        </c:choose>
                    </div>

                    <%--
                        Hiển thị tên người dùng đang đăng nhập.
                        Nếu user rỗng thì dùng tên mặc định "Nhân viên".
                    --%>
                    <span class="uname">
                        ${not empty sessionScope.user
                            ? sessionScope.user.tenDayDu
                            : 'Nhân viên'}
                    </span>

                </div>
            </div>

        </div>
        <%-- =============== KẾT THÚC TOPNAV =============== --%>


        <%-- ================= NỘI DUNG TRANG ================= --%>
        <div class="page-content">

            <%--
                message do Servlet truyền sang khi thao tác thành công.

                Ví dụ:
                request.setAttribute("message", "Cập nhật thành công");
            --%>
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill"></i>
                    ${message}
                </div>
            </c:if>

            <%--
                error do Servlet truyền sang khi có lỗi.

                Ví dụ:
                request.setAttribute("error", "Không thể tải dữ liệu");
            --%>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i>
                    ${error}
                </div>
            </c:if>


            <%--
                Chỉ giữ một card duy nhất.

                Bản conflict trước có hai card và hai form tìm kiếm bị lặp.
                Phần trùng đã được loại bỏ.
            --%>
            <div class="card">

                <%-- ================ HEADER CỦA CARD ================ --%>
                <div class="card-header">

                    <div class="card-title">
                        <i class="bi bi-box-seam-fill"></i>
                        Sản phẩm
                    </div>

                    <%--
                        Form tìm kiếm gửi request GET đến SanPhamServlet.

                        URL mapping đã được xác định là:
                        /san-pham

                        Không dùng:
                        /SanPhamServlet
                    --%>
                    <form method="get"
                          action="${pageContext.request.contextPath}/san-pham"
                          style="display:flex;
                                 gap:8px;
                                 align-items:center;
                                 flex-wrap:wrap">

                        <%--
                            SanPhamServlet dùng case "list"
                            để hiển thị danh sách cho staff/admin.

                            Vì vậy giữ value="list",
                            không dùng value="danhSach".
                        --%>
                        <input type="hidden"
                               name="action"
                               value="list">

                        <%-- Ô nhập từ khóa tìm kiếm --%>
                        <div class="search-wrap">

                            <i class="bi bi-search"></i>

                            <input type="text"
                                   name="keyword"
                                   class="form-control"
                                   placeholder="Tìm tên sản phẩm..."
                                   value="${param.keyword}">
                        </div>

                        <%-- Nút gửi form tìm kiếm --%>
                        <button type="submit"
                                class="btn btn-primary btn-sm">

                            <i class="bi bi-funnel"></i>
                            Lọc
                        </button>

                    </form>
                </div>
                <%-- ============== KẾT THÚC CARD HEADER ============== --%>


                <%-- ================= BẢNG SẢN PHẨM ================= --%>
                <div class="card-body p-0">

                    <%--
                        tbl-wrap giúp bảng cuộn ngang khi màn hình nhỏ.
                        Đây là class của staff.css.
                    --%>
                    <div class="tbl-wrap">

                        <%--
                            Giữ class tbl từ bản giao diện staff mới,
                            thay vì dùng table Bootstrap của bản cũ.
                    --%>
                        <table class="tbl">

                            <thead>
                                <tr>
                                    <th style="width:44px">#</th>
                                    <th style="width:56px">Ảnh</th>
                                    <th>Tên sản phẩm</th>

                                    <%--
                                        Dữ liệu thực tế dùng sp.nhaSanXuat,
                                        vì vậy tiêu đề phải là Nhà sản xuất,
                                        không ghi "Danh mục".
                                    --%>
                                    <th>Nhà sản xuất</th>

                                    <%--
                                        Dữ liệu dùng sp.giaCoBan,
                                        nên ghi "Giá cơ bản", không ghi "Giá bán".
                                    --%>
                                    <th>Giá bán </th>

                                    <th>Tồn kho</th>
                                    <th>Trạng thái</th>
                                    <th style="width:130px">Thao tác</th>
                                </tr>
                            </thead>

                            <tbody>

                                <%--
                                    Nếu listSanPham có dữ liệu:
                                    lặp qua từng sản phẩm.

                                    Nếu listSanPham rỗng:
                                    hiện dòng "Không tìm thấy sản phẩm nào".
                                --%>
                                <c:choose>

                                    <%-- Trường hợp có sản phẩm --%>
                                    <c:when test="${not empty listSanPham}">

                                        <c:forEach var="sp"
                                                   items="${listSanPham}"
                                                   varStatus="st">

                                            <tr>

                                                <%--
                                                    st.index bắt đầu từ 0.
                                                    Cộng 1 để số thứ tự bắt đầu từ 1.
                                                --%>
                                                <td class="text-muted">
                                                    ${st.index + 1}
                                                </td>

                                                <%-- Ảnh sản phẩm --%>
                                                <td>

                                                    <%--
                                                        Dùng sp.urlAnh vì Model Java thường có getter:

                                                        getUrlAnh()

                                                        Trong JSP EL:
                                                        getUrlAnh() tương ứng với sp.urlAnh.

                                                        Không dùng sp.url_anh vì đó giống tên cột SQL,
                                                        không phải property Java.
                                                    --%>
                                                    <img
                                                        src="${not empty sp.urlAnh
                                                            ? pageContext.request.contextPath
                                                                .concat('/uploads/san-pham/')
                                                                .concat(sp.urlAnh)
                                                            : pageContext.request.contextPath
                                                                .concat('/assets/img/no-image.png')}"

                                                        class="tbl-img"

                                                        alt="${sp.tenSanPham}"

                                                        <%--
                                                            Nếu ảnh thật bị lỗi hoặc không tồn tại,
                                                            JavaScript sẽ chuyển sang ảnh mặc định.
                                                        --%>
                                                        onerror="this.src='${pageContext.request.contextPath}/assets/img/no-image.png'">
                                                </td>

                                                <%-- Tên và mã sản phẩm --%>
                                                <td>

                                                    <div style="font-weight:600">
                                                        ${sp.tenSanPham}
                                                    </div>

                                                    <%--
                                                        Dùng idSanPham vì property trong Model là idSanPham.
                                                        Không dùng maSanPham nếu Model không có getter tương ứng.
                                                    --%>
                                                    <div style="font-size:11.5px;
                                                                color:var(--text-muted)">
                                                        Mã: ${sp.idSanPham}
                                                    </div>

                                                </td>

                                                <%-- Nhà sản xuất: Apple, Samsung, Xiaomi... --%>
                                                <td>
                                                    ${sp.nhaSanXuat}
                                                </td>

                                                <%--
                                                    fmt:formatNumber dùng để định dạng giá.

                                                    Ví dụ:
                                                    15000000 → 15,000,000₫
                                                --%>
                                                <td style="font-weight:700;
                                                           white-space:nowrap">

                                                    <fmt:formatNumber
                                                        value="${sp.giaCoBan}"
                                                        pattern="#,###"/>₫
                                                </td>

                                                <%--
                                                    Tồn kho là số lượng sản phẩm còn lại.

                                                    Quy tắc màu:
                                                    - bằng 0: màu đỏ
                                                    - từ 1 đến 5: màu cảnh báo
                                                    - lớn hơn 5: màu xanh

                                                    Lưu ý:
                                                    soLuongTon khác với trangThai.
                                                    Một sản phẩm có thể đang bán nhưng tồn kho bằng 0.
                                                --%>
                                                <td>
                                                    <span class="badge
                                                        ${sp.soLuongTon == 0
                                                            ? 'badge-danger'
                                                            : (sp.soLuongTon <= 5
                                                                ? 'badge-warning'
                                                                : 'badge-success')}">

                                                        ${sp.soLuongTon}
                                                    </span>
                                                </td>

                                                <%--
                                                    trangThai là trạng thái kinh doanh sản phẩm.

                                                    1 = đang bán
                                                    giá trị khác 1 = tạm ngưng
                                                --%>
                                                <td>
                                                    <c:choose>

                                                        <c:when test="${sp.trangThai == 1}">
                                                            <span class="badge badge-success">
                                                                Đang bán
                                                            </span>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <span class="badge badge-neutral">
                                                                Tạm ngưng
                                                            </span>
                                                        </c:otherwise>

                                                    </c:choose>
                                                </td>

                                                <%--
                                                    Vì đây là trang staff,
                                                    giữ hai thao tác thuộc nghiệp vụ nhân viên:

                                                    1. Cập nhật tồn kho
                                                    2. Quản lý biến thể

                                                    Không giữ nút sửa/xóa sản phẩm của bản admin.
                                                --%>
                                                <td>
                                                    <div style="display:flex;
                                                                gap:5px">

                                                        <%-- Mở trang cập nhật tồn kho --%>
                                                        <a href="${pageContext.request.contextPath}/san-pham?action=capNhatTonKho&id=${sp.idSanPham}"
                                                           class="btn btn-outline btn-sm btn-icon"
                                                           title="Cập nhật tồn kho">

                                                            <i class="bi bi-pencil-square"></i>
                                                        </a>

                                                        <%--
                                                            Mở trang quản lý biến thể:
                                                            màu sắc, dung lượng, giá biến thể...
                                                        --%>
                                                        <a href="${pageContext.request.contextPath}/san-pham?action=quanLyBienThe&id=${sp.idSanPham}"
                                                           class="btn btn-outline btn-sm btn-icon"
                                                           title="Quản lý biến thể">

                                                            <i class="bi bi-diagram-3"></i>
                                                        </a>

                                                    </div>
                                                </td>

                                            </tr>

                                        </c:forEach>
                                    </c:when>

                                    <%-- Trường hợp danh sách sản phẩm rỗng --%>
                                    <c:otherwise>

                                        <tr>
                                            <%--
                                                Bảng có 8 cột,
                                                nên colspan phải bằng 8.
                                            --%>
                                            <td colspan="8"
                                                class="tbl-no-data">

                                                <i class="bi bi-inbox"></i>
                                                Không tìm thấy sản phẩm nào
                                            </td>
                                        </tr>

                                    </c:otherwise>

                                </c:choose>

                            </tbody>
                        </table>

                    </div>
                    <%-- Kết thúc tbl-wrap --%>

                </div>
                <%-- Kết thúc card-body --%>

            </div>
            <%-- Kết thúc card --%>

        </div>
        <%-- Kết thúc page-content --%>

    </div>
    <%-- Kết thúc main-content --%>

</div>
<%-- Kết thúc layout-wrapper --%>

<%-- JavaScript của Bootstrap --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>