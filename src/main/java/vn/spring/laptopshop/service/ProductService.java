package vn.spring.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.spring.laptopshop.domain.Cart;
import vn.spring.laptopshop.domain.CartDetail;
import vn.spring.laptopshop.domain.Order;
import vn.spring.laptopshop.domain.OrderDetail;
import vn.spring.laptopshop.domain.Product;
import vn.spring.laptopshop.domain.User;
import vn.spring.laptopshop.repository.CartDetailRepository;
import vn.spring.laptopshop.repository.CartRepository;
import vn.spring.laptopshop.repository.OrderDetailRepository;
import vn.spring.laptopshop.repository.OrderRepository;
import vn.spring.laptopshop.repository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository OrderDetailRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService, OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.OrderDetailRepository = orderDetailRepository;
    }

    public Product handleSaveProduct(Product product) {
        return this.productRepository.save(product);
    }

    public Page<Product> getAllProduct(Pageable pageable) {
        return this.productRepository.findAll(pageable);
    }

    public Product getProductById(long id) {
        return this.productRepository.findById(id);
    }

    public Cart getProductByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void deleteProductById(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleRemoveProductFromCart(long id, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(id);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            Cart currentCart = cartDetail.getCart();
            this.cartDetailRepository.deleteById(id);
            if (currentCart.getSum() > 1) {
                int sum = currentCart.getSum() - 1;
                currentCart.setSum(sum);
                session.setAttribute("sum", sum);
                this.cartRepository.save(currentCart);
            } else {
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }

    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setSum(0);
                this.cartRepository.save(otherCart);
            }
            Product product = this.productRepository.findById(productId);
            CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
            if (oldDetail == null) {
                CartDetail cartDetail = new CartDetail();
                cartDetail.setCart(cart);
                cartDetail.setProduct(product);
                cartDetail.setPrice(product.getPrice());
                cartDetail.setQuantity(quantity);
                this.cartDetailRepository.save(cartDetail);

                int sum = cart.getSum() + 1;
                cart.setSum(sum);
                this.cartRepository.save(cart);
                session.setAttribute("sum", sum);
            } else {
                oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                this.cartDetailRepository.save(oldDetail);
            }
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cartDetailOptional.isPresent()) {
                CartDetail currentCartDetail = cartDetailOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(User user, HttpSession session, String receiverName, String receiverAddress,
            String receiverPhone) {

        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> listCartDetails = cart.getCartDetails();
            Order order = new Order();
            order.setUser(user);
            order.setReceiverName(receiverName);
            order.setReceiverAddress(receiverAddress);
            order.setReceiverPhone(receiverPhone);
            order.setStatus("PENDING");
            double totalPrice = 0;
            for (CartDetail cartDetail : listCartDetails) {
                totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
            }
            order.setTotalPrice(totalPrice);
            this.orderRepository.save(order);
            if (listCartDetails != null) {
                for (CartDetail cartDetail : listCartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setPrice(cartDetail.getPrice());
                    orderDetail.setProduct(cartDetail.getProduct());
                    orderDetail.setQuantity(cartDetail.getQuantity());

                    this.OrderDetailRepository.save(orderDetail);
                }
                for (CartDetail cartDetail : listCartDetails) {
                    this.cartDetailRepository.deleteById(cartDetail.getId());
                }
                this.cartRepository.deleteById(cart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public long countProducts() {
        return this.productRepository.count();
    }
}
