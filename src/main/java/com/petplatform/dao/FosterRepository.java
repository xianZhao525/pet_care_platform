package com.petplatform.dao;

import com.petplatform.entity.Foster;
import com.petplatform.entity.Foster.FosterStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface FosterRepository extends JpaRepository<Foster, Long> {

        List<Foster> findByUserId(Long userId);

        List<Foster> findByPetId(Long petId);

        List<Foster> findByStatus(FosterStatus status);

        @Query("SELECT f FROM Foster f WHERE f.status = 'IN_PROGRESS' AND f.endDate < :currentDate")
        List<Foster> findOverdueFosters(@Param("currentDate") Date currentDate);

        @Query("SELECT COUNT(f) FROM Foster f WHERE f.status = 'PENDING'")
        long countPendingFosters();

        @Query("SELECT f FROM Foster f WHERE " +
                        "f.user.id = :userId AND " +
                        "f.status = :status")
        List<Foster> findByUserIdAndStatus(@Param("userId") Long userId,
                        @Param("status") FosterStatus status);
}