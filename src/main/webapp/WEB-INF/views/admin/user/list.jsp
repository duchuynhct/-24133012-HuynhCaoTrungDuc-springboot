<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Quản Lý Người Dùng</title>
</head>
<body>
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2"><i class="bi bi-people-fill me-2 text-primary"></i>Quản Lý Người Dùng (User)</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="<c:url value='/admin/users/add'/>" class="btn btn-primary shadow-sm">
                <i class="bi bi-person-plus-fill me-1"></i> Thêm Mới Người Dùng
            </a>
        </div>
    </div>

    <!-- Thông báo kết quả thao tác -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Thanh tìm kiếm & bộ lọc -->
    <div class="card shadow-sm mb-4 border-0">
        <div class="card-body">
            <form action="<c:url value='/admin/users'/>" method="GET" class="row g-3 align-items-center">
                <div class="col-md-6 col-lg-5">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" name="keyword" class="form-control" 
                               placeholder="Tìm theo tên đăng nhập hoặc họ tên..."
                               value="<c:out value='${keyword}'/>">
                    </div>
                </div>
                <div class="col-md-3 col-lg-2">
                    <select name="size" class="form-select" onchange="this.form.submit()">
                        <option value="5" ${pageSize == 5 ? 'selected' : ''}>5 dòng/trang</option>
                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10 dòng/trang</option>
                        <option value="20" ${pageSize == 20 ? 'selected' : ''}>20 dòng/trang</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-dark">
                        <i class="bi bi-funnel-fill me-1"></i> Tìm kiếm
                    </button>
                    <c:if test="${not empty keyword}">
                        <a href="<c:url value='/admin/users'/>" class="btn btn-outline-secondary ms-1">
                            <i class="bi bi-arrow-counterclockwise"></i> Đặt lại
                        </a>
                    </c:if>
                </div>
            </form>
        </div>
    </div>

    <!-- Bảng dữ liệu User -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col" class="text-center" style="width: 50px;">#</th>
                            <th scope="col" style="width: 80px;">
                                <a href="<c:url value='/admin/users?keyword=${keyword}&page=${currentPage}&size=${pageSize}&sortField=id&sortDir=${reverseSortDir}'/>" 
                                   class="text-white text-decoration-none">
                                    ID <i class="bi bi-arrow-down-up small"></i>
                                </a>
                            </th>
                            <th scope="col" class="text-center" style="width: 80px;">Ảnh</th>
                            <th scope="col">
                                <a href="<c:url value='/admin/users?keyword=${keyword}&page=${currentPage}&size=${pageSize}&sortField=username&sortDir=${reverseSortDir}'/>" 
                                   class="text-white text-decoration-none">
                                    Tên Đăng Nhập <i class="bi bi-arrow-down-up small"></i>
                                </a>
                            </th>
                            <th scope="col">
                                <a href="<c:url value='/admin/users?keyword=${keyword}&page=${currentPage}&size=${pageSize}&sortField=fullName&sortDir=${reverseSortDir}'/>" 
                                   class="text-white text-decoration-none">
                                    Họ Và Tên <i class="bi bi-arrow-down-up small"></i>
                                </a>
                            </th>
                            <th scope="col">Email</th>
                            <th scope="col">Số Điện Thoại</th>
                            <th scope="col" class="text-center" style="width: 120px;">Vai Trò</th>
                            <th scope="col" class="text-center" style="width: 130px;">Trạng Thái</th>
                            <th scope="col" class="text-center" style="width: 150px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty userPage.content}">
                                <c:forEach items="${userPage.content}" var="u" varStatus="loop">
                                    <tr>
                                        <td class="text-center text-muted fw-bold">
                                            ${(currentPage - 1) * pageSize + loop.index + 1}
                                        </td>
                                        <td class="fw-bold">${u.id}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${not empty u.avatar}">
                                                    <img src="${u.avatar}" alt="avatar" class="rounded-circle shadow-sm"
                                                         style="width: 40px; height: 40px; object-fit: cover;"
                                                         onerror="this.src='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/icons/person-circle.svg';">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-person-circle fs-3 text-secondary"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-primary">${u.username}</span>
                                        </td>
                                        <td>
                                            <span class="fw-semibold text-dark">${u.fullName}</span>
                                        </td>
                                        <td>${u.email}</td>
                                        <td>${not empty u.phone ? u.phone : '<span class="text-muted fst-italic">Chưa có</span>'}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${u.role eq 'ROLE_ADMIN' or u.role eq 'ADMIN'}">
                                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1">
                                                        <i class="bi bi-shield-lock-fill me-1"></i>ADMIN
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1">
                                                        <i class="bi bi-person-fill me-1"></i>USER
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${u.status}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                                                        <i class="bi bi-check-circle me-1"></i>Hoạt động
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1">
                                                        <i class="bi bi-lock-fill me-1"></i>Đã khóa
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="btn-group btn-group-sm" role="group">
                                                <a href="<c:url value='/admin/users/edit/${u.id}'/>" 
                                                   class="btn btn-outline-primary" title="Chỉnh sửa">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </a>
                                                <a href="<c:url value='/admin/users/delete/${u.id}'/>" 
                                                   class="btn btn-outline-danger" title="Xóa"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng [${u.username}] không?');">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                        Không tìm thấy người dùng nào phù hợp!
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Phân trang (Pagination) -->
        <c:if test="${totalPages > 0}">
            <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
                <div class="small text-muted">
                    Hiển thị từ <b>${(currentPage - 1) * pageSize + 1}</b> đến 
                    <b>${currentPage * pageSize > totalElements ? totalElements : currentPage * pageSize}</b> 
                    trong tổng số <b>${totalElements}</b> người dùng
                </div>
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination pagination-sm mb-0">
                            <!-- Nút Trang trước -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" 
                                   href="<c:url value='/admin/users?keyword=${keyword}&page=${currentPage - 1}&size=${pageSize}&sortField=${sortField}&sortDir=${sortDir}'/>">
                                    <i class="bi bi-chevron-left"></i> Trước
                                </a>
                            </li>

                            <!-- Danh sách số trang -->
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" 
                                       href="<c:url value='/admin/users?keyword=${keyword}&page=${i}&size=${pageSize}&sortField=${sortField}&sortDir=${sortDir}'/>">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            <!-- Nút Trang sau -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" 
                                   href="<c:url value='/admin/users?keyword=${keyword}&page=${currentPage + 1}&size=${pageSize}&sortField=${sortField}&sortDir=${sortDir}'/>">
                                    Sau <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </c:if>
    </div>
</body>
</html>
