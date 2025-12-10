package com.petplatform.dao;

import com.petplatform.entity.Pet;
import com.petplatform.entity.Pet.PetStatus;
import com.petplatform.entity.Pet.PetType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PetRepository extends JpaRepository<Pet, Long> {

        List<Pet> findByType(PetType type);

        List<Pet> findByStatus(PetStatus status);

        Page<Pet> findByStatus(PetStatus status, Pageable pageable);

        @Query("SELECT p FROM Pet p WHERE " +
                        "p.name LIKE %:keyword% OR " +
                        "p.breed LIKE %:keyword% OR " +
                        "p.description LIKE %:keyword%")
        List<Pet> searchPets(@Param("keyword") String keyword);

        @Query("SELECT p FROM Pet p WHERE " +
                        "(p.name LIKE %:keyword% OR p.breed LIKE %:keyword%) AND " +
                        "p.type = :type")
        List<Pet> searchPetsByType(@Param("keyword") String keyword,
                        @Param("type") PetType type);

        @Query("SELECT p FROM Pet p WHERE p.status = 'AVAILABLE' ORDER BY p.createTime DESC")
        List<Pet> findRecentAvailablePets(Pageable pageable);

        @Query("SELECT COUNT(p) FROM Pet p WHERE p.status = 'AVAILABLE'")
        long countAvailablePets();

        @Query("SELECT p.type, COUNT(p) FROM Pet p GROUP BY p.type")
        List<Object[]> countPetsByType();
}