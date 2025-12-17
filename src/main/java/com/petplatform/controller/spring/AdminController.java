package com.petplatform.controller.spring;

import com.petplatform.entity.User;
import com.petplatform.service.UserService;
import com.petplatform.util.PageUtil; // ✅ 确保导入PageUtil
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    // ✅ 管理员后台首页
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // 验证是否为管理员
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.ADMIN) {
            return "redirect:/user/login";
        }

        // 统计数据
        model.addAttribute("totalUsers", userService.getUserCount());
        model.addAttribute("petCount", 0); // 需要从PetService获取
        model.addAttribute("donationCount", 0); // 需要从DonationService获取

        return "admin/dashboard";
    }

    // ✅ 用户管理列表
    @GetMapping("/users")
    public String userManagement(@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            HttpSession session,
            Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.ADMIN) {
            return "redirect:/user/login";
        }

        Page<User> users = userService.getAllUsers(PageRequest.of(page, size));
        model.addAttribute("users", users.getContent());
        model.addAttribute("pageInfo", PageUtil.getPageInfo(users));

        return "admin/user_manage";
    }

    // ✅ 可以保留这个方法供其他方法使用（如果需要的话）
    /*
     * private boolean isAdmin(HttpSession session) {
     * User user = (User) session.getAttribute("user");
     * return user != null && user.getRole() == User.UserRole.ADMIN;
     * }
     */
}