package vn.trungduc.springboot_admin_crud.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.trungduc.springboot_admin_crud.entity.Category;
import vn.trungduc.springboot_admin_crud.service.ICategoryService;

import java.util.Optional;

@Controller
@RequestMapping("/admin/categories")
@RequiredArgsConstructor
public class CategoryController {

    private final ICategoryService categoryService;

    @GetMapping
    public String listCategories(
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
        Page<Category> categoryPage = categoryService.search(keyword, pageable);

        model.addAttribute("categoryPage", categoryPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", categoryPage.getTotalPages());
        model.addAttribute("totalElements", categoryPage.getTotalElements());
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("reverseSortDir", sortDir.equalsIgnoreCase("asc") ? "desc" : "asc");

        return "admin/category/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        Category category = new Category();
        category.setStatus(true);
        model.addAttribute("category", category);
        model.addAttribute("pageTitle", "Thêm Mới Danh Mục");
        return "admin/category/form";
    }

    @PostMapping("/save")
    public String saveCategory(
            @ModelAttribute("category") Category category,
            RedirectAttributes redirectAttributes) {

        if (category.getCategoryName() == null || category.getCategoryName().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên danh mục không được để trống!");
            return "redirect:/admin/categories/add";
        }

        categoryService.save(category);
        redirectAttributes.addFlashAttribute("successMessage", "Lưu thông tin danh mục thành công!");
        return "redirect:/admin/categories";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Category> categoryOpt = categoryService.findById(id);
        if (categoryOpt.isPresent()) {
            model.addAttribute("category", categoryOpt.get());
            model.addAttribute("pageTitle", "Chỉnh Sửa Danh Mục");
            return "admin/category/form";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy danh mục có ID: " + id);
            return "redirect:/admin/categories";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Optional<Category> categoryOpt = categoryService.findById(id);
        if (categoryOpt.isPresent()) {
            categoryService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa danh mục thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy danh mục để xóa!");
        }
        return "redirect:/admin/categories";
    }
}
