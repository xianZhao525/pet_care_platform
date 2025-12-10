package com.petplatform.service.impl;

import com.petplatform.dao.AdoptionRepository;
import com.petplatform.dao.PetRepository;
import com.petplatform.dao.UserRepository;
import com.petplatform.entity.Adoption;
import com.petplatform.entity.Pet;
import com.petplatform.entity.User;
import com.petplatform.dto.AdoptionDTO;
import com.petplatform.service.AdoptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class AdoptionServiceImpl implements AdoptionService {

    @Autowired
    private AdoptionRepository adoptionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PetRepository petRepository;

    @Override
    public Adoption applyAdoption(AdoptionDTO adoptionDTO) {
        User user = userRepository.findById(adoptionDTO.getUserId())
                .orElseThrow(() -> new RuntimeException("用户不存在"));

        Pet pet = petRepository.findById(adoptionDTO.getPetId())
                .orElseThrow(() -> new RuntimeException("宠物不存在"));

        // 检查是否已经申请过
        if (hasAppliedForPet(adoptionDTO.getUserId(), adoptionDTO.getPetId())) {
            throw new RuntimeException("您已经申请过领养此宠物");
        }

        // 检查宠物是否可领养
        if (pet.getStatus() != Pet.PetStatus.AVAILABLE) {
            throw new RuntimeException("该宠物不可领养");
        }

        Adoption adoption = new Adoption();
        adoption.setUser(user);
        adoption.setPet(pet);
        adoption.setReason(adoptionDTO.getReason());
        adoption.setFamilyMembers(adoptionDTO.getFamilyMembers());
        adoption.setHasPetExperience(adoptionDTO.getHasPetExperience());
        adoption.setHouseType(adoptionDTO.getHouseType());
        adoption.setContactPhone(adoptionDTO.getContactPhone());
        adoption.setContactAddress(adoptionDTO.getContactAddress());

        // 更新宠物状态为待领养
        pet.setStatus(Pet.PetStatus.PENDING_ADOPTION);
        petRepository.save(pet);

        return adoptionRepository.save(adoption);
    }

    @Override
    public void approveAdoption(Long adoptionId, String adminNotes) {
        Adoption adoption = getAdoptionById(adoptionId);

        if (adoption.getStatus() != Adoption.AdoptionStatus.PENDING) {
            throw new RuntimeException("只能审核待处理的申请");
        }

        adoption.setStatus(Adoption.AdoptionStatus.APPROVED);
        adoption.setApproveTime(new Date());
        adoption.setAdminNotes(adminNotes);
        adoptionRepository.save(adoption);

        // 更新宠物状态为已领养
        Pet pet = adoption.getPet();
        pet.setStatus(Pet.PetStatus.ADOPTED);
        petRepository.save(pet);
    }

    @Override
    public void rejectAdoption(Long adoptionId, String adminNotes) {
        Adoption adoption = getAdoptionById(adoptionId);

        if (adoption.getStatus() != Adoption.AdoptionStatus.PENDING) {
            throw new RuntimeException("只能审核待处理的申请");
        }

        adoption.setStatus(Adoption.AdoptionStatus.REJECTED);
        adoption.setApproveTime(new Date());
        adoption.setAdminNotes(adminNotes);
        adoptionRepository.save(adoption);

        // 恢复宠物状态为可领养
        Pet pet = adoption.getPet();
        pet.setStatus(Pet.PetStatus.AVAILABLE);
        petRepository.save(pet);
    }

    @Override
    public void completeAdoption(Long adoptionId) {
        Adoption adoption = getAdoptionById(adoptionId);

        if (adoption.getStatus() != Adoption.AdoptionStatus.APPROVED) {
            throw new RuntimeException("只能完成已批准的申请");
        }

        adoption.setStatus(Adoption.AdoptionStatus.COMPLETED);
        adoptionRepository.save(adoption);
    }

    @Override
    public Adoption getAdoptionById(Long adoptionId) {
        return adoptionRepository.findById(adoptionId)
                .orElseThrow(() -> new RuntimeException("领养申请不存在"));
    }

    @Override
    public List<Adoption> getAdoptionsByUserId(Long userId) {
        return adoptionRepository.findByUserId(userId);
    }

    @Override
    public Page<Adoption> getAllAdoptions(Pageable pageable) {
        return adoptionRepository.findAll(pageable);
    }

    @Override
    public List<Adoption> getPendingAdoptions() {
        return adoptionRepository.findByStatus(Adoption.AdoptionStatus.PENDING);
    }

    @Override
    public long getAdoptionCount() {
        return adoptionRepository.count();
    }

    @Override
    public boolean hasAppliedForPet(Long userId, Long petId) {
        return adoptionRepository.existsByPetIdAndStatus(petId, Adoption.AdoptionStatus.PENDING);
    }
}