package com.petplatform.service.impl;

import com.petplatform.dao.DonationRepository;
import com.petplatform.dao.DonationRecordRepository;
import com.petplatform.dao.UserRepository;
import com.petplatform.entity.Donation;
import com.petplatform.entity.DonationRecord;
import com.petplatform.entity.User;
import com.petplatform.service.DonationService;
import com.petplatform.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class DonationServiceImpl implements DonationService {

    @Autowired
    private DonationRepository donationRepository;

    @Autowired
    private DonationRecordRepository donationRecordRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public Donation createDonation(Donation donation, User user) {
        donation.setCreateUserId(user.getId());
        donation.setCreateTime(new Date());
        donation.setUpdateTime(new Date());

        if (donation.getStartDate() == null) {
            donation.setStartDate(new Date());
        }

        if (donation.getStatus() == null) {
            donation.setStatus(Donation.DonationStatus.PLANNING);
        }

        if (donation.getCurrentAmount() == null) {
            donation.setCurrentAmount(0.0);
        }

        if (donation.getItemReceived() == null) {
            donation.setItemReceived(0);
        }

        return donationRepository.save(donation);
    }

    @Override
    public Donation updateDonation(Long id, Donation donation) {
        Donation existingDonation = getDonationById(id);

        existingDonation.setTitle(donation.getTitle());
        existingDonation.setDescription(donation.getDescription());
        existingDonation.setType(donation.getType());
        existingDonation.setTargetAmount(donation.getTargetAmount());
        existingDonation.setUnitPrice(donation.getUnitPrice());
        existingDonation.setItemName(donation.getItemName());
        existingDonation.setItemCount(donation.getItemCount());
        existingDonation.setCoverImage(donation.getCoverImage());
        existingDonation.setImages(donation.getImages());
        existingDonation.setStartDate(donation.getStartDate());
        existingDonation.setEndDate(donation.getEndDate());
        existingDonation.setBeneficiary(donation.getBeneficiary());
        existingDonation.setContactPerson(donation.getContactPerson());
        existingDonation.setContactPhone(donation.getContactPhone());
        existingDonation.setContactAddress(donation.getContactAddress());
        existingDonation.setProgress(donation.getProgress());
        existingDonation.setIsFeatured(donation.getIsFeatured());
        existingDonation.setSortOrder(donation.getSortOrder());
        existingDonation.setUpdateTime(new Date());

        return donationRepository.save(existingDonation);
    }

    @Override
    public void deleteDonation(Long id) {
        donationRepository.deleteById(id);
    }

    @Override
    public Donation getDonationById(Long id) {
        return donationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("捐赠项目不存在"));
    }

    @Override
    public Page<Donation> getAllDonations(int page, int size) {
        Pageable pageable = PageRequest.of(page, size,
                Sort.by(Sort.Order.desc("isFeatured"),
                        Sort.Order.asc("sortOrder"),
                        Sort.Order.desc("createTime")));
        return donationRepository.findAll(pageable);
    }

    @Override
    public Page<Donation> getActiveDonations(int page, int size) {
        Pageable pageable = PageRequest.of(page, size,
                Sort.by(Sort.Order.desc("isFeatured"),
                        Sort.Order.asc("sortOrder"),
                        Sort.Order.desc("createTime")));
        return donationRepository.findByStatus(Donation.DonationStatus.ONGOING, pageable);
    }

    @Override
    public List<Donation> getFeaturedDonations() {
        return donationRepository.findByIsFeaturedTrueAndStatusOrderBySortOrderAscCreateTimeDesc(
                Donation.DonationStatus.ONGOING);
    }

    @Override
    public Page<Donation> searchDonations(String keyword, Donation.DonationType type,
            Donation.DonationStatus status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size,
                Sort.by(Sort.Order.desc("isFeatured"),
                        Sort.Order.asc("sortOrder"),
                        Sort.Order.desc("createTime")));

        if (keyword == null && type == null && status == null) {
            return donationRepository.findAll(pageable);
        }

        return donationRepository.searchDonations(keyword, type, status, pageable);
    }

    @Override
    public Donation updateDonationStatus(Long id, Donation.DonationStatus status) {
        Donation donation = getDonationById(id);
        donation.setStatus(status);
        donation.setUpdateTime(new Date());
        return donationRepository.save(donation);
    }

    @Override
    public DonationRecord createDonationRecord(DonationRecord record) {
        record.setCreateTime(new Date());
        record.setUpdateTime(new Date());

        if (record.getDonationTime() == null) {
            record.setDonationTime(new Date());
        }

        if (record.getPaymentStatus() == null) {
            record.setPaymentStatus("PENDING");
        }

        if (record.getIsAnonymous() == null) {
            record.setIsAnonymous(false);
        }

        return donationRecordRepository.save(record);
    }

    @Override
    public Page<DonationRecord> getDonationRecords(Long donationId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size,
                Sort.by(Sort.Order.desc("donationTime")));
        return donationRecordRepository.findByDonationId(donationId, pageable);
    }

    @Override
    public Page<DonationRecord> getUserDonationRecords(Long userId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size,
                Sort.by(Sort.Order.desc("donationTime")));
        return donationRecordRepository.findByUserId(userId, pageable);
    }

    @Override
    public DonationRecord getDonationRecordById(Long id) {
        return donationRecordRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("捐赠记录不存在"));
    }

    @Override
    public void updateDonationRecord(DonationRecord record) {
        DonationRecord existingRecord = getDonationRecordById(record.getId());

        existingRecord.setPaymentStatus(record.getPaymentStatus());
        existingRecord.setTransactionId(record.getTransactionId());
        existingRecord.setDeliveryStatus(record.getDeliveryStatus());
        existingRecord.setDeliveryTime(record.getDeliveryTime());
        existingRecord.setDeliveryNotes(record.getDeliveryNotes());
        existingRecord.setCertificateNumber(record.getCertificateNumber());
        existingRecord.setCertificateSent(record.getCertificateSent());
        existingRecord.setCertificateSentTime(record.getCertificateSentTime());
        existingRecord.setInvoiceNumber(record.getInvoiceNumber());
        existingRecord.setInvoiceSent(record.getInvoiceSent());
        existingRecord.setUpdateTime(new Date());

        donationRecordRepository.save(existingRecord);
    }

    @Override
    public Map<String, Object> processMoneyDonation(Long donationId, User user,
            Double amount, String paymentMethod,
            String message, Boolean isAnonymous) {
        Donation donation = getDonationById(donationId);

        if (donation.getStatus() != Donation.DonationStatus.ONGOING) {
            throw new RuntimeException("该捐赠项目当前不可接受捐赠");
        }

        DonationRecord record = new DonationRecord();
        record.setDonation(donation);
        record.setUser(user);
        record.setType(Donation.DonationType.MONEY);
        record.setAmount(amount);
        record.setPaymentMethod(paymentMethod);
        record.setPaymentStatus("PENDING");
        record.setDonorName(user.getName());
        record.setDonorPhone(user.getPhone());
        record.setDonorEmail(user.getEmail());
        record.setMessage(message);
        record.setIsAnonymous(isAnonymous != null ? isAnonymous : false);

        createDonationRecord(record);

        // 更新捐赠项目当前金额
        donation.setCurrentAmount(donation.getCurrentAmount() + amount);
        donation.setUpdateTime(new Date());
        donationRepository.save(donation);

        // 生成证书编号
        String certNumber = "DON-" + System.currentTimeMillis() + "-" + record.getId();
        record.setCertificateNumber(certNumber);
        donationRecordRepository.save(record);

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("record", record);
        result.put("certificateNumber", certNumber);
        result.put("message", "捐赠提交成功，请完成支付");

        return result;
    }

    @Override
    public Map<String, Object> processItemDonation(Long donationId, User user,
            String itemName, Integer itemCount,
            Double itemValue, String message,
            Boolean isAnonymous) {
        Donation donation = getDonationById(donationId);

        if (donation.getStatus() != Donation.DonationStatus.ONGOING) {
            throw new RuntimeException("该捐赠项目当前不可接受捐赠");
        }

        DonationRecord record = new DonationRecord();
        record.setDonation(donation);
        record.setUser(user);
        record.setType(Donation.DonationType.ITEMS);
        record.setItemName(itemName);
        record.setItemCount(itemCount);
        record.setItemValue(itemValue);
        record.setDonorName(user.getName());
        record.setDonorPhone(user.getPhone());
        record.setDonorEmail(user.getEmail());
        record.setDonorAddress(user.getAddress());
        record.setMessage(message);
        record.setIsAnonymous(isAnonymous != null ? isAnonymous : false);
        record.setDeliveryStatus("WAITING"); // 等待配送

        createDonationRecord(record);

        // 更新捐赠项目物资接收数量
        donation.setItemReceived(donation.getItemReceived() + itemCount);
        donation.setUpdateTime(new Date());
        donationRepository.save(donation);

        // 生成证书编号
        String certNumber = "ITEM-" + System.currentTimeMillis() + "-" + record.getId();
        record.setCertificateNumber(certNumber);
        donationRecordRepository.save(record);

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("record", record);
        result.put("certificateNumber", certNumber);
        result.put("message", "物资捐赠提交成功");

        return result;
    }

    @Override
    public Map<String, Object> processVolunteerDonation(Long donationId, User user,
            Integer volunteerHours,
            String message, Boolean isAnonymous) {
        Donation donation = getDonationById(donationId);

        if (donation.getStatus() != Donation.DonationStatus.ONGOING) {
            throw new RuntimeException("该捐赠项目当前不可接受志愿服务");
        }

        DonationRecord record = new DonationRecord();
        record.setDonation(donation);
        record.setUser(user);
        record.setType(Donation.DonationType.VOLUNTEER);
        record.setVolunteerHours(volunteerHours);
        record.setDonorName(user.getName());
        record.setDonorPhone(user.getPhone());
        record.setDonorEmail(user.getEmail());
        record.setMessage(message);
        record.setIsAnonymous(isAnonymous != null ? isAnonymous : false);

        createDonationRecord(record);

        // 生成证书编号
        String certNumber = "VOL-" + System.currentTimeMillis() + "-" + record.getId();
        record.setCertificateNumber(certNumber);
        donationRecordRepository.save(record);

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("record", record);
        result.put("certificateNumber", certNumber);
        result.put("message", "志愿服务报名成功");

        return result;
    }

    @Override
    public Map<String, Object> getDonationStats(Long donationId) {
        Donation donation = getDonationById(donationId);

        List<DonationRecord> records = donationRecordRepository.findByDonationId(donationId);

        Map<String, Object> stats = new HashMap<>();
        stats.put("donation", donation);
        stats.put("totalRecords", records.size());

        // 统计金额捐赠
        Double totalMoney = records.stream()
                .filter(r -> r.getType() == Donation.DonationType.MONEY)
                .mapToDouble(DonationRecord::getAmount)
                .sum();
        stats.put("totalMoney", totalMoney);

        // 统计物资捐赠
        Integer totalItems = records.stream()
                .filter(r -> r.getType() == Donation.DonationType.ITEMS)
                .mapToInt(DonationRecord::getItemCount)
                .sum();
        stats.put("totalItems", totalItems);

        // 统计志愿服务
        Integer totalVolunteerHours = records.stream()
                .filter(r -> r.getType() == Donation.DonationType.VOLUNTEER)
                .mapToInt(DonationRecord::getVolunteerHours)
                .sum();
        stats.put("totalVolunteerHours", totalVolunteerHours);

        // 捐赠者数量
        long donorCount = records.stream()
                .map(DonationRecord::getUser)
                .distinct()
                .count();
        stats.put("donorCount", donorCount);

        return stats;
    }

    @Override
    public Map<String, Object> getUserDonationStats(Long userId) {
        List<DonationRecord> records = donationRecordRepository.findByUserId(userId);

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalDonations", records.size());

        // 统计各类捐赠
        Double totalMoney = records.stream()
                .filter(r -> r.getType() == Donation.DonationType.MONEY)
                .mapToDouble(DonationRecord::getAmount)
                .sum();
        stats.put("totalMoney", totalMoney);

        Integer totalItems = records.stream()
                .filter(r -> r.getType() == Donation.DonationType.ITEMS)
                .mapToInt(DonationRecord::getItemCount)
                .sum();
        stats.put("totalItems", totalItems);

        Integer totalVolunteerHours = records.stream()
                .filter(r -> r.getType() == Donation.DonationType.VOLUNTEER)
                .mapToInt(DonationRecord::getVolunteerHours)
                .sum();
        stats.put("totalVolunteerHours", totalVolunteerHours);

        return stats;
    }

    @Override
    public Map<String, Object> getOverallStats() {
        Map<String, Object> stats = new HashMap<>();

        // 总捐赠项目数
        Long totalProjects = donationRepository.count();
        stats.put("totalProjects", totalProjects);

        // 活跃项目数
        Long activeProjects = donationRepository.countByStatus(Donation.DonationStatus.ONGOING);
        stats.put("activeProjects", activeProjects);

        // 完成项目数
        Long completedProjects = donationRepository.countByStatus(Donation.DonationStatus.COMPLETED);
        stats.put("completedProjects", completedProjects);

        // 总捐赠金额
        Double totalDonationAmount = donationRepository.getTotalDonationAmount();
        stats.put("totalDonationAmount", totalDonationAmount != null ? totalDonationAmount : 0.0);

        // 总捐赠人数
        Long totalDonors = donationRecordRepository.countDistinctUsers();
        stats.put("totalDonors", totalDonors);

        // 最近捐赠
        List<DonationRecord> recentRecords = donationRecordRepository.findTop10ByOrderByDonationTimeDesc();
        stats.put("recentDonations", recentRecords);

        return stats;
    }

    @Override
    public List<Map<String, Object>> getRecentDonations(int limit) {
        List<DonationRecord> records = donationRecordRepository.findTop10ByOrderByDonationTimeDesc();

        return records.stream().map(record -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", record.getId());
            map.put("donorName", record.getIsAnonymous() ? "匿名用户" : record.getDonorName());
            map.put("type", record.getType());
            map.put("amount", record.getAmount());
            map.put("itemName", record.getItemName());
            map.put("itemCount", record.getItemCount());
            map.put("volunteerHours", record.getVolunteerHours());
            map.put("donationTime", record.getDonationTime());
            map.put("message", record.getMessage());
            map.put("projectTitle", record.getDonation().getTitle());
            return map;
        }).collect(Collectors.toList());
    }

    @Override
    public List<Map<String, Object>> getTopDonors(int limit) {
        List<Object[]> topDonors = donationRecordRepository.findTopDonors(limit);

        return topDonors.stream().map(row -> {
            Map<String, Object> map = new HashMap<>();
            map.put("userId", row[0]);
            map.put("name", row[1]);
            map.put("totalAmount", row[2]);
            map.put("donationCount", row[3]);
            return map;
        }).collect(Collectors.toList());
    }

    @Override
    public void updateDonationProgress(Long donationId, String progress) {
        Donation donation = getDonationById(donationId);
        donation.setProgress(progress);
        donation.setUpdateTime(new Date());
        donationRepository.save(donation);
    }

    @Override
    public void addDonationImage(Long donationId, String imageUrl) {
        Donation donation = getDonationById(donationId);

        String currentImages = donation.getImages();
        if (currentImages == null || currentImages.isEmpty()) {
            donation.setImages("[\"" + imageUrl + "\"]");
        } else {
            donation.setImages(currentImages.replace("]", ",\"" + imageUrl + "\"]"));
        }

        donation.setUpdateTime(new Date());
        donationRepository.save(donation);
    }

    @Override
    public void generateCertificate(Long recordId) {
        DonationRecord record = getDonationRecordById(recordId);

        if (record.getCertificateNumber() == null) {
            String certNumber = "CERT-" + System.currentTimeMillis() + "-" + record.getId();
            record.setCertificateNumber(certNumber);
        }

        record.setUpdateTime(new Date());
        donationRecordRepository.save(record);
    }

    @Override
    public void sendCertificate(Long recordId) {
        DonationRecord record = getDonationRecordById(recordId);

        record.setCertificateSent(true);
        record.setCertificateSentTime(new Date());
        record.setUpdateTime(new Date());

        donationRecordRepository.save(record);
    }

    @Override
    public void generateInvoice(Long recordId) {
        DonationRecord record = getDonationRecordById(recordId);

        if (record.getInvoiceNumber() == null) {
            String invoiceNumber = "INV-" + System.currentTimeMillis() + "-" + record.getId();
            record.setInvoiceNumber(invoiceNumber);
        }

        record.setUpdateTime(new Date());
        donationRecordRepository.save(record);
    }

    @Override
    public void sendInvoice(Long recordId) {
        DonationRecord record = getDonationRecordById(recordId);

        record.setInvoiceSent(true);
        record.setUpdateTime(new Date());

        donationRecordRepository.save(record);
    }
}