package com.petplatform.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "fosters")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Foster {

    public enum FosterStatus {
        PENDING, APPROVED, REJECTED, IN_PROGRESS, COMPLETED
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "pet_id", nullable = false)
    private Pet pet;

    @Column(name = "apply_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date applyTime = new Date();

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private FosterStatus status = FosterStatus.PENDING;

    @Column(name = "start_date")
    @Temporal(TemporalType.DATE)
    private Date startDate;

    @Column(name = "end_date")
    @Temporal(TemporalType.DATE)
    private Date endDate;

    @Column(name = "foster_reason", columnDefinition = "TEXT")
    private String fosterReason;

    @Column(name = "daily_fee")
    private Double dailyFee = 0.0;

    @Column(name = "total_fee")
    private Double totalFee = 0.0;

    @Column(name = "foster_address", length = 200)
    private String fosterAddress;

    @Column(name = "foster_phone", length = 20)
    private String fosterPhone;

    @Column(name = "emergency_contact", length = 20)
    private String emergencyContact;

    @Column(name = "special_requirements", columnDefinition = "TEXT")
    private String specialRequirements;

    @Column(name = "admin_notes", columnDefinition = "TEXT")
    private String adminNotes;

    @Column(name = "approve_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date approveTime;
}