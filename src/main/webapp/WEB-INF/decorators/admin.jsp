<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Admin Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <sitemesh:write property='head'/>
</head>
<body class="bg-light">
    <!-- Header Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="<c:url value='/admin/home'/>">
                <i class="bi bi-shield-lock-fill me-2"></i>Admin Dashboard
            </a>
            <div class="d-flex align-items-center text-white">
                <i class="bi bi-person-circle fs-5 me-2"></i>
                <span>Xin chào, Admin</span>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-white sidebar shadow-sm min-vh-100 p-3">
                <ul class="nav flex-column gap-1">
                    <li class="nav-item">
                        <a class="nav-link text-dark fw-semibold" href="<c:url value='/admin/home'/>">
                            <i class="bi bi-house-door me-2"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark fw-semibold" href="<c:url value='/admin/categories'/>">
                            <i class="bi bi-grid me-2"></i>Quản lý Category
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark fw-semibold" href="<c:url value='/admin/users'/>">
                            <i class="bi bi-people me-2"></i>Quản lý User
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content Area: Chèn nội dung trang con vào đây -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <sitemesh:write property='body'/>
            </main>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>