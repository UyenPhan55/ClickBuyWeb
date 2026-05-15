<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Thêm sản phẩm"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} – CLICKBUY</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
    <style>
        .img-preview {
            width:120px; height:120px;
            object-fit:cover; border-radius:12px;
            border:2px dashed #d0d5dd; display:block;
        }
        .form-section-title {
            font-size:13px; font-weight:700;
            color:#888; text-transform:uppercase;
            letter-spacing:.5px; margin-bottom:14px;
            padding-bottom:8px; border-bottom:1px solid #f0f0f0;
        }
    </style>
</head>
<body>
<div class="layout-wrapper">

    <jsp:include page="/common/sidebar-admin.jsp"/>

    <div class="main-content">
        <jsp:include page="/common/topnav-admin.jsp"/>

        <div class="page-content">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i> ${error}
                </div>
            </c:if>

            <div class="card" style="max-width:780px;margin:auto">
                <div class="card-header d-flex align-items-center gap-2">
                    <a href="${pageContext.request.contextPath}/san-pham?action=list"
                       class="btn btn-sm btn-outline-secondary">
                        <i class="bi bi-arrow-left"></i>
                    </a>
                    <div class="card-title mb-0">
                        <i class="bi bi-plus-circle-fill"></i> Thêm sản phẩm mới
                    </div>
                </div>
                <div class="card-body" style="padding:24px">
                    <%--  Sửa: action trỏ vào SanPhamServlet --%>
                    <form action="${pageContext.request.contextPath}/SanPhamServlet"
                          method="post">
                        <input type="hidden" name="action" value="add">

                        <div class="form-section-title">Thông tin cơ bản</div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                Tên sản phẩm <span class="text-danger">*</span>
                            </label>
                            <input type="text" name="ten_san_pham" class="form-control"
                                   placeholder="VD: iPhone 15 Pro Max..." required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Nhà sản xuất</label>
                                <input type="text" name="nha_san_xuat" class="form-control"
                                       placeholder="VD: Apple, Samsung, Xiaomi...">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    Giá cơ bản (₫) <span class="text-danger">*</span>
                                </label>
                                <input type="number" name="gia_co_ban" class="form-control"
                                       placeholder="VD: 25000000" min="0" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mô tả sản phẩm</label>
                            <textarea name="mo_ta" class="form-control" rows="4"
                                      placeholder="Nhập mô tả chi tiết..."></textarea>
                        </div>

                        <div class="form-section-title mt-4">Hình ảnh & Trạng thái</div>
                        <div class="row align-items-start">
                            <div class="col-md-8 mb-3">
                                <label class="form-label fw-semibold">URL hình ảnh</label>
                                <input type="text" name="url_anh" id="urlAnh"
                                       class="form-control"
                                       placeholder="https://example.com/anh.jpg"
                                       oninput="previewImg(this.value)">
                                <div class="form-text">Dán đường link ảnh vào đây</div>
                            </div>
                            <div class="col-md-4 mb-3 text-center">
                                <label class="form-label fw-semibold d-block">Xem trước</label>
                                <img id="imgPreview"
                                     src="https://placehold.co/120x120?text=Ảnh"
                                     alt="preview" class="img-preview mx-auto">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                Trạng thái <span class="text-danger">*</span>
                            </label>
                            <%--  Sửa: value là int 1/0 --%>
                            <select name="trang_thai" class="form-select" required>
                                <option value="1" selected>Đang bán</option>
                                <option value="0">Tạm ngưng</option>
                            </select>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg"></i> Thêm vào hệ thống
                            </button>
                            <a href="${pageContext.request.contextPath}/san-pham?action=list"
                               class="btn btn-outline-secondary">
                                <i class="bi bi-x-lg"></i> Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function previewImg(url) {
        const img = document.getElementById('imgPreview');
        img.src = url.trim() ? url : 'https://placehold.co/120x120?text=Ảnh';
        img.onerror = () => img.src = 'https://placehold.co/120x120?text=Lỗi';
    }
</script>
</body>
</html>