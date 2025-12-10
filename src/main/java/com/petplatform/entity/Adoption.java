package com.petplatform.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "adoptions")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Adoption {

    public enum AdoptionStatus {
        PENDING, APPROVED, REJECTED, COMPLETED
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
    private AdoptionStatus status = AdoptionStatus.PENDING;

    @Column(columnDefinition = "TEXT")
    private String reason;

    @Column(name = "family_members")
    private Integer familyMembers;

    @Column(name = "has_pet_experience")
    private Boolean hasPetExperience = false;

    @Column(name = "house_type", length = 50)
    private String houseType;

    @Column(name = "approve_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date approveTime;

    @Column(name = "admin_notes", columnDefinition = "TEXT")
    private String adminNotes;

    @Column(name = "contact_phone", length = 20)
    private String contactPhone;

    @Column(name = "contact_address", length = 200)
    private String contactAddress;
}