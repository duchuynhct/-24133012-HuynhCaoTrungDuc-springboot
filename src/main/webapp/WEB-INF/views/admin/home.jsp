<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Tổng Quan Hệ Thống</title>
</head>
<body>
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-2 pb-2 mb-4 border-bottom">
        <div>
            <h1 class="h2 fw-bold mb-0 text-dark">Bảng Điều Khiển Quản Trị</h1>
            <p class="text-muted small mb-0">Hệ thống Quản lý Category & User - Spring Boot, SiteMesh 3 & Bootstrap 5</p>
        </div>
        <div class="btn-toolbar mb-2 mb-md-0">
            <span class="badge bg-primary px-3 py-2 fs-6">
                <i class="bi bi-person-badge me-1"></i> MSSV: 24133012
            </span>
        </div>
    </div>

    <!-- Student & Course Info Banner -->
    <div class="card border-0 shadow-sm mb-4 bg-primary bg-gradient text-white rounded-3">
        <div class="card-body p-4">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h4 class="fw-bold mb-2">Bài tập Lập Trình Web - Spring Boot CRUD</h4>
                    <p class="mb-1 opacity-75">Sinh viên: <strong>Huỳnh Cao Trung Đức</strong> | MSSV: <strong>24133012</strong></p>
                    <p class="mb-0 opacity-75">Trường: <strong>Trường Đại học Công nghệ Kỹ thuật TP.HCM (HCM-UTE)</strong></p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <span class="badge bg-light text-primary px-3 py-2 fs-6 me-1">Tomcat 10.1</span>
                    <span class="badge bg-light text-primary px-3 py-2 fs-6">Java 25</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Stat Cards -->
    <div class="row g-4 mb-4">
        <!-- Categories Stat -->
        <div class="col-md-6 col-xl-6">
            <div class="card border-0 shadow-sm rounded-3 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div class="bg-info bg-opacity-10 text-info rounded-3 p-3">
                            <i class="bi bi-grid-3x3-gap-fill fs-3"></i>
                        </div>
                        <span class="badge bg-info bg-opacity-10 text-info px-2 py-1">Quản lý Category</span>
                    </div>
                    <h6 class="text-muted text-uppercase fw-semibold mb-1">Tổng Số Danh Mục</h6>
                    <h2 class="fw-bold mb-3 text-dark">${totalCategories}</h2>
                    <div class="d-flex gap-2">
                        <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-info btn-sm">
                            <i class="bi bi-list-ul me-1"></i>Xem danh sách
                        </a>
                        <a href="<c:url value='/admin/categories/add'/>" class="btn btn-info text-white btn-sm">
                            <i class="bi bi-plus-circle me-1"></i>Thêm danh mục
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Users Stat -->
        <div class="col-md-6 col-xl-6">
            <div class="card border-0 shadow-sm rounded-3 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div class="bg-success bg-opacity-10 text-success rounded-3 p-3">
                            <i class="bi bi-people-fill fs-3"></i>
                        </div>
                        <span class="badge bg-success bg-opacity-10 text-success px-2 py-1">Quản lý User</span>
                    </div>
                    <h6 class="text-muted text-uppercase fw-semibold mb-1">Tổng Số Tài Khoản</h6>
                    <h2 class="fw-bold mb-3 text-dark">${totalUsers}</h2>
                    <div class="d-flex gap-2">
                        <a href="<c:url value='/admin/users'/>" class="btn btn-outline-success btn-sm">
                            <i class="bi bi-list-ul me-1"></i>Xem danh sách
                        </a>
                        <a href="<c:url value='/admin/users/add'/>" class="btn btn-success btn-sm">
                            <i class="bi bi-person-plus me-1"></i>Thêm tài khoản
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Features Overview -->
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white py-3">
                    <h5 class="card-title fw-bold mb-0"><i class="bi bi-stars text-warning me-2"></i>Tính Năng Nổi Bật</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item px-0 d-flex align-items-center">
                            <i class="bi bi-check-circle-fill text-success me-2 fs-5"></i>
                            <div>
                                <strong>Master Layout SiteMesh 3:</strong> Tái sử dụng bố cục chuẩn, phân tách rõ ràng Navbar, Sidebar và Content.
                            </div>
                        </li>
                        <li class="list-group-item px-0 d-flex align-items-center">
                            <i class="bi bi-check-circle-fill text-success me-2 fs-5"></i>
                            <div>
                                <strong>Tìm kiếm & Phân trang:</strong> Tìm kiếm linh hoạt, giữ nguyên từ khóa và số dòng trên trang khi lật trang.
                            </div>
                        </li>
                        <li class="list-group-item px-0 d-flex align-items-center">
                            <i class="bi bi-check-circle-fill text-success me-2 fs-5"></i>
                            <div>
                                <strong>Live Preview trực quan:</strong> Xem trước icon Bootstrap và ảnh đại diện Avatar ngay lập tức trong form nhập liệu.
                            </div>
                        </li>
                        <li class="list-group-item px-0 d-flex align-items-center">
                            <i class="bi bi-check-circle-fill text-success me-2 fs-5"></i>
                            <div>
                                <strong>Validate dữ liệu & Bảo mật:</strong> Kiểm tra tính duy nhất của Username/Email, bảo lưu mật khẩu cũ khi cập nhật.
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white py-3">
                    <h5 class="card-title fw-bold mb-0"><i class="bi bi-cpu text-primary me-2"></i>Môi Trường & Cấu Hình</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered mb-0 align-middle">
                            <tbody>
                                <tr>
                                    <th class="bg-light" style="width: 40%;">Framework</th>
                                    <td>Spring Boot 4.1.1 (Spring MVC, Spring Data JPA)</td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Java Development Kit</th>
                                    <td>Oracle OpenJDK 25.0.2</td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Web Server</th>
                                    <td>Apache Tomcat 10.1.59 (Chuẩn Servlet 6 / Jakarta EE 10)</td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Cơ Sở Dữ Liệu</th>
                                    <td>Microsoft SQL Server (Database: <code>SpringBootAdminDB</code>)</td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Giao diện (UI)</th>
                                    <td>JSP, JSTL, SiteMesh 3.2.1, Bootstrap 5.3.3 & Bootstrap Icons</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>