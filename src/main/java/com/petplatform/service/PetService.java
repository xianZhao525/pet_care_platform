package com.petplatform.service;

import com.petplatform.entity.Pet;
import java.util.List;
import java.util.Optional;

public interface PetService {

    List<Pet> getAllPets();

    List<Pet> getAvailablePets();

    Optional<Pet> getPetById(Long id);

    Pet savePet(Pet pet);

    void deletePet(Long id);

    List<Pet> searchPets(String keyword);

    List<Pet> getPetsByType(String type);

    long countByStatus(Pet.PetStatus status);
}