package vn.spring.laptopshop.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.spring.laptopshop.domain.User;

import java.util.List;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    void deleteById(long id);
    List<User> findOneByEmail(String email);
    User findById(long id) ;
    boolean existsByEmail(String email);

    User findByEmail(String email);

    Page<User> findAll(Pageable pageable);

    @Query("SELECT u FROM User u WHERE " +
           "(:search IS NULL OR :search = '' OR " +
           "LOWER(u.email) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(u.fullName) LIKE LOWER(CONCAT('%', :search, '%'))) AND " +
           "(:role IS NULL OR :role = '' OR u.role.name = :role)")
    Page<User> findWithFilters(@Param("search") String search,
                               @Param("role") String role,
                               Pageable pageable);
}
