package com.petplatform.service.impl;

import com.petplatform.entity.Foster;
import com.petplatform.entity.User;
import com.petplatform.dao.FosterRepository;
import com.petplatform.dao.UserRepository;
import com.petplatform.service.FosterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class FosterServiceImpl implements FosterService {

    @Autowired
    private FosterRepository fosterRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public Foster createFoster(Foster foster, User user) {
        foster.setUser(user);
        foster.setCreateTime(new Date());
        foster.setUpdateTime(new Date());
        foster.setStatus(Foster.FosterStatus.PENDING);

        // 计算寄养天数
        if (foster.getStartDate() != null && foster.getEndDate() != null) {
            long diff = foster.getEndDate().getTime() - foster.getStartDate().getTime();
            int days = (int) (diff / (1000 * 60 * 60 * 24));
            foster.setDurationDays(Math.max(days, 1));
        }

        return fosterRepository.save(foster);
    }

    @Override
    public Foster updateFoster(Long id, Foster foster) {
        Foster existingFoster = getFosterById(id);

        if (existingFoster.getStatus() != Foster.FosterStatus.PENDING) {
            throw new RuntimeException("只有待寄养状态的需求可以修改");
        }

        existingFoster.setTitle(foster.getTitle());
        existingFoster.setDescription(foster.getDescription());
        existingFoster.setPetType(foster.getPetType());
        existingFoster.setPetName(foster.getPetName());
        existingFoster.setPetAge(foster.getPetAge());
        existingFoster.setPetGender(foster.getPetGender());
        existingFoster.setPetBreed(foster.getPetBreed());
        existingFoster.setStartDate(foster.getStartDate());
        existingFoster.setEndDate(foster.getEndDate());
        existingFoster.setCity(foster.getCity());
        existingFoster.setAddress(foster.getAddress());
        existingFoster.setContactPhone(foster.getContactPhone());
        existingFoster.setContactWechat(foster.getContactWechat());
        existingFoster.setSpecialRequirements(foster.getSpecialRequirements());
        existingFoster.setDailyFee(foster.getDailyFee());
        existingFoster.setUpdateTime(new Date());

        // 重新计算天数
        if (existingFoster.getStartDate() != null && existingFoster.getEndDate() != null) {
            long diff = existingFoster.getEndDate().getTime() - existingFoster.getStartDate().getTime();
            int days = (int) (diff / (1000 * 60 * 60 * 24));
            existingFoster.setDurationDays(Math.max(days, 1));
        }

        return fosterRepository.save(existingFoster);
    }

    @Override
    public void deleteFoster(Long id) {
        Foster foster = getFosterById(id);

        if (foster.getStatus() != Foster.FosterStatus.PENDING) {
            throw new RuntimeException("只有待寄养状态的需求可以删除");
        }

        fosterRepository.deleteById(id);
    }

    @Override
    public Foster getFosterById(Long id) {
        return fosterRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("寄养需求不存在"));
    }

    @Override
    public Page<Foster> getAllFosters(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("createTime").descending());
        return fosterRepository.findByStatus(Foster.FosterStatus.PENDING, pageable);
    }

    @Override
    public Page<Foster> searchFosters(String city, Foster.PetType petType, Date startDate,
            Date endDate, Double maxFee, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("createTime").descending());
        return fosterRepository.searchFosters(city, petType, startDate, endDate, maxFee, pageable);
    }

    @Override
    public List<Foster> getFostersByUser(Long userId) {
        return fosterRepository.findByUserIdOrderByCreateTimeDesc(userId);
    }

    @Override
    public List<Foster> getAppliedFosters(Long userId) {
        return fosterRepository.findByApplicantIdAndStatusIn(
                userId,
                List.of(Foster.FosterStatus.MATCHED, Foster.FosterStatus.IN_PROGRESS));
    }

    @Override
    public Foster applyFoster(Long fosterId, Long userId, String message) {
        Foster foster = getFosterById(fosterId);

        if (foster.getStatus() != Foster.FosterStatus.PENDING) {
            throw new RuntimeException("该寄养需求不可申请");
        }

        if (foster.getApplicantId() != null) {
            throw new RuntimeException("已有用户申请该寄养需求");
        }

        if (foster.getUser().getId().equals(userId)) {
            throw new RuntimeException("不能申请自己发布的寄养需求");
        }

        User applicant = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));

        foster.setApplicantId(userId);
        foster.setApplyDate(new Date());
        foster.setStatus(Foster.FosterStatus.MATCHED);
        foster.setUpdateTime(new Date());

        return fosterRepository.save(foster);
    }

    @Override
    public Foster confirmFoster(Long fosterId, Long applicantId) {
        Foster foster = getFosterById(fosterId);

        if (!foster.getApplicantId().equals(applicantId)) {
            throw new RuntimeException("申请用户不匹配");
        }

        foster.setStatus(Foster.FosterStatus.IN_PROGRESS);
        foster.setUpdateTime(new Date());

        return fosterRepository.save(foster);
    }

    @Override
    public void cancelApplication(Long fosterId, Long userId) {
        Foster foster = getFosterById(fosterId);

        if (!foster.getApplicantId().equals(userId)) {
            throw new RuntimeException("无权取消该申请");
        }

        if (foster.getStatus() != Foster.FosterStatus.MATCHED) {
            throw new RuntimeException("当前状态不可取消申请");
        }

        foster.setApplicantId(null);
        foster.setApplyDate(null);
        foster.setStatus(Foster.FosterStatus.PENDING);
        foster.setUpdateTime(new Date());

        fosterRepository.save(foster);
    }

    @Override
    public Foster completeFoster(Long fosterId, Integer rating, String review) {
        Foster foster = getFosterById(fosterId);

        if (foster.getStatus() != Foster.FosterStatus.IN_PROGRESS) {
            throw new RuntimeException("只有寄养中的需求可以完成");
        }

        foster.setStatus(Foster.FosterStatus.COMPLETED);
        foster.setCompleteDate(new Date());
        foster.setRating(rating);
        foster.setReview(review);
        foster.setUpdateTime(new Date());

        return fosterRepository.save(foster);
    }

    @Override
    public Foster updateFosterStatus(Long id, Foster.FosterStatus status) {
        Foster foster = getFosterById(id);
        foster.setStatus(status);
        foster.setUpdateTime(new Date());
        return fosterRepository.save(foster);
    }
}