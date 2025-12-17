package com.petplatform.dao;

import com.petplatform.entity.Pet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PetRepository extends JpaRepository<Pet, Long> {

        List<Pet> findByStatus(Pet.PetStatus status);

        List<Pet> findByType(Pet.PetType type);

        List<Pet> findByOwnerId(Long ownerId);

        List<Pet> findByNameContainingIgnoreCase(String keyword);

        long countByStatus(Pet.PetStatus status);
}