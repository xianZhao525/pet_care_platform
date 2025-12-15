package com.petplatform.dao;

import com.petplatform.entity.Donation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DonationRepository extends JpaRepository<Donation, Long> {

    Page<Donation> findByStatus(Donation.DonationStatus status, Pageable pageable);

    List<Donation> findByIsFeaturedTrueAndStatusOrderBySortOrderAscCreateTimeDesc(Donation.DonationStatus status);

    Long countByStatus(Donation.DonationStatus status);

    @Query("SELECT SUM(d.currentAmount) FROM Donation d WHERE d.status = 'COMPLETED' OR d.status = 'ONGOING'")
    Double getTotalDonationAmount();

    @Query("SELECT d FROM Donation d WHERE " +
            "(:keyword IS NULL OR d.title LIKE %:keyword% OR d.description LIKE %:keyword%) AND " +
            "(:type IS NULL OR d.type = :type) AND " +
            "(:status IS NULL OR d.status = :status)")
    Page<Donation> searchDonations(@Param("keyword") String keyword,
            @Param("type") Donation.DonationType type,
            @Param("status") Donation.DonationStatus status,
            Pageable pageable);

    @Query("SELECT d FROM Donation d WHERE d.status = 'ONGOING' ORDER BY d.isFeatured DESC, d.sortOrder ASC, d.createTime DESC")
    List<Donation> findActiveDonations();
}