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
    <style>
        .sidebar .nav-link {
            color: #495057;
            padding: 0.65rem 1rem;
            border-radius: 0.5rem;
            transition: all 0.15s ease-in-out;
        }
        .sidebar .nav-link:hover {
            color: #0d6efd;
            background-color: #f0f4f9;
        }
        .sidebar .nav-link.active {
            color: #fff !important;
            background-color: #0d6efd !important;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body class="bg-light">
    <!-- Header Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="<c:url value='/admin/home'/>">
                <i class="bi bi-shield-lock-fill me-2 text-primary"></i>Admin Dashboard
            </a>
            <div class="d-flex align-items-center text-white">
                <i class="bi bi-person-circle fs-5 me-2"></i>
                <span>Xin chào, <strong>Admin</strong></span>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-white sidebar shadow-sm min-vh-100 p-3">
                <div class="text-uppercase text-muted fw-bold small mb-2 px-3">Danh Mục Quản Trị</div>
                <ul class="nav flex-column gap-1">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="<c:url value='/admin/home'/>">
                            <i class="bi bi-house-door me-2"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="<c:url value='/admin/categories'/>">
                            <i class="bi bi-grid me-2"></i>Quản lý Category
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="<c:url value='/admin/users'/>">
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
    <script>
        // Tự động kích hoạt menu tương ứng với trang hiện tại
        const currentPath = window.location.pathname;
        document.querySelectorAll('.sidebar .nav-link').forEach(link => {
            const href = link.getAttribute('href');
            if (href) {
                if (href.endsWith('/admin/home') && (currentPath.endsWith('/admin/home') || currentPath.endsWith('/admin') || currentPath.endsWith('/admin/'))) {
                    link.classList.add('active');
                } else if (!href.endsWith('/admin/home') && currentPath.includes(href)) {
                    link.classList.add('active');
                }
            }
        });
    </script>
</body>
</html>