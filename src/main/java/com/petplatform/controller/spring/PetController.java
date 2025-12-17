package com.petplatform.controller.spring;

import com.petplatform.entity.Pet;
import com.petplatform.service.PetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.util.StringUtils;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

@Controller
@RequestMapping("/pet")
public class PetController {

    @Autowired
    private PetService petService;

    // @GetMapping("/list")
    // public String listPets(Model model) {
    // List<Pet> pets = petService.getAvailablePets();
    // model.addAttribute("pets", pets);
    // return "pet/list";
    // }

    @GetMapping("/list")
    public String listPets(@RequestParam(required = false) String keyword, Model model) {
        List<Pet> pets = StringUtils.hasText(keyword)
                ? petService.searchPets(keyword)
                : petService.getAvailablePets();

        model.addAttribute("pets", pets);
        model.addAttribute("keyword", keyword);

        Map<String, Long> stats = new HashMap<>();
        stats.put("availableCount", petService.countByStatus(Pet.PetStatus.AVAILABLE));
        stats.put("adoptedCount", petService.countByStatus(Pet.PetStatus.ADOPTED));
        stats.put("fosteredCount", petService.countByStatus(Pet.PetStatus.FOSTERED));
        model.addAttribute("stats", stats);

        return "pet/list";
    }

    @GetMapping("/detail")
    public String petDetail(@RequestParam Long id, Model model) {
        Pet pet = petService.getPetById(id).orElse(null);
        model.addAttribute("pet", pet);
        return "pet/detail";
    }

    @GetMapping("/available")
    public String availablePets(Model model) {
        List<Pet> pets = petService.getAvailablePets();
        model.addAttribute("pets", pets);
        return "pet/list";
    }

    @GetMapping("/search")
    public String searchPets(@RequestParam String keyword, Model model) {
        List<Pet> pets = petService.searchPets(keyword);
        model.addAttribute("pets", pets);
        model.addAttribute("keyword", keyword);
        return "pet/list";
    }
}