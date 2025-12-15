package com.petplatform.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "adoptions")
public class Adoption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "pet_id", nullable = false)
    private Pet pet;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "application_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date applicationDate;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private AdoptionStatus status;

    @Column(name = "application_reason", length = 1000)
    private String applicationReason;

    @Column(name = "family_environment", length = 1000)
    private String familyEnvironment;

    @Column(name = "has_pet_experience")
    private Boolean hasPetExperience;

    @Column(name = "expected_care_time")
    private String expectedCareTime;

    @Column(name = "review_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date reviewDate;

    @Column(name = "review_notes", length = 1000)
    private String reviewNotes;

    @Column(name = "admin_id")
    private Long adminId;

    // ==== 新增字段 ====
    @Column(name = "family_members")
    private Integer familyMembers; // 家庭成员数量

    @Column(name = "house_type", length = 100)
    private String houseType; // 房屋类型：公寓/别墅/自建房等

    @Column(name = "contact_phone", length = 20)
    private String contactPhone; // 联系电话

    @Column(name = "contact_address", length = 500)
    private String contactAddress; // 联系地址

    @Column(name = "completion_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date completionDate; // 完成日期

    public enum AdoptionStatus {
        PENDING, // 待审核
        APPROVED, // 已批准
        REJECTED, // 已拒绝
        COMPLETED, // 已完成
        CANCELED // 已取消
    }

    // Constructors
    public Adoption() {
        this.applicationDate = new Date();
        this.status = AdoptionStatus.PENDING;
    }

    // ==== 新增字段的 Getter 和 Setter ====
    public Integer getFamilyMembers() {
        return familyMembers;
    }

    public void setFamilyMembers(Integer familyMembers) {
        this.familyMembers = familyMembers;
    }

    public String getHouseType() {
        return houseType;
    }

    public void setHouseType(String houseType) {
        this.houseType = houseType;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getContactAddress() {
        return contactAddress;
    }

    public void setContactAddress(String contactAddress) {
        this.contactAddress = contactAddress;
    }

    public Date getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(Date completionDate) {
        this.completionDate = completionDate;
    }

    // 原有的 Getter 和 Setter 保持不变...
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Pet getPet() {
        return pet;
    }

    public void setPet(Pet pet) {
        this.pet = pet;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(Date applicationDate) {
        this.applicationDate = applicationDate;
    }

    public AdoptionStatus getStatus() {
        return status;
    }

    public void setStatus(AdoptionStatus status) {
        this.status = status;
    }

    public String getApplicationReason() {
        return applicationReason;
    }

    public void setApplicationReason(String applicationReason) {
        this.applicationReason = applicationReason;
    }

    public String getFamilyEnvironment() {
        return familyEnvironment;
    }

    public void setFamilyEnvironment(String familyEnvironment) {
        this.familyEnvironment = familyEnvironment;
    }

    public Boolean getHasPetExperience() {
        return hasPetExperience;
    }

    public void setHasPetExperience(Boolean hasPetExperience) {
        this.hasPetExperience = hasPetExperience;
    }

    public String getExpectedCareTime() {
        return expectedCareTime;
    }

    public void setExpectedCareTime(String expectedCareTime) {
        this.expectedCareTime = expectedCareTime;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getReviewNotes() {
        return reviewNotes;
    }

    public void setReviewNotes(String reviewNotes) {
        this.reviewNotes = reviewNotes;
    }

    public Long getAdminId() {
        return adminId;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }
}