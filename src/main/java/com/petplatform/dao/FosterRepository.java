package com.petplatform.dao;

import com.petplatform.entity.Foster;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface FosterRepository extends JpaRepository<Foster, Long> {

        Page<Foster> findByStatus(Foster.FosterStatus status, Pageable pageable);

        List<Foster> findByUserIdOrderByCreateTimeDesc(Long userId);

        List<Foster> findByApplicantIdAndStatusIn(Long applicantId, List<Foster.FosterStatus> statuses);

        @Query("SELECT f FROM Foster f WHERE " +
                        "(:city IS NULL OR f.city LIKE %:city%) AND " +
                        "(:petType IS NULL OR f.petType = :petType) AND " +
                        "(:startDate IS NULL OR f.startDate >= :startDate) AND " +
                        "(:endDate IS NULL OR f.endDate <= :endDate) AND " +
                        "(:maxFee IS NULL OR f.dailyFee <= :maxFee) AND " +
                        "f.status = 'PENDING'")
        Page<Foster> searchFosters(@Param("city") String city,
                        @Param("petType") Foster.PetType petType, // 使用 Foster.PetType
                        @Param("startDate") Date startDate,
                        @Param("endDate") Date endDate,
                        @Param("maxFee") Double maxFee,
                        Pageable pageable);

        @Query("SELECT COUNT(f) FROM Foster f WHERE f.user.id = :userId AND f.status = 'COMPLETED'")
        Long countCompletedFostersByUser(@Param("userId") Long userId);

        @Query("SELECT AVG(f.rating) FROM Foster f WHERE f.user.id = :userId AND f.rating IS NOT NULL")
        Double getAverageRatingByUser(@Param("userId") Long userId);
}