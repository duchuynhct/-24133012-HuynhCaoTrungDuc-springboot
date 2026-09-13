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
                    <form action="<c:url value='/admin/users/save'/>" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${user.id}"/>
                        <input type="hidden" name="avatar" value="${user.avatar}"/>

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

                            <!-- Ảnh đại diện Avatar (Upload File) -->
                            <div class="col-12">
                                <label for="avatarFile" class="form-label fw-bold">Ảnh Đại Diện (Tải Lên Từ Máy Tính)</label>
                                <div class="d-flex align-items-center gap-3">
                                    <c:choose>
                                        <c:when test="${not empty user.avatar}">
                                            <c:choose>
                                                <c:when test="${user.avatar.startsWith('http://') or user.avatar.startsWith('https://')}">
                                                    <c:set var="avatarImgSrc" value="${user.avatar}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url var="avatarImgSrc" value="${user.avatar}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="avatarImgSrc" value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/icons/person-circle.svg" />
                                        </c:otherwise>
                                    </c:choose>
                                    <img id="avatarPreview" 
                                         src="${avatarImgSrc}" 
                                         alt="Preview" class="rounded-circle shadow-sm border"
                                         style="width: 60px; height: 60px; object-fit: cover;"
                                         onerror="this.src='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/icons/person-circle.svg';">
                                    <div class="flex-grow-1">
                                        <input type="file" class="form-control" id="avatarFile" name="avatarFile"
                                               accept="image/png, image/jpeg, image/jpg, image/gif, image/webp"
                                               onchange="previewImage(this);">
                                        <div class="form-text">
                                            Chọn file ảnh từ máy tính (JPG, PNG, GIF, WEBP). Ảnh sẽ được xem trước tức thì ngay bên cạnh.
                                            <c:if test="${not empty user.avatar}">
                                                <span class="text-primary fw-semibold d-block mt-1">
                                                    <i class="bi bi-info-circle me-1"></i>Tài khoản đã có ảnh. Bỏ trống ô này nếu muốn giữ nguyên ảnh hiện tại.
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
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

    <!-- Script live preview avatar khi chọn file từ máy -->
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const file = input.files[0];
                if (!file.type.startsWith('image/')) {
                    alert('Vui lòng chọn đúng định dạng file hình ảnh (JPG, PNG, GIF, WEBP)!');
                    input.value = '';
                    return;
                }
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('avatarPreview').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>
