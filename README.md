# BÀI TẬP LẬP TRÌNH WEB - SPRING BOOT ADMIN CRUD
**TRƯỜNG ĐẠI HỌC CÔNG NGHỆ KỸ THUẬT TP.HCM (HCM-UTE)**  
**KHOA CÔNG NGHỆ THÔNG TIN - BỘ MÔN CÔNG NGHỆ PHẦN MỀM**

---

## 📌 THÔNG TIN SINH VIÊN & BÀI TẬP
* **Họ và tên sinh viên:** Huỳnh Cao Trung Đức
* **Mã số sinh viên (MSSV):** 24133012
* **Trường:** Trường Đại học Công nghệ Kỹ thuật TP.HCM (HCM-UTE)
* **Môn học:** Lập Trình Web
* **Đề tài:** Xây Dựng Ứng Dụng Quản Trị (Admin CRUD) Danh Mục (Category) và Người Dùng (User) với Spring Boot, JSP/JSTL, SiteMesh 3 Decorator và Bootstrap 5.
* **Repository GitHub:** [https://github.com/duchuynhct/-24133012-HuynhCaoTrungDuc-springboot](https://github.com/duchuynhct/-24133012-HuynhCaoTrungDuc-springboot)

---

## 🚀 CÔNG NGHỆ SỬ DỤNG (TECH STACK)

| Thành Phần | Công Nghệ / Thư Viện | Phiên Bản | Ghi Chú |
| :--- | :--- | :--- | :--- |
| **Ngôn ngữ** | Java Development Kit (JDK) | **25.0.2** | Oracle OpenJDK 25 |
| **Framework** | Spring Boot | **4.1.1** | Spring MVC, Spring Data JPA |
| **Web Server** | Apache Tomcat | **10.1.59** | Chuẩn Jakarta EE 10 / Servlet 6.0 |
| **View Engine** | JSP & JSTL | Jakarta Tags Core 3.0.0 | Phân tách hiển thị và logic |
| **Decorator** | SiteMesh 3 | **3.2.1** | Master Layout cho toàn bộ trang Admin |
| **Database** | Microsoft SQL Server | 2019 / 2022 | `mssql-jdbc` Driver 13.4 |
| **Frontend UI** | Bootstrap & Bootstrap Icons | **5.3.3 / 1.11.3** | Giao diện hiện đại, chuẩn Responsive |
| **Build Tool** | Apache Maven | 3.9+ | Quản lý phụ thuộc & đóng gói WAR |
| **Quy trình Git** | Git Flow & Pull Requests | - | Phân chia feature branch & PR từng giai đoạn |

---

## 🏛️ KIẾN TRÚC HỆ THỐNG (LAYERED ARCHITECTURE)

Dự án tuân thủ nghiêm ngặt mô hình kiến trúc đa tầng (Layered Architecture):

```
vn.trungduc.springboot_admin_crud
├── config                  # Cấu hình hệ thống (SiteMesh 3 Filter, WebMvc ViewResolver)
│   ├── SiteMeshFilterConfig.java
│   └── WebMvcConfig.java
├── controller              # Tầng tiếp nhận HTTP Request & điều hướng View
│   ├── AdminHomeController.java
│   ├── CategoryController.java
│   └── UserController.java
├── entity                  # Tầng Thực thể (JPA Entity ánh xạ SQL Server)
│   ├── Category.java
│   └── User.java
├── repository              # Tầng Truy cập Dữ liệu (Spring Data JPA Repositories)
│   ├── CategoryRepository.java
│   └── UserRepository.java
├── service                 # Tầng Nghiệp vụ (Interfaces & Business Implementation)
│   ├── ICategoryService.java
│   ├── IUserService.java
│   └── impl
│       ├── CategoryServiceImpl.java
│       └── UserServiceImpl.java
└── SpringbootAdminCrudApplication.java  # Lớp khởi chạy ứng dụng chính (SpringBootServletInitializer)
```

**Thư mục Giao diện Web (`src/main/webapp`):**
```
webapp
└── WEB-INF
    ├── decorators          # Layout dùng chung cho SiteMesh 3
    │   └── admin.jsp       # Master Decorator (Navbar, Sidebar, Footer, Body Injection)
    └── views
        └── admin
            ├── home.jsp    # Trang Tổng quan Bảng điều khiển (Dashboard)
            ├── category
            │   ├── form.jsp # Form Thêm mới / Chỉnh sửa Category (Live Icon Preview)
            │   └── list.jsp # Danh sách Category (Tìm kiếm, Sắp xếp, Phân trang)
            └── user
                ├── form.jsp # Form Thêm mới / Chỉnh sửa User (Live Avatar Preview)
                └── list.jsp # Danh sách User (Tìm kiếm đa trường, Phân quyền, Phân trang)
```

---

## 🌟 CÁC TÍNH NĂNG NỔI BẬT

### 1. Bảng Điều Khiển Quản Trị (Dashboard - `/admin/home`)
* Thống kê trực quan số lượng Category và User đang có trong cơ sở dữ liệu theo thời gian thực.
* Thẻ liên kết nhanh (Quick Actions) điều hướng tức thì tới màn hình Thêm mới và Danh sách.
* Tự động nhận diện và làm nổi bật (active menu) trên thanh Sidebar.

### 2. Quản Lý Danh Mục (Category Management - `/admin/categories`)
* **CRUD Đầy Đủ:** Xem danh sách, thêm danh mục mới, chỉnh sửa thông tin, xóa an toàn với hộp thoại xác nhận JavaScript.
* **Tìm kiếm thông minh:** Tìm kiếm danh mục theo tên không phân biệt chữ hoa hay chữ thường (`IgnoreCase`).
* **Phân trang & Sắp xếp linh hoạt:** Lựa chọn kích thước trang tùy ý (5, 10, 20 dòng/trang), bảo lưu từ khóa tìm kiếm khi chuyển trang.
* **Live Icon Preview:** Khi người dùng nhập tên class biểu tượng Bootstrap (ví dụ: `bi-laptop`, `bi-phone`, `bi-camera`), biểu tượng sẽ hiển thị xem trước tức thì ngay trong ô nhập liệu.

### 3. Quản Lý Tài Khoản (User Management - `/admin/users`)
* **CRUD Đầy Đủ:** Thêm tài khoản mới, cập nhật hồ sơ, xóa tài khoản người dùng kèm hộp thoại xác nhận.
* **Tìm kiếm đa trường (Multi-field Search):** Nhập 1 từ khóa duy nhất để quét đồng thời qua cả 3 trường: `username`, `fullName`, và `email`.
* **Validate trùng lặp nghiệp vụ:** Kiểm tra và ngăn chặn ngay lập tức nếu tên đăng nhập (`username`) hoặc thư điện tử (`email`) đã tồn tại trong CSDL.
* **Bảo lưu mật khẩu an toàn:** Khi chỉnh sửa tài khoản, nếu để trống trường mật khẩu, hệ thống tự động giữ nguyên mật khẩu cũ trong CSDL.
* **Phân quyền & Trạng thái:** Lựa chọn vai trò Quản trị viên (`ROLE_ADMIN`) / Người dùng (`ROLE_USER`), trạng thái Hoạt động / Khóa có huy hiệu (Badge) màu trực quan.
* **Tải lên & Live Avatar Preview:** Hỗ trợ tải trực tiếp ảnh đại diện từ máy tính cá nhân (JPG, PNG, GIF, WEBP) với tính năng xem trước tức thì (Client-side Instant Preview qua FileReader). Tự động bảo lưu ảnh cũ khi sửa hồ sơ nếu không chọn ảnh mới.

---

## 🛠️ HƯỚNG DẪN CÀI ĐẶT & CHẠY DỰ ÁN

### 1. Chuẩn bị Cơ Sở Dữ Liệu (Microsoft SQL Server)
1. Mở **SQL Server Management Studio (SSMS)** hoặc **Azure Data Studio**.
2. Kết nối tới SQL Server của bạn và thực thi đoạn script SQL sau để tạo CSDL và chèn dữ liệu mẫu kiểm thử:

```sql
-- 1. Tạo Database
CREATE DATABASE SpringBootAdminDB;
GO

USE SpringBootAdminDB;
GO

-- 2. Tạo bảng Category (Nếu chạy Hibernate ddl-auto=update thì bảng sẽ tự sinh)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='categories' and xtype='U')
BEGIN
    CREATE TABLE categories (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        category_name NVARCHAR(255) NOT NULL,
        icon VARCHAR(100),
        status INT NOT NULL DEFAULT 1
    );
END
GO

-- 3. Tạo bảng User
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='users' and xtype='U')
BEGIN
    CREATE TABLE users (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        full_name NVARCHAR(100) NOT NULL,
        phone VARCHAR(20),
        avatar VARCHAR(255),
        role VARCHAR(20) NOT NULL DEFAULT 'ROLE_USER',
        status INT NOT NULL DEFAULT 1
    );
END
GO

-- 4. Chèn dữ liệu mẫu kiểm thử (Sample Data)
INSERT INTO categories (category_name, icon, status) VALUES
(N'Điện Thoại & Phụ Kiện', 'bi-phone', 1),
(N'Máy Tính & Laptop', 'bi-laptop', 1),
(N'Máy Ảnh & Quay Phim', 'bi-camera', 1),
(N'Đồng Hồ Thông Minh', 'bi-smartwatch', 1),
(N'Thiết Bị Âm Thanh', 'bi-headphones', 1),
(N'Thời Trang Nam', 'bi-bag', 1),
(N'Thiết Bị Gia Dụng', 'bi-tv', 0);
GO

INSERT INTO users (username, password, email, full_name, phone, avatar, role, status) VALUES
('admin', '123456', 'admin@hcmute.edu.vn', N'Huỳnh Cao Trung Đức', '0901234567', 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150', 'ROLE_ADMIN', 1),
('user01', '123456', 'nguyenvana@gmail.com', N'Nguyễn Văn A', '0912345678', 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150', 'ROLE_USER', 1),
('user02', '123456', 'tranthib@gmail.com', N'Trần Thị B', '0987654321', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150', 'ROLE_USER', 1),
('user03', '123456', 'lequangc@gmail.com', N'Lê Quang C', '0933445566', '', 'ROLE_USER', 0);
GO
```

### 2. Cấu Hình Ứng Dụng (`application.properties`)
Mở file `src/main/resources/application.properties` và điều chỉnh tài khoản SQL Server nếu cần:

```properties
spring.application.name=springboot-admin-crud
server.port=8080

# Định tuyến đường dẫn JSP
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

# Cấu hình kết nối SQL Server
spring.datasource.url=jdbc:sqlserver://localhost:1433;databaseName=SpringBootAdminDB;encrypt=true;trustServerCertificate=true;
spring.datasource.username=sa
spring.datasource.password=123456
spring.datasource.driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver

# Hibernate tự động cập nhật bảng trong DB khi chạy
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
```

### 3. Cách 1: Chạy Trực Tiếp Bằng Embedded Tomcat (VS Code / Terminal)
1. Mở Terminal tại thư mục gốc của dự án.
2. Thực thi lệnh chạy:
   ```bash
   mvn spring-boot:run
   ```
3. Truy cập vào trình duyệt web:  
   👉 **[http://localhost:8080/admin/home](http://localhost:8080/admin/home)** (hoặc [http://localhost:8080](http://localhost:8080))

### 4. Cách 2: Đóng Gói và Triển Khai Lên Apache Tomcat 10 Độc Lập
1. Biên dịch và đóng gói ứng dụng:
   ```bash
   mvn clean package -DskipTests
   ```
   *(File đóng gói được tạo tại `target/springboot-admin-crud-0.0.1-SNAPSHOT.war`)*
2. Sao chép nội dung thư mục giải nén `target/springboot-admin-crud-0.0.1-SNAPSHOT/*` vào thư mục `webapps/ROOT` của Apache Tomcat 10:
   * Đường dẫn Tomcat: `C:\Program Files\Apache\apache-tomcat-10.1.59\webapps\ROOT\`
3. Khởi động Tomcat Service hoặc chạy `bin\startup.bat`.
4. Mở trình duyệt và truy cập: **`http://localhost:8080/admin/home`**.

---

## 📋 DANH SÁCH ENDPOINTS CỦA HỆ THỐNG

| Method | Endpoint URL | Chức Năng | Giao Diện Hiển Thị |
| :---: | :--- | :--- | :--- |
| `GET` | `/` hoặc `/admin` | Tự động chuyển hướng về Trang chủ | Redirect `/admin/home` |
| `GET` | `/admin/home` | Bảng điều khiển (Dashboard thống kê) | `admin/home.jsp` |
| `GET` | `/admin/categories` | Danh sách danh mục (Tìm kiếm, Phân trang) | `admin/category/list.jsp` |
| `GET` | `/admin/categories/add` | Màn hình Form thêm mới danh mục | `admin/category/form.jsp` |
| `POST` | `/admin/categories/save` | Tiếp nhận và lưu thông tin danh mục | Redirect `/admin/categories` |
| `GET` | `/admin/categories/edit/{id}` | Nạp dữ liệu và mở form sửa danh mục | `admin/category/form.jsp` |
| `GET` | `/admin/categories/delete/{id}` | Xóa danh mục theo ID | Redirect `/admin/categories` |
| `GET` | `/admin/users` | Danh sách người dùng (Tìm kiếm, Phân trang) | `admin/user/list.jsp` |
| `GET` | `/admin/users/add` | Màn hình Form tạo tài khoản người dùng | `admin/user/form.jsp` |
| `POST` | `/admin/users/save` | Tiếp nhận lưu tài khoản (Validate & Encrypt) | Redirect `/admin/users` |
| `GET` | `/admin/users/edit/{id}` | Nạp thông tin tài khoản để chỉnh sửa | `admin/user/form.jsp` |
| `GET` | `/admin/users/delete/{id}` | Xóa tài khoản người dùng theo ID | Redirect `/admin/users` |

---

## 💡 BÀI HỌC KỸ THUẬT & GIẢI QUYẾT LỖI (TROUBLESHOOTING)

### 1. Tại Sao Sử Dụng Apache Tomcat 10 Thay Vì Tomcat 11?
* **Hiện tượng:** Khi chạy trên Apache Tomcat 11 kết hợp với bộ lọc SiteMesh 3, trình duyệt trả về **trang trắng hoàn toàn** với HTTP Status `200 OK` nhưng `Content-Length: 0`.
* **Nguyên nhân cốt lõi:** Apache Tomcat 11 áp dụng nghiêm ngặt đặc tả Jakarta Servlet 6.1, trong đó cơ chế `RequestDispatcher.forward()` sẽ tự động gọi `commitResponse()` và flush buffer ngay khi kết thúc forward. Do đó, khi servlet forward đến file JSP, luồng response bị đóng lại trước khi `SiteMeshFilter` có cơ hội thu nạp nội dung của JSP để áp decorator layout vào.
* **Giải pháp chuẩn hóa theo hướng dẫn của giảng viên:**
  1. Sử dụng **Apache Tomcat 10.1.x** (chuẩn Servlet 6.0 / Jakarta EE 10), nơi cơ chế buffer response tương thích hoàn toàn với kiến trúc của SiteMesh 3.
  2. Bổ sung cấu hình `viewResolver.setAlwaysInclude(true)` trong [`WebMvcConfig.java`](file:///d:/HCMUTE/LT_Web/-24133012-HuynhCaoTrungDuc-springboot/src/main/java/vn/trungduc/springboot_admin_crud/config/WebMvcConfig.java) để ép buộc chuyển tiếp dùng cơ chế `include()` thay vì `forward()`, ngăn chặn tình trạng response bị đóng sớm.

### 2. Xử Lý Phạm Vi Phụ Thuộc `tomcat-embed-jasper` Trong VS Code
* Thư viện `org.apache.tomcat.embed:tomcat-embed-jasper` không được đặt scope là `<scope>provided</scope>` trong môi trường lập trình Spring Boot trên VS Code / Eclipse, vì sẽ khiến IDE loại bỏ Jasper khỏi runtime classpath, dẫn đến lỗi không thể biên dịch các trang `.jsp`. Để `compile` scope đảm bảo ứng dụng chạy mượt mà ở cả chế độ nhúng và chế độ war độc lập.

---

## 🌳 LỊCH SỬ PHÁT TRIỂN & QUY TRÌNH GIT FLOW

Dự án được xây dựng tuần tự qua 6 giai đoạn phát triển, áp dụng phân nhánh Git (`feature/...`) và mở Pull Request bài bản:

| Giai Đoạn | Tên Nhánh (Branch) | Nội Dung Công Việc Chính | Trạng Thái PR |
| :---: | :--- | :--- | :---: |
| **GĐ 1** | `main` | Khởi tạo cấu hình Maven, Spring Boot 4.1.1, Java 25, JSP/JSTL, SQL Server | ✅ Đã cấu hình |
| **GĐ 2** | `main` | Tích hợp Master Layout SiteMesh 3, Bootstrap 5, Bootstrap Icons & ViewResolver | ✅ Đã cấu hình |
| **GĐ 3** | `feature/domain-model` | Xây dựng Entity `Category`, `User` và các Repository kế thừa JPA, tự sinh bảng DB | ✅ Merged PR #1 |
| **GĐ 4** | `feature/category-crud` | Xây dựng đầy đủ Service, Controller, View CRUD, Tìm kiếm, Phân trang cho Category | ✅ Merged PR #2 |
| **GĐ 5** | `feature/user-crud` | Xây dựng CRUD, Tìm kiếm đa trường, Phân trang, Check trùng lặp, Live Avatar cho User | ✅ Merged PR #3 |
| **GĐ 6** | `feature/polish-and-docs` | Tinh chỉnh Dashboard thống kê, menu active, đồng bộ Tomcat 10 và hoàn thiện README | 🚀 Đang gửi PR |

---
*Bản quyền bài tập © 2026 - Huỳnh Cao Trung Đức (MSSV: 24133012) - HCM-UTE.*