package vn.trungduc.springboot_admin_crud.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.trungduc.springboot_admin_crud.entity.User;
import vn.trungduc.springboot_admin_crud.service.IUserService;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.nio.file.StandardOpenOption;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Controller
@RequestMapping("/admin/users")
@RequiredArgsConstructor
public class UserController {

    private final IUserService userService;

    @Value("${app.upload.dir:uploads}")
    private String uploadDir;

    @GetMapping
    public String listUsers(
            @RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size", defaultValue = "5") int size,
            @RequestParam(name = "sortField", defaultValue = "id") String sortField,
            @RequestParam(name = "sortDir", defaultValue = "desc") String sortDir,
            Model model) {

        Sort sort = sortDir.equalsIgnoreCase("asc")
                ? Sort.by(sortField).ascending()
                : Sort.by(sortField).descending();

        Pageable pageable = PageRequest.of(Math.max(0, page - 1), size, sort);
        Page<User> userPage = userService.search(keyword, pageable);

        model.addAttribute("userPage", userPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("totalElements", userPage.getTotalElements());
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("reverseSortDir", sortDir.equalsIgnoreCase("asc") ? "desc" : "asc");

        return "admin/user/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        User user = new User();
        user.setStatus(true);
        user.setRole("ROLE_USER");
        model.addAttribute("user", user);
        model.addAttribute("pageTitle", "Thêm Mới Người Dùng");
        return "admin/user/form";
    }

    @PostMapping("/save")
    public String saveUser(
            @ModelAttribute("user") User user,
            @RequestParam(name = "avatarFile", required = false) MultipartFile avatarFile,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        // 1. Xử lý upload ảnh đại diện nếu người dùng chọn file
        if (avatarFile != null && !avatarFile.isEmpty()) {
            try {
                String originalFilename = StringUtils.cleanPath(
                        avatarFile.getOriginalFilename() != null ? avatarFile.getOriginalFilename() : "avatar.jpg"
                );
                String ext = "";
                int dotIndex = originalFilename.lastIndexOf(".");
                if (dotIndex >= 0) {
                    ext = originalFilename.substring(dotIndex).toLowerCase();
                } else {
                    ext = ".jpg";
                }

                // Kiểm tra định dạng ảnh hợp lệ
                List<String> allowedExts = List.of(".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".jfif", ".svg");
                if (!allowedExts.contains(ext)) {
                    redirectAttributes.addFlashAttribute("errorMessage", "Chỉ chấp nhận các định dạng file hình ảnh (JPG, PNG, GIF, WEBP, BMP)!");
                    return user.getId() == null ? "redirect:/admin/users/add" : "redirect:/admin/users/edit/" + user.getId();
                }

                String newFileName = "user_" + System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
                byte[] fileBytes = avatarFile.getBytes();

                // Danh sách các thư mục cần lưu để đảm bảo ảnh luôn hiển thị ở mọi môi trường
                List<Path> targetDirs = new java.util.ArrayList<>();
                targetDirs.add(Paths.get(uploadDir, "users").toAbsolutePath());
                targetDirs.add(Paths.get("uploads", "users").toAbsolutePath());

                try {
                    String realPath = request.getServletContext().getRealPath("/uploads/users");
                    if (realPath != null) {
                        targetDirs.add(Paths.get(realPath).toAbsolutePath());
                    }
                } catch (Exception ignored) {
                }

                try {
                    Path devWebappPath = Paths.get("src/main/webapp/uploads/users").toAbsolutePath();
                    targetDirs.add(devWebappPath);
                } catch (Exception ignored) {
                }

                for (Path dir : targetDirs) {
                    try {
                        if (!Files.exists(dir)) {
                            Files.createDirectories(dir);
                        }
                        Path targetFile = dir.resolve(newFileName);
                        Files.write(targetFile, fileBytes, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
                    } catch (Exception ignored) {
                    }
                }

                // Gán đường dẫn URL cho avatar
                user.setAvatar("/uploads/users/" + newFileName);

            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi lưu ảnh đại diện: " + e.getMessage());
                return user.getId() == null ? "redirect:/admin/users/add" : "redirect:/admin/users/edit/" + user.getId();
            }
        }

        // 2. Thêm mới người dùng
        if (user.getId() == null) {
            if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Tên đăng nhập không được để trống!");
                return "redirect:/admin/users/add";
            }
            if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Mật khẩu không được để trống!");
                return "redirect:/admin/users/add";
            }
            if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Email không được để trống!");
                return "redirect:/admin/users/add";
            }
            if (userService.existsByUsername(user.getUsername().trim())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Tên đăng nhập [" + user.getUsername() + "] đã tồn tại!");
                return "redirect:/admin/users/add";
            }
            if (userService.existsByEmail(user.getEmail().trim())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Email [" + user.getEmail() + "] đã được sử dụng!");
                return "redirect:/admin/users/add";
            }
            user.setUsername(user.getUsername().trim());
            user.setEmail(user.getEmail().trim());
        } 
        // 3. Chỉnh sửa người dùng
        else {
            Optional<User> existingUserOpt = userService.findById(user.getId());
            if (existingUserOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Người dùng không tồn tại!");
                return "redirect:/admin/users";
            }
            User existingUser = existingUserOpt.get();

            // Kiểm tra trùng email với tài khoản khác
            if (!existingUser.getEmail().equalsIgnoreCase(user.getEmail().trim())
                    && userService.existsByEmail(user.getEmail().trim())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Email [" + user.getEmail() + "] đã được tài khoản khác sử dụng!");
                return "redirect:/admin/users/edit/" + user.getId();
            }

            // Nếu không nhập mật khẩu mới thì giữ nguyên mật khẩu cũ
            if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                user.setPassword(existingUser.getPassword());
            }

            // Nếu không upload ảnh mới thì giữ nguyên ảnh cũ
            if (avatarFile == null || avatarFile.isEmpty()) {
                if (user.getAvatar() == null || user.getAvatar().trim().isEmpty()) {
                    user.setAvatar(existingUser.getAvatar());
                }
            }

            // Giữ nguyên username gốc
            user.setUsername(existingUser.getUsername());
            user.setEmail(user.getEmail().trim());
        }

        userService.save(user);
        redirectAttributes.addFlashAttribute("successMessage", "Lưu thông tin người dùng thành công!");
        return "redirect:/admin/users";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<User> userOpt = userService.findById(id);
        if (userOpt.isPresent()) {
            model.addAttribute("user", userOpt.get());
            model.addAttribute("pageTitle", "Chỉnh Sửa Người Dùng");
            return "admin/user/form";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng có ID: " + id);
            return "redirect:/admin/users";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Optional<User> userOpt = userService.findById(id);
        if (userOpt.isPresent()) {
            userService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa người dùng thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng để xóa!");
        }
        return "redirect:/admin/users";
    }
}
