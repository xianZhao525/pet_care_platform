package com.petplatform.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "pets")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pet {

    public enum PetType {
        DOG, CAT, RABBIT, BIRD, OTHER
    }

    public enum PetStatus {
        AVAILABLE, PENDING_ADOPTION, ADOPTED, IN_FOSTER
    }

    public enum PetGender {
        MALE, FEMALE, UNKNOWN
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 50)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private PetType type;

    @Column(length = 50)
    private String breed;

    @Column
    private Integer age;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private PetGender gender = PetGender.UNKNOWN;

    @Column(length = 30)
    private String color;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "image_url")
    private String imageUrl = "/static/images/pets/default-pet.jpg";

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private PetStatus status = PetStatus.AVAILABLE;

    @Column(name = "health_status", length = 100)
    private String healthStatus = "健康";

    @Column(columnDefinition = "TEXT")
    private String vaccination = "未接种";

    @Column(name = "sterilized")
    private Boolean sterilized = false;

    @Column(name = "create_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime = new Date();

    @Column(name = "update_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime = new Date();

    @PreUpdate
    protected void onUpdate() {
        updateTime = new Date();
    }
}