<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>${pageTitle}</title>
</head>
<body>
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">
            <i class="bi bi-folder-fill me-2 text-primary"></i>${pageTitle}
        </h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <!-- Hiển thị lỗi nếu có -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row justify-content-center mt-3">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-pencil-square me-2"></i>Thông Tin Chi Tiết Danh Mục
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/categories/save'/>" method="POST">
                        <!-- Trường ẩn ID khi chỉnh sửa -->
                        <input type="hidden" name="id" value="${category.id}"/>

                        <!-- Tên danh mục -->
                        <div class="mb-3">
                            <label for="categoryName" class="form-label fw-bold">
                                Tên Danh Mục <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" id="categoryName" name="categoryName" 
                                   value="<c:out value='${category.categoryName}'/>" 
                                   placeholder="Ví dụ: Điện thoại, Laptop, Thời trang..." required>
                            <div class="form-text">Tên danh mục là thông tin bắt buộc hiển thị trên hệ thống.</div>
                        </div>

                        <!-- Biểu tượng / Icon -->
                        <div class="mb-3">
                            <label for="icon" class="form-label fw-bold">Biểu Tượng (Bootstrap Icon Class)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i id="iconPreview" class="bi ${not empty category.icon ? category.icon : 'bi-tag'} fs-5"></i>
                                </span>
                                <input type="text" class="form-control" id="icon" name="icon" 
                                       value="<c:out value='${category.icon}'/>" 
                                       placeholder="Ví dụ: bi-laptop, bi-phone, bi-book, bi-bag"
                                       oninput="updateIconPreview(this.value)">
                            </div>
                            <div class="form-text">
                                Nhập mã class Bootstrap Icon. Bạn có thể tra cứu tại 
                                <a href="https://icons.getbootstrap.com/" target="_blank" class="text-decoration-none">Bootstrap Icons</a>.
                            </div>
                        </div>

                        <!-- Trạng thái -->
                        <div class="mb-4">
                            <label class="form-label fw-bold d-block">Trạng Thái Hoạt Động</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusActive" 
                                       value="true" ${category.status ? 'checked' : ''}>
                                <label class="form-check-label text-success fw-semibold" for="statusActive">
                                    <i class="bi bi-check-circle me-1"></i>Hoạt động
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status" id="statusLocked" 
                                       value="false" ${!category.status ? 'checked' : ''}>
                                <label class="form-check-label text-danger fw-semibold" for="statusLocked">
                                    <i class="bi bi-lock me-1"></i>Khóa (Ẩn)
                                </label>
                            </div>
                        </div>

                        <!-- Nút bấm hành động -->
                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary">
                                <i class="bi bi-x-circle me-1"></i> Hủy Bỏ
                            </a>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-save-fill me-1"></i> Lưu Thông Tin
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script cập nhật trực tiếp preview icon khi người dùng gõ -->
    <script>
        function updateIconPreview(iconName) {
            const preview = document.getElementById('iconPreview');
            if (iconName && iconName.trim() !== '') {
                preview.className = 'bi ' + iconName.trim() + ' fs-5 text-primary';
            } else {
                preview.className = 'bi bi-tag fs-5 text-muted';
            }
        }
    </script>
</body>
</html>
