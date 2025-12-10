package com.petplatform.controller.spring;

import com.petplatform.entity.Pet;
import com.petplatform.service.PetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/pet")
public class PetController {

    @Autowired
    private PetService petService;

    @GetMapping("/list")
    public String listPets(Model model) {
        List<Pet> pets = petService.getAllPets();
        model.addAttribute("pets", pets);
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