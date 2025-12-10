package com.petplatform.entity;

import lombok.Data;
import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "pets")
public class Pet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    private PetType type;

    @Enumerated(EnumType.STRING)
    private PetStatus status = PetStatus.AVAILABLE;

    private String breed;
    private Integer age;
    private String gender;
    private String color;
    private String description;
    private String healthStatus;
    private String vaccination;
    private String imageUrl = "default-pet.jpg";

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "owner_id")
    private User owner;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public enum PetType {
        DOG, CAT, RABBIT, BIRD, OTHER
    }

    public enum PetStatus {
        AVAILABLE, ADOPTED, FOSTERED, PENDING
    }
}