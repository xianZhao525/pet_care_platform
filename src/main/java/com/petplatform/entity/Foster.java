package com.petplatform.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "fosters")
public class Foster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @Column(name = "description", length = 2000)
    private String description;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // 在 Foster 类中定义 PetType 枚举
    @Column(name = "pet_type")
    @Enumerated(EnumType.STRING)
    private PetType petType; // 使用 Foster 内部的 PetType

    @Column(name = "pet_name", length = 100)
    private String petName;

    @Column(name = "pet_age")
    private Integer petAge;

    @Column(name = "pet_gender")
    @Enumerated(EnumType.STRING)
    private Gender petGender; // 使用 Foster 内部的 Gender

    @Column(name = "pet_breed", length = 100)
    private String petBreed;

    @Column(name = "start_date")
    @Temporal(TemporalType.DATE)
    private Date startDate;

    @Column(name = "end_date")
    @Temporal(TemporalType.DATE)
    private Date endDate;

    @Column(name = "duration_days")
    private Integer durationDays;

    @Column(name = "city", length = 100)
    private String city;

    @Column(name = "address", length = 500)
    private String address;

    @Column(name = "contact_phone", length = 20)
    private String contactPhone;

    @Column(name = "contact_wechat", length = 100)
    private String contactWechat;

    @Column(name = "special_requirements", length = 1000)
    private String specialRequirements;

    @Column(name = "daily_fee")
    private Double dailyFee;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private FosterStatus status;

    @Column(name = "create_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime;

    @Column(name = "update_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime;

    @Column(name = "applicant_id")
    private Long applicantId;

    @Column(name = "apply_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date applyDate;

    @Column(name = "complete_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date completeDate;

    @Column(name = "rating")
    private Integer rating;

    @Column(name = "review", length = 1000)
    private String review;

    @Column(name = "image_url", length = 500)
    private String imageUrl;

    // Foster 状态枚举
    public enum FosterStatus {
        PENDING, // 待寄养
        MATCHED, // 已匹配
        IN_PROGRESS, // 寄养中
        COMPLETED, // 已完成
        CANCELED // 已取消
    }

    // Pet 类型枚举（在 Foster 类内部定义）
    public enum PetType {
        DOG, // 狗
        CAT, // 猫
        BIRD, // 鸟
        RABBIT, // 兔子
        HAMSTER, // 仓鼠
        OTHER // 其他
    }

    // 性别枚举（在 Foster 类内部定义）
    public enum Gender {
        MALE, // 雄性
        FEMALE, // 雌性
        UNKNOWN // 未知
    }

    // Constructors
    public Foster() {
        this.createTime = new Date();
        this.updateTime = new Date();
        this.status = FosterStatus.PENDING;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public PetType getPetType() {
        return petType;
    }

    public void setPetType(PetType petType) {
        this.petType = petType;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }

    public Integer getPetAge() {
        return petAge;
    }

    public void setPetAge(Integer petAge) {
        this.petAge = petAge;
    }

    public Gender getPetGender() {
        return petGender;
    }

    public void setPetGender(Gender petGender) {
        this.petGender = petGender;
    }

    public String getPetBreed() {
        return petBreed;
    }

    public void setPetBreed(String petBreed) {
        this.petBreed = petBreed;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(Integer durationDays) {
        this.durationDays = durationDays;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getContactWechat() {
        return contactWechat;
    }

    public void setContactWechat(String contactWechat) {
        this.contactWechat = contactWechat;
    }

    public String getSpecialRequirements() {
        return specialRequirements;
    }

    public void setSpecialRequirements(String specialRequirements) {
        this.specialRequirements = specialRequirements;
    }

    public Double getDailyFee() {
        return dailyFee;
    }

    public void setDailyFee(Double dailyFee) {
        this.dailyFee = dailyFee;
    }

    public FosterStatus getStatus() {
        return status;
    }

    public void setStatus(FosterStatus status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Long getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(Long applicantId) {
        this.applicantId = applicantId;
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public Date getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(Date completeDate) {
        this.completeDate = completeDate;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}