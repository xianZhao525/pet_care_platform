package com.petplatform.controller.spring;

import com.petplatform.dto.AdoptionDTO;
import com.petplatform.dto.ApiResponse;
import com.petplatform.entity.Adoption;
import com.petplatform.entity.User;
import com.petplatform.service.AdoptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/adoption")
public class AdoptionController {

    @Autowired
    private AdoptionService adoptionService;

    // 显示领养申请页面
    @GetMapping("/apply/{petId}")
    public String showApplyForm(@PathVariable Long petId,
            HttpSession session,
            Model model) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login?redirect=/adoption/apply/" + petId;
        }

        // 检查是否已经申请过
        if (adoptionService.hasAppliedForPet(userId, petId)) {
            model.addAttribute("error", "您已经申请过领养此宠物");
            return "redirect:/pet/detail/" + petId;
        }

        AdoptionDTO adoptionDTO = new AdoptionDTO();
        adoptionDTO.setUserId(userId);
        adoptionDTO.setPetId(petId);

        model.addAttribute("adoptionDTO", adoptionDTO);
        model.addAttribute("petId", petId);
        return "adoption/apply";
    }

    // 处理领养申请
    @PostMapping("/apply")
    public String applyAdoption(@Valid @ModelAttribute AdoptionDTO adoptionDTO,
            BindingResult result,
            HttpSession session,
            Model model) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        if (result.hasErrors()) {
            model.addAttribute("petId", adoptionDTO.getPetId());
            return "adoption/apply";
        }

        try {
            Adoption adoption = adoptionService.applyAdoption(adoptionDTO);
            model.addAttribute("success", "领养申请提交成功，请等待审核");
            return "redirect:/adoption/my";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("petId", adoptionDTO.getPetId());
            return "adoption/apply";
        }
    }

    // 显示我的领养申请
    @GetMapping("/my")
    public String myAdoptions(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            List<Adoption> adoptions = adoptionService.getAdoptionsByUserId(userId);
            model.addAttribute("adoptions", adoptions);
            return "adoption/my";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/";
        }
    }

    // 管理员：显示所有领养申请
    @GetMapping("/admin/list")
    public String adminListAdoptions(HttpSession session,
            @RequestParam(defaultValue = "0") int page,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        // 这里可以使用分页，暂时简化
        List<Adoption> pendingAdoptions = adoptionService.getPendingAdoptions();
        model.addAttribute("adoptions", pendingAdoptions);

        return "adoption/admin/list";
    }

    // 管理员：批准申请
    @PostMapping("/admin/approve/{id}")
    public String approveAdoption(@PathVariable Long id,
            @RequestParam String adminNotes,
            HttpSession session,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        try {
            adoptionService.approveAdoption(id, adminNotes);
            model.addAttribute("success", "申请已批准");
            return "redirect:/adoption/admin/list";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/adoption/admin/list";
        }
    }

    // 管理员：拒绝申请
    @PostMapping("/admin/reject/{id}")
    public String rejectAdoption(@PathVariable Long id,
            @RequestParam String adminNotes,
            HttpSession session,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        try {
            adoptionService.rejectAdoption(id, adminNotes);
            model.addAttribute("success", "申请已拒绝");
            return "redirect:/adoption/admin/list";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/adoption/admin/list";
        }
    }

    // REST API: 申请领养
    @PostMapping("/api/apply")
    @ResponseBody
    public ApiResponse<Adoption> applyAdoptionApi(@Valid @RequestBody AdoptionDTO adoptionDTO,
            HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return ApiResponse.error("请先登录", 401);
        }

        try {
            Adoption adoption = adoptionService.applyAdoption(adoptionDTO);
            return ApiResponse.success("申请提交成功", adoption);
        } catch (Exception e) {
            return ApiResponse.error(e.getMessage());
        }
    }

    // 检查管理员权限
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && user.getRoles().stream()
                .anyMatch(role -> "ADMIN".equals(role.getName()));
    }
}