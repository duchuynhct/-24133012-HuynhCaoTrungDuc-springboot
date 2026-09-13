<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>${pageTitle}</title>
</head>
<body>
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">
            <i class="bi bi-person-bounding-box me-2 text-primary"></i>${pageTitle}
        </h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="<c:url value='/admin/users'/>" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <!-- Hiển thị lỗi nếu có -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row justify-content-center mt-3">
        <div class="col-lg-9">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-person-gear me-2"></i>Thông Tin Tài Khoản Người Dùng
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/users/save'/>" method="POST">
                        <input type="hidden" name="id" value="${user.id}"/>

                        <div class="row g-3">
                            <!-- Tên đăng nhập (Username) -->
                            <div class="col-md-6">
                                <label for="username" class="form-label fw-bold">
                                    Tên Đăng Nhập <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="username" name="username"
                                       value="<c:out value='${user.username}'/>"
                                       placeholder="Ví dụ: nguyenvana"
                                       ${not empty user.id ? 'readonly style="background-color: #f8f9fa;"' : 'required'}>
                                <c:if test="${not empty user.id}">
                                    <div class="form-text text-muted">Tên đăng nhập không thể thay đổi sau khi tạo.</div>
                                </c:if>
                            </div>

                            <!-- Mật khẩu (Password) -->
                            <div class="col-md-6">
                                <label for="password" class="form-label fw-bold">
                                    Mật Khẩu <c:if test="${empty user.id}"><span class="text-danger">*</span></c:if>
                                </label>
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="${empty user.id ? 'Nhập mật khẩu...' : 'Để trống nếu không muốn đổi mật khẩu'}"
                                       ${empty user.id ? 'required' : ''}>
                                <c:if test="${not empty user.id}">
                                    <div class="form-text text-muted">Chỉ nhập nếu bạn muốn cập nhật mật khẩu mới.</div>
                                </c:if>
                            </div>

                            <!-- Họ và tên -->
                            <div class="col-md-6">
                                <label for="fullName" class="form-label fw-bold">Họ Và Tên</label>
                                <input type="text" class="form-control" id="fullName" name="fullName"
                                       value="<c:out value='${user.fullName}'/>"
                                       placeholder="Ví dụ: Nguyễn Văn A">
                            </div>

                            <!-- Email -->
                            <div class="col-md-6">
                                <label for="email" class="form-label fw-bold">
                                    Địa Chỉ Email <span class="text-danger">*</span>
                                </label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="<c:out value='${user.email}'/>"
                                       placeholder="name@example.com" required>
                            </div>

                            <!-- Số điện thoại -->
                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-bold">Số Điện Thoại</label>
                                <input type="text" class="form-control" id="phone" name="phone"
                                       value="<c:out value='${user.phone}'/>"
                                       placeholder="Ví dụ: 0912345678">
                            </div>

                            <!-- Vai trò (Role) -->
                            <div class="col-md-6">
                                <label for="role" class="form-label fw-bold">Vai Trò (Phân Quyền)</label>
                                <select class="form-select" id="role" name="role">
                                    <option value="ROLE_USER" ${user.role eq 'ROLE_USER' ? 'selected' : ''}>
                                        USER - Người dùng thông thường
                                    </option>
                                    <option value="ROLE_ADMIN" ${user.role eq 'ROLE_ADMIN' ? 'selected' : ''}>
                                        ADMIN - Quản trị viên hệ thống
                                    </option>
                                </select>
                            </div>

                            <!-- Ảnh đại diện Avatar (URL) -->
                            <div class="col-12">
                                <label for="avatar" class="form-label fw-bold">Ảnh Đại Diện (URL Hình Ảnh)</label>
                                <div class="d-flex align-items-center gap-3">
                                    <img id="avatarPreview" 
                                         src="${not empty user.avatar ? user.avatar : 'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/icons/person-circle.svg'}" 
                                         alt="Preview" class="rounded-circle shadow-sm border"
                                         style="width: 55px; height: 55px; object-fit: cover;"
                                         onerror="this.src='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/icons/person-circle.svg';">
                                    <input type="text" class="form-control" id="avatar" name="avatar"
                                           value="<c:out value='${user.avatar}'/>"
                                           placeholder="Dán link ảnh trực tiếp (https://.../avatar.jpg)"
                                           oninput="updateAvatarPreview(this.value)">
                                </div>
                                <div class="form-text">Bạn có thể dán đường dẫn ảnh trực tuyến để xem trước ngay lập tức.</div>
                            </div>

                            <!-- Trạng thái -->
                            <div class="col-12 mt-3">
                                <label class="form-label fw-bold d-block">Trạng Thái Hoạt Động</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="status" id="statusActive"
                                           value="true" ${user.status ? 'checked' : ''}>
                                    <label class="form-check-label text-success fw-semibold" for="statusActive">
                                        <i class="bi bi-check-circle me-1"></i>Hoạt động
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="status" id="statusLocked"
                                           value="false" ${!user.status ? 'checked' : ''}>
                                    <label class="form-check-label text-danger fw-semibold" for="statusLocked">
                                        <i class="bi bi-lock me-1"></i>Khóa tài khoản
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Nút bấm hành động -->
                        <div class="d-flex justify-content-end gap-2 border-top pt-4 mt-4">
                            <a href="<c:url value='/admin/users'/>" class="btn btn-secondary">
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

    <!-- Script live preview avatar -->
    <script>
        function updateAvatarPreview(url) {
            const preview = document.getElementById('avatarPreview');
            if (url && url.trim() !== '') {
                preview.src = url.trim();
            } else {
                preview.src = 'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/icons/person-circle.svg';
            }
        }
    </script>
</body>
</html>
