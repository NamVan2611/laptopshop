package vn.spring.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.spring.laptopshop.domain.Order;
import vn.spring.laptopshop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {    
    List<Order> findByUser(User user);

    Page<Order> findAll(Pageable pageable);

    Page<Order> findByStatusIgnoreCase(String status, Pageable pageable);

    @Query("SELECT o FROM Order o WHERE " +
           "(:search IS NULL OR :search = '' OR " +
           "LOWER(o.receiverName) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(o.receiverPhone) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(o.receiverAddress) LIKE LOWER(CONCAT('%', :search, '%'))) AND " +
           "(:status IS NULL OR :status = '' OR o.status = :status)")
    Page<Order> findWithFilters(@Param("search") String search,
                                @Param("status") String status,
                                Pageable pageable);
}
