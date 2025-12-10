package com.petplatform.service;

import com.petplatform.entity.Pet;
import com.petplatform.dto.PetDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface PetService {

    Pet addPet(PetDTO petDTO);

    Pet updatePet(Long petId, PetDTO petDTO);

    void deletePet(Long petId);

    Pet getPetById(Long petId);

    List<Pet> getAllPets();

    Page<Pet> getPetsByPage(Pageable pageable);

    List<Pet> searchPets(String keyword, String type);

    List<Pet> getAvailablePets();

    List<Pet> getRecentPets(int limit);

    void changePetStatus(Long petId, String status);

    long getPetCount();

    Map<String, Long> getPetStatistics();
}