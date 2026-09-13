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
                                    <div class="position-relative">
                                        <img id="avatarPreview" 
                                             src="${avatarImgSrc}" 
                                             alt="Preview" class="rounded-circle shadow-sm border border-2 border-primary"
                                             style="width: 75px; height: 75px; object-fit: cover; background-color: #f8f9fa;"
                                             onerror="this.onerror=null; this.src='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/icons/person-circle.svg';">
                                    </div>
                                    <div class="flex-grow-1">
                                        <input type="file" class="form-control" id="avatarFile" name="avatarFile"
                                               accept="image/*"
                                               onchange="previewImage(this);">
                                        <div id="previewStatus" class="mt-1"></div>
                                        <div class="form-text">
                                            Chọn file ảnh từ máy tính (JPG, PNG, GIF, WEBP, BMP). Ảnh sẽ hiển thị xem trước tức thì ngay bên cạnh.
                                            <c:if test="${not empty user.avatar}">
                                                <span class="text-primary fw-semibold d-block mt-1">
                                                    <i class="bi bi-info-circle me-1"></i>Tài khoản đã có ảnh đại diện. Bỏ trống ô này nếu muốn giữ nguyên ảnh hiện tại.
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
            if (!input.files || !input.files[0]) {
                return;
            }
            const file = input.files[0];
            const fileName = file.name.toLowerCase();
            const validExts = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', '.jfif', '.svg'];
            const isValidExt = validExts.some(ext => fileName.endsWith(ext));
            const isValidMime = file.type && file.type.startsWith('image/');

            if (!isValidExt && !isValidMime) {
                alert('Vui lòng chọn một file hình ảnh hợp lệ (JPG, PNG, GIF, WEBP, BMP)!');
                input.value = '';
                return;
            }

            const preview = document.getElementById('avatarPreview');
            const previewStatus = document.getElementById('previewStatus');

            if (preview) {
                preview.onerror = null;

                // 1. Thử URL.createObjectURL trước để xem trước tức thì
                if (window.URL && window.URL.createObjectURL) {
                    try {
                        preview.src = URL.createObjectURL(file);
                    } catch (e) {
                        console.error('URL.createObjectURL error:', e);
                    }
                }

                // 2. Dự phòng FileReader
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }

            if (previewStatus) {
                const sizeKb = (file.size / 1024).toFixed(1);
                previewStatus.innerHTML = '<span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1"><i class="bi bi-check-circle-fill me-1"></i>Đã chọn ảnh: ' + file.name + ' (' + sizeKb + ' KB)</span>';
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const avatarInput = document.getElementById('avatarFile');
            if (avatarInput) {
                avatarInput.addEventListener('change', function() {
                    previewImage(this);
                });
            }
        });
    </script>
</body>
</html>
