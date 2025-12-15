package com.petplatform.service;

import com.petplatform.dto.AdoptionDTO;
import com.petplatform.entity.Adoption;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface AdoptionService {

    // 检查用户是否已经申请过领养该宠物
    boolean hasAppliedForPet(Long userId, Long petId);

    // 申请领养
    Adoption applyAdoption(AdoptionDTO adoptionDTO);

    // 根据用户ID获取领养申请列表
    List<Adoption> getAdoptionsByUserId(Long userId);

    // 获取待处理的领养申请（管理员用）
    List<Adoption> getPendingAdoptions();

    // 批准领养申请
    void approveAdoption(Long id, String adminNotes);

    // 拒绝领养申请
    void rejectAdoption(Long id, String adminNotes);

    // 完成领养（新增）
    void completeAdoption(Long adoptionId);

    // 根据ID获取领养申请（新增）
    Adoption getAdoptionById(Long adoptionId);

    // 获取所有领养申请（分页）（新增）
    Page<Adoption> getAllAdoptions(Pageable pageable);

    // 获取领养申请总数（新增）
    long getAdoptionCount();
}