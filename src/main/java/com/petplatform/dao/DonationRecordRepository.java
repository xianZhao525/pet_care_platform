package com.petplatform.dao;

import com.petplatform.entity.DonationRecord;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DonationRecordRepository extends JpaRepository<DonationRecord, Long> {

    Page<DonationRecord> findByDonationId(Long donationId, Pageable pageable);

    Page<DonationRecord> findByUserId(Long userId, Pageable pageable);

    List<DonationRecord> findByDonationId(Long donationId);

    List<DonationRecord> findByUserId(Long userId);

    List<DonationRecord> findTop10ByOrderByDonationTimeDesc();

    @Query("SELECT COUNT(DISTINCT dr.user.id) FROM DonationRecord dr")
    Long countDistinctUsers();

    @Query("SELECT dr.user.id, dr.user.name, SUM(dr.amount), COUNT(dr.id) " +
            "FROM DonationRecord dr " +
            "WHERE dr.type = 'MONEY' AND dr.amount IS NOT NULL " +
            "GROUP BY dr.user.id, dr.user.name " +
            "ORDER BY SUM(dr.amount) DESC")
    List<Object[]> findTopDonors(@Param("limit") int limit);

    @Query("SELECT dr FROM DonationRecord dr WHERE dr.donation.id = :donationId AND dr.user.id = :userId")
    List<DonationRecord> findByDonationIdAndUserId(@Param("donationId") Long donationId,
            @Param("userId") Long userId);
}