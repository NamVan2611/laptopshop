package vn.spring.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.spring.laptopshop.domain.Order;
import vn.spring.laptopshop.domain.OrderDetail;
import vn.spring.laptopshop.domain.User;
import vn.spring.laptopshop.repository.OrderDetailRepository;
import vn.spring.laptopshop.repository.OrderRepository;

@Service
public class OrderService {

    private final OrderDetailRepository orderDetailRepository;
    private final OrderRepository orderRepository;
    
    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Page<Order> getAllOrder(Pageable pageable){
        return this.orderRepository.findAll(pageable);
    }

    public Optional<Order> getOrderById(Long id){
        return this.orderRepository.findById(id);
    }
    public Order handleSaveOrder(Order order){
        return this.orderRepository.save(order);
    }
    public void deleteOrderById(long id){
        Optional<Order> orderOptional = this.getOrderById(id);
        if(orderOptional.isPresent()){
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for(OrderDetail orderDetail : orderDetails){
                this.orderDetailRepository.deleteById(orderDetail.getId());
            }
        }
        this.orderRepository.deleteById(id);
    }
    public long countOrders(){
        return this.orderRepository.count();
    }
    public List<Order> getOrderByUser(User user){
        return this.orderRepository.findByUser(user);
    }

    public Page<Order> findWithFilters(String search, String status, Pageable pageable) {
        return this.orderRepository.findWithFilters(search, status, pageable);
    }

    public double getTotalRevenue() {
        return this.orderRepository.findAll().stream()
                .filter(o -> "COMPLETED".equals(o.getStatus()))
                .mapToDouble(Order::getTotalPrice)
                .sum();
    }

    public long countOrdersByStatus(String status) {
        return this.orderRepository.findAll().stream()
                .filter(o -> status.equals(o.getStatus()))
                .count();
    }
}
