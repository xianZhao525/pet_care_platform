package com.petplatform.service.impl;

import com.petplatform.dao.PetRepository;
import com.petplatform.entity.Pet;
import com.petplatform.service.PetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PetServiceImpl implements PetService {

    @Autowired
    private PetRepository petRepository;

    @Override
    public List<Pet> getAllPets() {
        return petRepository.findAll();
    }

    @Override
    public List<Pet> getAvailablePets() {
        return petRepository.findByStatus(Pet.PetStatus.AVAILABLE);
    }

    @Override
    public Optional<Pet> getPetById(Long id) {
        return petRepository.findById(id);
    }

    @Override
    public Pet savePet(Pet pet) {
        return petRepository.save(pet);
    }

    @Override
    public void deletePet(Long id) {
        petRepository.deleteById(id);
    }

    @Override
    public List<Pet> searchPets(String keyword) {
        return petRepository.findByNameContainingIgnoreCase(keyword);
    }

    @Override
    public List<Pet> getPetsByType(String type) {
        try {
            Pet.PetType petType = Pet.PetType.valueOf(type.toUpperCase());
            return petRepository.findByType(petType);
        } catch (IllegalArgumentException e) {
            return List.of();
        }
    }
}