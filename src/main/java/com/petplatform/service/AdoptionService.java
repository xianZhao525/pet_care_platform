package com.petplatform.service;

import com.petplatform.entity.Adoption;
import com.petplatform.dto.AdoptionDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface AdoptionService {

    Adoption applyAdoption(AdoptionDTO adoptionDTO);

    void approveAdoption(Long adoptionId, String adminNotes);

    void rejectAdoption(Long adoptionId, String adminNotes);

    void completeAdoption(Long adoptionId);

    Adoption getAdoptionById(Long adoptionId);

    List<Adoption> getAdoptionsByUserId(Long userId);

    Page<Adoption> getAllAdoptions(Pageable pageable);

    List<Adoption> getPendingAdoptions();

    long getAdoptionCount();

    boolean hasAppliedForPet(Long userId, Long petId);
}