package com.petplatform.service;

import com.petplatform.entity.Foster;
import com.petplatform.entity.User;
import org.springframework.data.domain.Page;
import java.util.Date;
import java.util.List;

public interface FosterService {

    // 创建寄养需求
    Foster createFoster(Foster foster, User user);

    // 更新寄养信息
    Foster updateFoster(Long id, Foster foster);

    // 删除寄养需求
    void deleteFoster(Long id);

    // 根据ID获取寄养信息
    Foster getFosterById(Long id);

    // 获取所有寄养需求（分页）
    Page<Foster> getAllFosters(int page, int size);

    // 根据条件搜索寄养需求
    Page<Foster> searchFosters(String city, Foster.PetType petType, Date startDate,
            Date endDate, Double maxFee, int page, int size);

    // 获取用户发布的寄养需求
    List<Foster> getFostersByUser(Long userId);

    // 获取用户申请的寄养
    List<Foster> getAppliedFosters(Long userId);

    // 申请寄养
    Foster applyFoster(Long fosterId, Long userId, String message);

    // 确认寄养匹配
    Foster confirmFoster(Long fosterId, Long applicantId);

    // 取消寄养申请
    void cancelApplication(Long fosterId, Long userId);

    // 完成寄养
    Foster completeFoster(Long fosterId, Integer rating, String review);

    // 更新寄养状态
    Foster updateFosterStatus(Long id, Foster.FosterStatus status);
}