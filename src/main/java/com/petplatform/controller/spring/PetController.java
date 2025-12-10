package com.petplatform.controller.spring;

import com.petplatform.dto.ApiResponse;
import com.petplatform.dto.PetDTO;
import com.petplatform.entity.Pet;
import com.petplatform.service.PetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/pet")
public class PetController {

    @Autowired
    private PetService petService;

    // 显示宠物列表
    @GetMapping("/list")
    public String listPets(@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String keyword,
            Model model) {

        Pageable pageable = PageRequest.of(page, size, Sort.by("createTime").descending());
        Page<Pet> petPage;

        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Pet> pets = petService.searchPets(keyword, type);
            model.addAttribute("pets", pets);
            model.addAttribute("totalPages", 1);
        } else {
            petPage = petService.getPetsByPage(pageable);
            model.addAttribute("pets", petPage.getContent());
            model.addAttribute("totalPages", petPage.getTotalPages());
        }

        model.addAttribute("currentPage", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("type", type);

        return "pet/list";
    }

    // 显示宠物详情
    @GetMapping("/detail/{id}")
    public String petDetail(@PathVariable Long id, Model model) {
        try {
            Pet pet = petService.getPetById(id);
            model.addAttribute("pet", pet);

            // 获取推荐宠物
            List<Pet> recommendedPets = petService.getRecentPets(4);
            model.addAttribute("recommendedPets", recommendedPets);

            return "pet/detail";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/pet/list";
        }
    }

    // 显示添加宠物页面（管理员）
    @GetMapping("/add")
    public String showAddPetForm(HttpSession session, Model model) {
        // 检查管理员权限
        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        model.addAttribute("petDTO", new PetDTO());
        return "pet/add";
    }

    // 处理添加宠物请求
    @PostMapping("/add")
    public String addPet(@Valid @ModelAttribute PetDTO petDTO,
            BindingResult result,
            HttpSession session,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        if (result.hasErrors()) {
            return "pet/add";
        }

        try {
            Pet pet = petService.addPet(petDTO);
            model.addAttribute("success", "宠物添加成功");
            return "redirect:/pet/detail/" + pet.getId();
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "pet/add";
        }
    }

    // 显示编辑宠物页面
    @GetMapping("/edit/{id}")
    public String showEditPetForm(@PathVariable Long id,
            HttpSession session,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        try {
            Pet pet = petService.getPetById(id);

            PetDTO petDTO = new PetDTO();
            petDTO.setName(pet.getName());
            petDTO.setType(pet.getType().name());
            petDTO.setBreed(pet.getBreed());
            petDTO.setAge(pet.getAge());
            petDTO.setGender(pet.getGender().name());
            petDTO.setColor(pet.getColor());
            petDTO.setDescription(pet.getDescription());
            petDTO.setHealthStatus(pet.getHealthStatus());
            petDTO.setVaccination(pet.getVaccination());
            petDTO.setSterilized(pet.getSterilized());

            model.addAttribute("petDTO", petDTO);
            model.addAttribute("petId", id);
            return "pet/edit";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/pet/list";
        }
    }

    // 处理编辑宠物请求
    @PostMapping("/edit/{id}")
    public String editPet(@PathVariable Long id,
            @Valid @ModelAttribute PetDTO petDTO,
            BindingResult result,
            HttpSession session,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/user/login";
        }

        if (result.hasErrors()) {
            model.addAttribute("petId", id);
            return "pet/edit";
        }

        try {
            Pet updatedPet = petService.updatePet(id, petDTO);
            model.addAttribute("success", "宠物信息更新成功");
            return "redirect:/pet/detail/" + updatedPet.getId();
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("petId", id);
            return "pet/edit";
        }
    }

    // REST API: 获取最新宠物
    @GetMapping("/api/recent")
    @ResponseBody
    public ApiResponse<List<Pet>> getRecentPets(@RequestParam(defaultValue = "6") int limit) {
        try {
            List<Pet> pets = petService.getRecentPets(limit);
            return ApiResponse.success(pets);
        } catch (Exception e) {
            return ApiResponse.error(e.getMessage());
        }
    }

    // REST API: 获取宠物统计
    @GetMapping("/api/statistics")
    @ResponseBody
    public ApiResponse<Map<String, Long>> getPetStatistics() {
        try {
            Map<String, Long> statistics = petService.getPetStatistics();
            return ApiResponse.success(statistics);
        } catch (Exception e) {
            return ApiResponse.error(e.getMessage());
        }
    }

    // 检查管理员权限
    private boolean isAdmin(HttpSession session) {
        // 这里简化处理，实际应该检查角色
        return session.getAttribute("userId") != null;
    }
}