package com.petplatform.controller.spring;

import com.petplatform.entity.Donation;
import com.petplatform.entity.DonationRecord;
import com.petplatform.entity.User;
import com.petplatform.service.DonationService;
import com.petplatform.service.UserService;
import com.petplatform.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Controller
@RequestMapping("/donation")
public class DonationController {

    @Autowired
    private DonationService donationService;

    @Autowired
    private UserService userService;

    // 捐赠项目列表
    @GetMapping("/list")
    public String listDonations(@RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String status,
            Model model) {
        try {
            Donation.DonationType donationType = null;
            if (type != null && !type.isEmpty()) {
                try {
                    donationType = Donation.DonationType.valueOf(type.toUpperCase());
                } catch (IllegalArgumentException e) {
                    // 忽略无效的类型
                }
            }

            Donation.DonationStatus donationStatus = null;
            if (status != null && !status.isEmpty()) {
                try {
                    donationStatus = Donation.DonationStatus.valueOf(status.toUpperCase());
                } catch (IllegalArgumentException e) {
                    // 忽略无效的状态
                }
            }

            Page<Donation> donations = donationService.searchDonations(keyword, donationType, donationStatus, page - 1,
                    size);

            // 获取特色项目
            List<Donation> featuredDonations = donationService.getFeaturedDonations();

            // 获取统计数据
            Map<String, Object> stats = donationService.getOverallStats();

            model.addAttribute("donations", donations.getContent());
            model.addAttribute("featuredDonations", featuredDonations);
            model.addAttribute("pageInfo", PageUtil.getPageInfo(donations));
            model.addAttribute("currentPage", page);
            model.addAttribute("keyword", keyword);
            model.addAttribute("type", type);
            model.addAttribute("status", status);
            model.addAttribute("stats", stats);
            model.addAttribute("recentDonations", donationService.getRecentDonations(5));

            return "donation/list";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠项目列表失败: " + e.getMessage());
            return "donation/list";
        }
    }

    // 捐赠项目详情
    @GetMapping("/detail/{id}")
    public String donationDetail(@PathVariable Long id,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model,
            HttpSession session) {
        try {
            Donation donation = donationService.getDonationById(id);
            Page<DonationRecord> records = donationService.getDonationRecords(id, page - 1, size);
            Map<String, Object> stats = donationService.getDonationStats(id);

            User user = (User) session.getAttribute("user");
            boolean hasDonated = false;
            if (user != null) {
                // 检查用户是否已经捐赠过
                Page<DonationRecord> userRecords = donationService.getUserDonationRecords(user.getId(), 0, 1);
                hasDonated = userRecords.getContent().stream()
                        .anyMatch(record -> record.getDonation().getId().equals(id));
            }

            model.addAttribute("donation", donation);
            model.addAttribute("records", records.getContent());
            model.addAttribute("pageInfo", PageUtil.getPageInfo(records));
            model.addAttribute("stats", stats);
            model.addAttribute("hasDonated", hasDonated);
            model.addAttribute("user", user);

            return "donation/detail";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠项目详情失败: " + e.getMessage());
            return "redirect:/donation/list";
        }
    }

    // 金钱捐赠页面
    @GetMapping("/money/{id}")
    public String moneyDonationPage(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login?redirect=/donation/money/" + id;
        }

        try {
            Donation donation = donationService.getDonationById(id);
            model.addAttribute("donation", donation);
            model.addAttribute("user", user);
            return "donation/money";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠项目失败: " + e.getMessage());
            return "redirect:/donation/list";
        }
    }

    // 处理金钱捐赠
    @PostMapping("/money/{id}")
    public String processMoneyDonation(@PathVariable Long id,
            @RequestParam Double amount,
            @RequestParam String paymentMethod,
            @RequestParam(required = false) String message,
            @RequestParam(required = false, defaultValue = "false") Boolean isAnonymous,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            if (amount <= 0) {
                redirectAttributes.addFlashAttribute("error", "捐赠金额必须大于0");
                return "redirect:/donation/money/" + id;
            }

            Map<String, Object> result = donationService.processMoneyDonation(
                    id, user, amount, paymentMethod, message, isAnonymous);

            redirectAttributes.addFlashAttribute("success", result.get("message"));
            redirectAttributes.addFlashAttribute("record", result.get("record"));
            redirectAttributes.addFlashAttribute("certificateNumber", result.get("certificateNumber"));

            return "redirect:/donation/success/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "捐赠失败: " + e.getMessage());
            return "redirect:/donation/money/" + id;
        }
    }

    // 物资捐赠页面
    @GetMapping("/items/{id}")
    public String itemsDonationPage(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login?redirect=/donation/items/" + id;
        }

        try {
            Donation donation = donationService.getDonationById(id);
            model.addAttribute("donation", donation);
            model.addAttribute("user", user);
            return "donation/items";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠项目失败: " + e.getMessage());
            return "redirect:/donation/list";
        }
    }

    // 处理物资捐赠
    @PostMapping("/items/{id}")
    public String processItemsDonation(@PathVariable Long id,
            @RequestParam String itemName,
            @RequestParam Integer itemCount,
            @RequestParam Double itemValue,
            @RequestParam(required = false) String message,
            @RequestParam(required = false, defaultValue = "false") Boolean isAnonymous,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            if (itemCount <= 0) {
                redirectAttributes.addFlashAttribute("error", "物资数量必须大于0");
                return "redirect:/donation/items/" + id;
            }

            Map<String, Object> result = donationService.processItemDonation(
                    id, user, itemName, itemCount, itemValue, message, isAnonymous);

            redirectAttributes.addFlashAttribute("success", result.get("message"));
            redirectAttributes.addFlashAttribute("record", result.get("record"));
            redirectAttributes.addFlashAttribute("certificateNumber", result.get("certificateNumber"));

            return "redirect:/donation/success/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "捐赠失败: " + e.getMessage());
            return "redirect:/donation/items/" + id;
        }
    }

    // 志愿服务页面
    @GetMapping("/volunteer/{id}")
    public String volunteerDonationPage(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login?redirect=/donation/volunteer/" + id;
        }

        try {
            Donation donation = donationService.getDonationById(id);
            model.addAttribute("donation", donation);
            model.addAttribute("user", user);
            return "donation/volunteer";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠项目失败: " + e.getMessage());
            return "redirect:/donation/list";
        }
    }

    // 处理志愿服务
    @PostMapping("/volunteer/{id}")
    public String processVolunteerDonation(@PathVariable Long id,
            @RequestParam Integer volunteerHours,
            @RequestParam(required = false) String message,
            @RequestParam(required = false, defaultValue = "false") Boolean isAnonymous,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            if (volunteerHours <= 0) {
                redirectAttributes.addFlashAttribute("error", "志愿服务时长必须大于0");
                return "redirect:/donation/volunteer/" + id;
            }

            Map<String, Object> result = donationService.processVolunteerDonation(
                    id, user, volunteerHours, message, isAnonymous);

            redirectAttributes.addFlashAttribute("success", result.get("message"));
            redirectAttributes.addFlashAttribute("record", result.get("record"));
            redirectAttributes.addFlashAttribute("certificateNumber", result.get("certificateNumber"));

            return "redirect:/donation/success/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "志愿服务报名失败: " + e.getMessage());
            return "redirect:/donation/volunteer/" + id;
        }
    }

    // 捐赠成功页面
    @GetMapping("/success/{id}")
    public String donationSuccess(@PathVariable Long id,
            Model model,
            HttpSession session) {
        try {
            Donation donation = donationService.getDonationById(id);
            model.addAttribute("donation", donation);

            // 从Flash属性中获取数据
            Object success = model.asMap().get("success");
            Object record = model.asMap().get("record");
            Object certificateNumber = model.asMap().get("certificateNumber");

            if (success != null) {
                model.addAttribute("success", success);
            }
            if (record != null) {
                model.addAttribute("record", record);
            }
            if (certificateNumber != null) {
                model.addAttribute("certificateNumber", certificateNumber);
            }

            return "donation/success";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠信息失败: " + e.getMessage());
            return "redirect:/donation/list";
        }
    }

    // 我的捐赠记录
    @GetMapping("/my-donations")
    public String myDonations(@RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        try {
            Page<DonationRecord> records = donationService.getUserDonationRecords(user.getId(), page - 1, size);
            Map<String, Object> stats = donationService.getUserDonationStats(user.getId());

            model.addAttribute("records", records.getContent());
            model.addAttribute("pageInfo", PageUtil.getPageInfo(records));
            model.addAttribute("stats", stats);

            return "donation/my-donations";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠记录失败: " + e.getMessage());
            return "donation/my-donations";
        }
    }

    // 获取捐赠证书
    @GetMapping("/certificate/{recordId}")
    public String getCertificate(@PathVariable Long recordId, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        try {
            DonationRecord record = donationService.getDonationRecordById(recordId);

            if (!record.getUser().getId().equals(user.getId()) &&
                    !user.getRole().equals(User.UserRole.ADMIN)) {
                model.addAttribute("error", "无权查看此证书");
                return "redirect:/donation/my-donations";
            }

            model.addAttribute("record", record);

            return "donation/certificate";
        } catch (Exception e) {
            model.addAttribute("error", "获取证书失败: " + e.getMessage());
            return "redirect:/donation/my-donations";
        }
    }

    // 管理捐赠项目（管理员）
    @GetMapping("/manage")
    public String manageDonations(@RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            Model model,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals(User.UserRole.ADMIN)) {
            return "redirect:/user/login";
        }

        try {
            Page<Donation> donations = donationService.getAllDonations(page - 1, size);
            model.addAttribute("donations", donations.getContent());
            model.addAttribute("pageInfo", PageUtil.getPageInfo(donations));
            return "donation/manage";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠项目管理失败: " + e.getMessage());
            return "donation/manage";
        }
    }

    // 创建捐赠项目页面（管理员）
    @GetMapping("/create")
    public String createDonationPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals(User.UserRole.ADMIN)) {
            return "redirect:/user/login";
        }

        model.addAttribute("donation", new Donation());
        return "donation/create";
    }

    // 创建捐赠项目（管理员）
    @PostMapping("/create")
    public String createDonation(@ModelAttribute Donation donation,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null || !user.getRole().equals(User.UserRole.ADMIN)) {
                return "redirect:/user/login";
            }

            // 处理封面图片
            if (coverImage != null && !coverImage.isEmpty()) {
                String fileName = saveDonationImage(coverImage);
                donation.setCoverImage(fileName);
            }

            donationService.createDonation(donation, user);
            redirectAttributes.addFlashAttribute("success", "捐赠项目创建成功！");
            return "redirect:/donation/manage";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "创建失败: " + e.getMessage());
            return "redirect:/donation/create";
        }
    }

    // 编辑捐赠项目页面（管理员）
    @GetMapping("/edit/{id}")
    public String editDonationPage(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals(User.UserRole.ADMIN)) {
            return "redirect:/user/login";
        }

        try {
            Donation donation = donationService.getDonationById(id);
            model.addAttribute("donation", donation);
            return "donation/edit";
        } catch (Exception e) {
            model.addAttribute("error", "获取捐赠项目失败: " + e.getMessage());
            return "redirect:/donation/manage";
        }
    }

    // 编辑捐赠项目（管理员）
    @PostMapping("/edit/{id}")
    public String editDonation(@PathVariable Long id,
            @ModelAttribute Donation donation,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null || !user.getRole().equals(User.UserRole.ADMIN)) {
                return "redirect:/user/login";
            }

            // 处理封面图片
            if (coverImage != null && !coverImage.isEmpty()) {
                String fileName = saveDonationImage(coverImage);
                donation.setCoverImage(fileName);
            }

            donationService.updateDonation(id, donation);
            redirectAttributes.addFlashAttribute("success", "捐赠项目更新成功！");
            return "redirect:/donation/manage";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "更新失败: " + e.getMessage());
            return "redirect:/donation/edit/" + id;
        }
    }

    // 更新捐赠状态（管理员）
    @PostMapping("/update-status/{id}")
    public String updateDonationStatus(@PathVariable Long id,
            @RequestParam String status,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null || !user.getRole().equals(User.UserRole.ADMIN)) {
                return "redirect:/user/login";
            }

            Donation.DonationStatus donationStatus = Donation.DonationStatus.valueOf(status.toUpperCase());
            donationService.updateDonationStatus(id, donationStatus);
            redirectAttributes.addFlashAttribute("success", "状态更新成功！");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "状态更新失败: " + e.getMessage());
        }

        return "redirect:/donation/manage";
    }

    // 删除捐赠项目（管理员）
    @PostMapping("/delete/{id}")
    public String deleteDonation(@PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null || !user.getRole().equals(User.UserRole.ADMIN)) {
                return "redirect:/user/login";
            }

            donationService.deleteDonation(id);
            redirectAttributes.addFlashAttribute("success", "捐赠项目已删除");
            return "redirect:/donation/manage";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "删除失败: " + e.getMessage());
            return "redirect:/donation/edit/" + id;
        }
    }

    // 捐赠统计页面（管理员）
    @GetMapping("/statistics")
    public String donationStatistics(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals(User.UserRole.ADMIN)) {
            return "redirect:/user/login";
        }

        try {
            Map<String, Object> stats = donationService.getOverallStats();
            List<Map<String, Object>> topDonors = donationService.getTopDonors(10);
            List<Map<String, Object>> recentDonations = donationService.getRecentDonations(10);

            model.addAttribute("stats", stats);
            model.addAttribute("topDonors", topDonors);
            model.addAttribute("recentDonations", recentDonations);

            return "donation/statistics";
        } catch (Exception e) {
            model.addAttribute("error", "获取统计数据失败: " + e.getMessage());
            return "donation/statistics";
        }
    }

    // 图片保存方法
    private String saveDonationImage(MultipartFile image) throws IOException {
        String uploadDir = "src/main/resources/static/images/donations/";
        Path uploadPath = Paths.get(uploadDir);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String originalFileName = image.getOriginalFilename();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8)
                + fileExtension;

        Path filePath = uploadPath.resolve(fileName);
        Files.copy(image.getInputStream(), filePath);

        return fileName;
    }
}