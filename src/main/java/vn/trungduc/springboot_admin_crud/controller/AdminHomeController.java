package vn.trungduc.springboot_admin_crud.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.trungduc.springboot_admin_crud.service.ICategoryService;
import vn.trungduc.springboot_admin_crud.service.IUserService;

@Controller
@RequiredArgsConstructor
public class AdminHomeController {

    private final ICategoryService categoryService;
    private final IUserService userService;

    @GetMapping("/")
    public String root() {
        return "redirect:/admin/home";
    }

    @GetMapping({"/admin", "/admin/", "/admin/home"})
    public String home(Model model) {
        model.addAttribute("totalCategories", categoryService.count());
        model.addAttribute("totalUsers", userService.count());
        return "admin/home";
    }
}