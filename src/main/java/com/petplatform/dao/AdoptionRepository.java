package com.petplatform.dao;

import com.petplatform.entity.Adoption;
import com.petplatform.entity.Adoption.AdoptionStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository; // 修正：JpaRepository（不是Jpakepository）
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param; // 修正：Param（不是Paran）
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface AdoptionRepository extends JpaRepository<Adoption, Long> {

        List<Adoption> findByUserId(Long userId);

        List<Adoption> findByPetId(Long petId);

        List<Adoption> findByStatus(AdoptionStatus status);

        Page<Adoption> findByStatus(AdoptionStatus status, Pageable pageable);

        boolean existsByPetIdAndStatus(Long petId, AdoptionStatus status);

        @Query("SELECT a FROM Adoption a WHERE a.user.id = :userId AND a.status = :status")
        List<Adoption> findByUserIdAndStatus(@Param("userId") Long userId,
                        @Param("status") AdoptionStatus status);

        @Query("SELECT COUNT(a) FROM Adoption a WHERE a.status = 'PENDING'")
        Long countPendingAdoptions();

        @Query("SELECT a FROM Adoption a WHERE a.applicationDate BETWEEN :startDate AND :endDate")
        List<Adoption> findAdoptionsByDateRange(@Param("startDate") Date startDate, @Param("endDate") Date endDate);
}