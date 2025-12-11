package com.petplatform.controller.spring;

import com.petplatform.dto.ApiResponse;
import com.petplatform.entity.User;
import com.petplatform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    // 管理员仪表板
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        try {
            long userCount = userService.getUserCount();
            // 这里可以添加其他统计数据

            model.addAttribute("userCount", userCount);
            model.addAttribute("petCount", 0); // 临时
            model.addAttribute("adoptionCount", 0); // 临时

            return "admin/dashboard";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/";
        }
    }

    // 用户管理页面
    @GetMapping("/users")
    public String manageUsers(HttpSession session,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        Pageable pageable = PageRequest.of(page, size, Sort.by("createTime").descending());
        Page<User> userPage;

        if (keyword != null && !keyword.trim().isEmpty()) {
            List<User> users = userService.searchUsers(keyword);
            model.addAttribute("users", users);
            model.addAttribute("totalPages", 1);
        } else {
            userPage = userService.getAllUsers(pageable);
            model.addAttribute("users", userPage.getContent());
            model.addAttribute("totalPages", userPage.getTotalPages());
        }

        model.addAttribute("currentPage", page);
        model.addAttribute("keyword", keyword);

        return "admin/user_manage";
    }

    // 启用/禁用用户
    @PostMapping("/users/{id}/toggle")
    public String toggleUser(@PathVariable Long id,
            HttpSession session,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        try {
            // 修复：getUserById返回Optional，需要处理
            Optional<User> userOptional = userService.getUserById(id);
            if (userOptional.isPresent()) {
                User user = userOptional.get();
                // 这里可以添加启用/禁用的逻辑
                // 例如：user.setEnabled(!user.getEnabled());
                model.addAttribute("success", "用户状态已更新");
            } else {
                model.addAttribute("error", "用户不存在");
            }
            return "redirect:/admin/users";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/admin/users";
        }
    }

    // REST API: 获取用户列表
    @GetMapping("/api/users")
    @ResponseBody
    public ApiResponse<Page<User>> getUsersApi(@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        try {
            Pageable pageable = PageRequest.of(page, size);
            Page<User> users = userService.getAllUsers(pageable);
            return ApiResponse.success(users);
        } catch (Exception e) {
            return ApiResponse.error(e.getMessage());
        }
    }

    // 检查管理员权限
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && User.UserRole.ADMIN.equals(user.getRole());
    }
}