package vn.spring.laptopshop.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
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
}
