package com.petplatform.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "donations")
public class Donation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @Column(name = "description", length = 2000)
    private String description;

    @Column(name = "type")
    @Enumerated(EnumType.STRING)
    private DonationType type;

    @Column(name = "target_amount")
    private Double targetAmount;

    @Column(name = "current_amount")
    private Double currentAmount = 0.0;

    @Column(name = "unit_price")
    private Double unitPrice;

    @Column(name = "item_name", length = 200)
    private String itemName;

    @Column(name = "item_count")
    private Integer itemCount;

    @Column(name = "item_received")
    private Integer itemReceived = 0;

    @Column(name = "cover_image", length = 500)
    private String coverImage;

    @Column(name = "images", length = 2000)
    private String images; // JSON格式存储多个图片

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private DonationStatus status;

    @Column(name = "start_date")
    @Temporal(TemporalType.DATE)
    private Date startDate;

    @Column(name = "end_date")
    @Temporal(TemporalType.DATE)
    private Date endDate;

    @Column(name = "create_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime;

    @Column(name = "update_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime;

    @Column(name = "create_user_id")
    private Long createUserId;

    @Column(name = "beneficiary", length = 500)
    private String beneficiary; // 受益方

    @Column(name = "contact_person", length = 100)
    private String contactPerson;

    @Column(name = "contact_phone", length = 20)
    private String contactPhone;

    @Column(name = "contact_address", length = 500)
    private String contactAddress;

    @Column(name = "progress", columnDefinition = "TEXT")
    private String progress; // 捐赠进展

    @Column(name = "is_featured")
    private Boolean isFeatured = false;

    @Column(name = "sort_order")
    private Integer sortOrder = 0;

    public enum DonationType {
        MONEY, // 金钱捐赠
        ITEMS, // 物资捐赠
        VOLUNTEER, // 志愿服务
        BOTH // 金钱和物资
    }

    public enum DonationStatus {
        PLANNING, // 规划中
        ONGOING, // 进行中
        SUSPENDED, // 已暂停
        COMPLETED, // 已完成
        CLOSED // 已关闭
    }

    // Constructors
    public Donation() {
        this.createTime = new Date();
        this.updateTime = new Date();
        this.status = DonationStatus.PLANNING;
    }

    // 计算进度百分比
    @Transient
    public Double getProgressPercentage() {
        if (targetAmount == null || targetAmount == 0) {
            return 0.0;
        }
        return (currentAmount / targetAmount) * 100;
    }

    // 计算剩余天数
    @Transient
    public Long getRemainingDays() {
        if (endDate == null) {
            return null;
        }
        long diff = endDate.getTime() - new Date().getTime();
        return diff / (1000 * 60 * 60 * 24);
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

    public DonationType getType() {
        return type;
    }

    public void setType(DonationType type) {
        this.type = type;
    }

    public Double getTargetAmount() {
        return targetAmount;
    }

    public void setTargetAmount(Double targetAmount) {
        this.targetAmount = targetAmount;
    }

    public Double getCurrentAmount() {
        return currentAmount;
    }

    public void setCurrentAmount(Double currentAmount) {
        this.currentAmount = currentAmount;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public Integer getItemCount() {
        return itemCount;
    }

    public void setItemCount(Integer itemCount) {
        this.itemCount = itemCount;
    }

    public Integer getItemReceived() {
        return itemReceived;
    }

    public void setItemReceived(Integer itemReceived) {
        this.itemReceived = itemReceived;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public DonationStatus getStatus() {
        return status;
    }

    public void setStatus(DonationStatus status) {
        this.status = status;
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

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public String getBeneficiary() {
        return beneficiary;
    }

    public void setBeneficiary(String beneficiary) {
        this.beneficiary = beneficiary;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
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

    public String getProgress() {
        return progress;
    }

    public void setProgress(String progress) {
        this.progress = progress;
    }

    public Boolean getIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(Boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }
}