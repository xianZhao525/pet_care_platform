package com.petplatform.controller.spring;

import com.petplatform.dto.LoginDTO;
import com.petplatform.dto.UserDTO;
import com.petplatform.entity.User;
import com.petplatform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // 显示注册页面
    @GetMapping("/register")
    public String showRegisterForm(Model model, HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }
        model.addAttribute("userDTO", new UserDTO());
        return "user/register";
    }

    // ✅ 处理注册请求（带完整日志）
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("userDTO") UserDTO userDTO,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        System.out.println("======================================");
        System.out.println("🎯 注册请求到达 - 用户名: " + userDTO.getUsername());
        System.out.println("🎯 手机号: " + userDTO.getPhone());
        System.out.println("🎯 邮箱: " + userDTO.getEmail());
        System.out.println("🎯 角色: " + userDTO.getRole());
        System.out.println("🎯 管理员码: " + userDTO.getAdminCode());
        System.out.println("======================================");

        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }

        if (result.hasErrors()) {
            System.out.println("❌ 表单验证失败: " + result.getAllErrors());
            return "user/register";
        }

        try {
            // 检查用户名是否已存在
            if (userService.findByUsername(userDTO.getUsername()).isPresent()) {
                System.out.println("❌ 用户名已存在");
                redirectAttributes.addFlashAttribute("error", "用户名已存在，请使用其他用户名");
                return "redirect:/user/register";
            }

            // 注册用户
            User user = userService.registerUser(userDTO);
            System.out.println("✅ 注册成功 - 用户ID: " + user.getId() + ", 角色: " + user.getRole());

            redirectAttributes.addFlashAttribute("registered", true);
            return "redirect:/user/login";

        } catch (Exception e) {
            System.err.println("❌ 注册异常: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "注册失败: " + e.getMessage());
            return "redirect:/user/register";
        }
    }

    // 显示登录页面
    @GetMapping("/login")
    public String loginPage(Model model, HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }

        model.addAttribute("loginDTO", new LoginDTO());
        return "user/login";
    }

    // 处理登录请求（带完整日志）
    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("loginDTO") LoginDTO loginDTO,
            BindingResult result,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        System.out.println("======================================");
        System.out.println("🎯 登录请求到达 - 用户名: " + loginDTO.getUsername());
        System.out.println("======================================");

        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }

        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("loginError", true);
            redirectAttributes.addFlashAttribute("errorMessage", "请输入完整的登录信息");
            return "redirect:/user/login";
        }

        try {
            User user = userService.login(loginDTO.getUsername(), loginDTO.getPassword())
                    .orElseThrow(() -> new RuntimeException("用户名或密码错误"));

            System.out.println("✅ 登录成功 - 用户ID: " + user.getId() + ", 角色: " + user.getRole());

            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());

            return "redirect:/";

        } catch (Exception e) {
            System.err.println("❌ 登录失败: " + e.getMessage());
            redirectAttributes.addFlashAttribute("loginError", true);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/user/login";
        }
    }

    // 退出登录
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/user/login";
    }
}