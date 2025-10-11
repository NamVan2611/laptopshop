package vn.spring.laptopshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import vn.spring.laptopshop.domain.Product;
import vn.spring.laptopshop.domain.Product_;

public class ProductSpecifications {
     public static Specification<Product> matchList(List<String> list, String field) {
        return ((root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(field)).value(list));
    }

    public static Specification<Product> matchPrice(double min, double max) {
        return ((root, query, criteriaBuilder) -> criteriaBuilder.between(root.get(Product_.PRICE), min, max));
    }
}
