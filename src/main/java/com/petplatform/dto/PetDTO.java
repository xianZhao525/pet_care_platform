package com.petplatform.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class PetDTO {
    private Long id;
    private String name;
    private String type;
    private String status;
    private String breed;
    private Integer age;
    private String gender;
    private String color;
    private String description;
    private String healthStatus;
    private String vaccination;
    private String imageUrl;
    private LocalDateTime createdAt;
    private Long ownerId;
    private String ownerName;
}