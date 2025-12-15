package com.petplatform.service;

import com.petplatform.entity.Donation;
import com.petplatform.entity.DonationRecord;
import com.petplatform.entity.User;
import org.springframework.data.domain.Page;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface DonationService {

    // 捐赠项目管理
    Donation createDonation(Donation donation, User user);

    Donation updateDonation(Long id, Donation donation);

    void deleteDonation(Long id);

    Donation getDonationById(Long id);

    Page<Donation> getAllDonations(int page, int size);

    Page<Donation> getActiveDonations(int page, int size);

    List<Donation> getFeaturedDonations();

    Page<Donation> searchDonations(String keyword, Donation.DonationType type,
            Donation.DonationStatus status, int page, int size);

    Donation updateDonationStatus(Long id, Donation.DonationStatus status);

    // 捐赠记录管理
    DonationRecord createDonationRecord(DonationRecord record);

    Page<DonationRecord> getDonationRecords(Long donationId, int page, int size);

    Page<DonationRecord> getUserDonationRecords(Long userId, int page, int size);

    DonationRecord getDonationRecordById(Long id);

    void updateDonationRecord(DonationRecord record);

    // 捐赠处理
    Map<String, Object> processMoneyDonation(Long donationId, User user,
            Double amount, String paymentMethod,
            String message, Boolean isAnonymous);

    Map<String, Object> processItemDonation(Long donationId, User user,
            String itemName, Integer itemCount,
            Double itemValue, String message,
            Boolean isAnonymous);

    Map<String, Object> processVolunteerDonation(Long donationId, User user,
            Integer volunteerHours,
            String message, Boolean isAnonymous);

    // 统计数据
    Map<String, Object> getDonationStats(Long donationId);

    Map<String, Object> getUserDonationStats(Long userId);

    Map<String, Object> getOverallStats();

    List<Map<String, Object>> getRecentDonations(int limit);

    List<Map<String, Object>> getTopDonors(int limit);

    // 更新捐赠进度
    void updateDonationProgress(Long donationId, String progress);

    void addDonationImage(Long donationId, String imageUrl);

    // 证书和发票管理
    void generateCertificate(Long recordId);

    void sendCertificate(Long recordId);

    void generateInvoice(Long recordId);

    void sendInvoice(Long recordId);
}