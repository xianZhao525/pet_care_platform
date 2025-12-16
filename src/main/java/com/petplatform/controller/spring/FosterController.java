package com.petplatform.controller.spring;

import com.petplatform.entity.Foster;
import com.petplatform.entity.User;
import com.petplatform.service.FosterService;
import com.petplatform.service.UserService;
import com.petplatform.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/foster")
public class FosterController {

    @Autowired
    private FosterService fosterService;

    @Autowired
    private UserService userService;

    // 寄养需求列表
    @GetMapping("/foster/list")
    public String fosterList() {
        return "foster/list"; // 直接返回正确的JSP路径
    }

    public String listFosters(@RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String petType,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            @RequestParam(required = false) Double maxFee,
            Model model) {
        try {
            Date parsedStartDate = null;
            Date parsedEndDate = null;

            Page<Foster> fosters = fosterService.getAllFosters(page - 1, size);

            model.addAttribute("fosters", fosters.getContent());
            model.addAttribute("pageInfo", PageUtil.getPageInfo(fosters));
            model.addAttribute("currentPage", page);
            model.addAttribute("city", city);
            model.addAttribute("petType", petType);
            model.addAttribute("startDate", startDate);
            model.addAttribute("endDate", endDate);
            model.addAttribute("maxFee", maxFee);

            return "foster/list";
        } catch (Exception e) {
            model.addAttribute("error", "获取寄养需求列表失败: " + e.getMessage());
            return "foster/list";
        }
    }

    // 发布寄养需求页面
    @GetMapping("/create")
    public String createFosterPage(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/user/login?redirect=/foster/create";
        }

        model.addAttribute("foster", new Foster());
        return "foster/create";
    }

    // 发布寄养需求
    @PostMapping("/create")
    public String createFoster(@ModelAttribute Foster foster,
            @RequestParam(value = "image", required = false) MultipartFile image,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            // 处理图片上传
            if (image != null && !image.isEmpty()) {
                String fileName = saveFosterImage(image);
                foster.setImageUrl(fileName);
            }

            fosterService.createFoster(foster, user);
            redirectAttributes.addFlashAttribute("success", "寄养需求发布成功！");
            return "redirect:/foster/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "发布失败: " + e.getMessage());
            return "redirect:/foster/create";
        }
    }

    // 寄养需求详情
    @GetMapping("/detail/{id}")
    public String fosterDetail(@PathVariable Long id, Model model, HttpSession session) {
        try {
            Foster foster = fosterService.getFosterById(id);
            User user = (User) session.getAttribute("user");

            model.addAttribute("foster", foster);
            model.addAttribute("isOwner", user != null && user.getId().equals(foster.getUser().getId()));
            model.addAttribute("hasApplied", user != null && user.getId().equals(foster.getApplicantId()));

            return "foster/detail";
        } catch (Exception e) {
            model.addAttribute("error", "获取寄养详情失败: " + e.getMessage());
            return "redirect:/foster/list";
        }
    }

    // 申请寄养
    @PostMapping("/apply/{id}")
    public String applyFoster(@PathVariable Long id,
            @RequestParam String message,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            fosterService.applyFoster(id, user.getId(), message);
            redirectAttributes.addFlashAttribute("success", "寄养申请提交成功！");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "申请失败: " + e.getMessage());
        }

        return "redirect:/foster/detail/" + id;
    }

    // 我的寄养需求
    @GetMapping("/my-fosters")
    public String myFosters(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        List<Foster> fosters = fosterService.getFostersByUser(user.getId());
        model.addAttribute("fosters", fosters);
        return "foster/my-fosters";
    }

    // 我申请的寄养
    @GetMapping("/my-applications")
    public String myApplications(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        List<Foster> applications = fosterService.getAppliedFosters(user.getId());
        model.addAttribute("applications", applications);
        return "foster/my-applications";
    }

    // 取消申请
    @PostMapping("/cancel-application/{id}")
    public String cancelApplication(@PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            fosterService.cancelApplication(id, user.getId());
            redirectAttributes.addFlashAttribute("success", "申请已取消");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "取消失败: " + e.getMessage());
        }

        return "redirect:/foster/my-applications";
    }

    // 确认开始寄养
    @PostMapping("/confirm/{id}")
    public String confirmFoster(@PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            fosterService.confirmFoster(id, user.getId());
            redirectAttributes.addFlashAttribute("success", "寄养已确认开始");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "确认失败: " + e.getMessage());
        }

        return "redirect:/foster/detail/" + id;
    }

    // 完成寄养
    @PostMapping("/complete/{id}")
    public String completeFoster(@PathVariable Long id,
            @RequestParam Integer rating,
            @RequestParam String review,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            fosterService.completeFoster(id, rating, review);
            redirectAttributes.addFlashAttribute("success", "寄养已完成，感谢您的评价！");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "完成失败: " + e.getMessage());
        }

        return "redirect:/foster/detail/" + id;
    }

    // 编辑寄养需求页面
    // 编辑寄养需求页面
    @GetMapping("/edit/{id}")
    public String editFosterPage(@PathVariable Long id,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) { // 添加 redirectAttributes 参数
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            Foster foster = fosterService.getFosterById(id);

            if (!foster.getUser().getId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("error", "无权编辑此寄养需求");
                return "redirect:/foster/detail/" + id;
            }

            model.addAttribute("foster", foster);
            return "foster/edit";
        } catch (Exception e) {
            model.addAttribute("error", "获取寄养信息失败: " + e.getMessage());
            return "redirect:/foster/list";
        }
    }

    // 编辑寄养需求
    @PostMapping("/edit/{id}")
    public String editFoster(@PathVariable Long id,
            @ModelAttribute Foster foster,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            Foster existingFoster = fosterService.getFosterById(id);
            if (!existingFoster.getUser().getId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("error", "无权编辑此寄养需求");
                return "redirect:/foster/detail/" + id;
            }

            fosterService.updateFoster(id, foster);
            redirectAttributes.addFlashAttribute("success", "寄养需求更新成功！");
            return "redirect:/foster/detail/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "更新失败: " + e.getMessage());
            return "redirect:/foster/edit/" + id;
        }
    }

    // 删除寄养需求
    @PostMapping("/delete/{id}")
    public String deleteFoster(@PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            Foster foster = fosterService.getFosterById(id);
            if (!foster.getUser().getId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("error", "无权删除此寄养需求");
                return "redirect:/foster/detail/" + id;
            }

            fosterService.deleteFoster(id);
            redirectAttributes.addFlashAttribute("success", "寄养需求已删除");
            return "redirect:/foster/my-fosters";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "删除失败: " + e.getMessage());
            return "redirect:/foster/detail/" + id;
        }
    }

    // 图片保存方法
    private String saveFosterImage(MultipartFile image) throws IOException {
        String uploadDir = "src/main/resources/static/images/fosters/";
        Path uploadPath = Paths.get(uploadDir);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String originalFileName = image.getOriginalFilename();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + fileExtension;

        Path filePath = uploadPath.resolve(fileName);
        Files.copy(image.getInputStream(), filePath);

        return fileName;
    }
}