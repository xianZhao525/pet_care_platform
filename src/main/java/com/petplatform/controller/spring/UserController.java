package com.petplatform.controller.spring;

import com.petplatform.dto.ApiResponse;
import com.petplatform.dto.LoginDTO;
import com.petplatform.dto.UserDTO;
import com.petplatform.entity.User;
import com.petplatform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // 显示注册页面
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("userDTO", new UserDTO());
        return "user/register";
    }

    // 处理注册请求
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("userDTO") UserDTO userDTO,
            BindingResult result,
            Model model) {
        if (result.hasErrors()) {
            return "user/register";
        }

        try {
            User user = userService.registerUser(userDTO);
            model.addAttribute("success", "注册成功，请登录");
            return "user/login";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "user/register";
        }
    }

    // 显示登录页面
    @GetMapping("/login") // 对应 /user/login
    public String loginPage() {
        return "user/login";
    }

    // @GetMapping("/login")
    // public String showLoginForm(Model model) {
    // model.addAttribute("loginDTO", new LoginDTO());
    // return "user/login";
    // }

    // 处理登录请求
    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("loginDTO") LoginDTO loginDTO,
            BindingResult result,
            HttpSession session,
            Model model) {
        if (result.hasErrors()) {
            return "user/login";
        }

        try {
            User user = userService.login(loginDTO.getUsername(), loginDTO.getPassword())
                    .orElseThrow(() -> new Exception("用户名或密码错误"));
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());

            // 重定向到首页
            return "redirect:/";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "user/login";
        }
    }

    // 退出登录
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // 显示个人资料页面
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            User user = userService.getUserById(userId)
                    .orElseThrow(() -> new Exception("用户不存在"));
            model.addAttribute("user", user);
            return "user/profile";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/";
        }
    }

    // 更新个人资料
    @PostMapping("/profile/update")
    public String updateProfile(@Valid @ModelAttribute UserDTO userDTO,
            BindingResult result,
            HttpSession session,
            Model model) {
        if (result.hasErrors()) {
            return "user/profile";
        }

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            User updatedUser = userService.updateUser(userId, userDTO);
            session.setAttribute("user", updatedUser);
            model.addAttribute("success", "资料更新成功");
            return "user/profile";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "user/profile";
        }
    }

    // REST API: 获取用户信息
    @GetMapping("/api/{id}")
    @ResponseBody
    public ApiResponse<User> getUserById(@PathVariable Long id) {
        try {
            User user = userService.getUserById(id)
                    .orElseThrow(() -> new RuntimeException("用户不存在"));
            return ApiResponse.success(user);
        } catch (Exception e) {
            return ApiResponse.error(e.getMessage());
        }
    }

    // REST API: 搜索用户
    @GetMapping("/api/search")
    @ResponseBody
    public ApiResponse<List<User>> searchUsers(@RequestParam String keyword) {
        try {
            List<User> users = userService.searchUsers(keyword);
            return ApiResponse.success(users);
        } catch (Exception e) {
            return ApiResponse.error(e.getMessage());
        }
    }
}