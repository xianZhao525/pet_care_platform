package com.petplatform.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "donation_records")
public class DonationRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "donation_id", nullable = false)
    private Donation donation;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "type")
    @Enumerated(EnumType.STRING)
    private Donation.DonationType type;

    @Column(name = "amount")
    private Double amount;

    @Column(name = "item_name", length = 200)
    private String itemName;

    @Column(name = "item_count")
    private Integer itemCount;

    @Column(name = "item_value")
    private Double itemValue;

    @Column(name = "volunteer_hours")
    private Integer volunteerHours;

    @Column(name = "payment_method", length = 50)
    private String paymentMethod;

    @Column(name = "payment_status", length = 20)
    private String paymentStatus;

    @Column(name = "transaction_id", length = 100)
    private String transactionId;

    @Column(name = "donor_name", length = 100)
    private String donorName;

    @Column(name = "donor_phone", length = 20)
    private String donorPhone;

    @Column(name = "donor_email", length = 100)
    private String donorEmail;

    @Column(name = "donor_address", length = 500)
    private String donorAddress;

    @Column(name = "message", length = 1000)
    private String message;

    @Column(name = "is_anonymous")
    private Boolean isAnonymous = false;

    @Column(name = "donation_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date donationTime;

    @Column(name = "delivery_status", length = 50)
    private String deliveryStatus; // 物资配送状态

    @Column(name = "delivery_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date deliveryTime;

    @Column(name = "delivery_notes", length = 500)
    private String deliveryNotes;

    @Column(name = "certificate_number", length = 50)
    private String certificateNumber; // 捐赠证书编号

    @Column(name = "certificate_sent")
    private Boolean certificateSent = false;

    @Column(name = "certificate_sent_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date certificateSentTime;

    @Column(name = "invoice_required")
    private Boolean invoiceRequired = false;

    @Column(name = "invoice_sent")
    private Boolean invoiceSent = false;

    @Column(name = "invoice_number", length = 50)
    private String invoiceNumber;

    @Column(name = "create_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime;

    @Column(name = "update_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime;

    // Constructors
    public DonationRecord() {
        this.donationTime = new Date();
        this.createTime = new Date();
        this.updateTime = new Date();
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Donation getDonation() {
        return donation;
    }

    public void setDonation(Donation donation) {
        this.donation = donation;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Donation.DonationType getType() {
        return type;
    }

    public void setType(Donation.DonationType type) {
        this.type = type;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
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

    public Double getItemValue() {
        return itemValue;
    }

    public void setItemValue(Double itemValue) {
        this.itemValue = itemValue;
    }

    public Integer getVolunteerHours() {
        return volunteerHours;
    }

    public void setVolunteerHours(Integer volunteerHours) {
        this.volunteerHours = volunteerHours;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getDonorName() {
        return donorName;
    }

    public void setDonorName(String donorName) {
        this.donorName = donorName;
    }

    public String getDonorPhone() {
        return donorPhone;
    }

    public void setDonorPhone(String donorPhone) {
        this.donorPhone = donorPhone;
    }

    public String getDonorEmail() {
        return donorEmail;
    }

    public void setDonorEmail(String donorEmail) {
        this.donorEmail = donorEmail;
    }

    public String getDonorAddress() {
        return donorAddress;
    }

    public void setDonorAddress(String donorAddress) {
        this.donorAddress = donorAddress;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Boolean getIsAnonymous() {
        return isAnonymous;
    }

    public void setIsAnonymous(Boolean isAnonymous) {
        this.isAnonymous = isAnonymous;
    }

    public Date getDonationTime() {
        return donationTime;
    }

    public void setDonationTime(Date donationTime) {
        this.donationTime = donationTime;
    }

    public String getDeliveryStatus() {
        return deliveryStatus;
    }

    public void setDeliveryStatus(String deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
    }

    public Date getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(Date deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public String getDeliveryNotes() {
        return deliveryNotes;
    }

    public void setDeliveryNotes(String deliveryNotes) {
        this.deliveryNotes = deliveryNotes;
    }

    public String getCertificateNumber() {
        return certificateNumber;
    }

    public void setCertificateNumber(String certificateNumber) {
        this.certificateNumber = certificateNumber;
    }

    public Boolean getCertificateSent() {
        return certificateSent;
    }

    public void setCertificateSent(Boolean certificateSent) {
        this.certificateSent = certificateSent;
    }

    public Date getCertificateSentTime() {
        return certificateSentTime;
    }

    public void setCertificateSentTime(Date certificateSentTime) {
        this.certificateSentTime = certificateSentTime;
    }

    public Boolean getInvoiceRequired() {
        return invoiceRequired;
    }

    public void setInvoiceRequired(Boolean invoiceRequired) {
        this.invoiceRequired = invoiceRequired;
    }

    public Boolean getInvoiceSent() {
        return invoiceSent;
    }

    public void setInvoiceSent(Boolean invoiceSent) {
        this.invoiceSent = invoiceSent;
    }

    public String getInvoiceNumber() {
        return invoiceNumber;
    }

    public void setInvoiceNumber(String invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
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
}