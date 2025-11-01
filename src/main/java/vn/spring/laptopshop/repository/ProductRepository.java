package vn.spring.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.spring.laptopshop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    Product findById(long id);

    void deleteById(long id);

    Page<Product> findAll(Pageable pageable);

    Page<Product> findAll(Specification<Product> specification, Pageable pageable);

    Page<Product> findByFactoryIgnoreCase(String factory, Pageable pageable);

    @Query("SELECT p FROM Product p WHERE " +
           "(:search IS NULL OR :search = '' OR LOWER(p.name) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(p.factory) LIKE LOWER(CONCAT('%', :search, '%'))) AND " +
           "(:factory IS NULL OR :factory = '' OR p.factory = :factory) AND " +
           "(:target IS NULL OR :target = '' OR p.target = :target)")
    Page<Product> findWithFilters(@Param("search") String search,
                                  @Param("factory") String factory,
                                  @Param("target") String target,
                                  Pageable pageable);

}