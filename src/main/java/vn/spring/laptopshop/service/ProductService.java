package vn.spring.laptopshop.service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.spring.laptopshop.domain.Cart;
import vn.spring.laptopshop.domain.CartDetail;
import vn.spring.laptopshop.domain.Order;
import vn.spring.laptopshop.domain.OrderDetail;
import vn.spring.laptopshop.domain.Product;
import vn.spring.laptopshop.domain.Product_;
import vn.spring.laptopshop.domain.User;
import vn.spring.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.spring.laptopshop.repository.CartDetailRepository;
import vn.spring.laptopshop.repository.CartRepository;
import vn.spring.laptopshop.repository.OrderDetailRepository;
import vn.spring.laptopshop.repository.OrderRepository;
import vn.spring.laptopshop.repository.ProductRepository;
import vn.spring.laptopshop.repository.UserRepository;
import vn.spring.laptopshop.service.specification.ProductSpecifications;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository OrderDetailRepository;
    private final UserRepository userRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository, UserRepository userRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.orderRepository = orderRepository;
        this.OrderDetailRepository = orderDetailRepository;
        this.userRepository = userRepository;
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

    public Product findById(Long id) {
        Optional<Product> product = productRepository.findById(id);
        return product.orElse(null);
    }

    public Page<Product> findAll(Pageable pageable, ProductCriteriaDTO productCriteriaDTO) {
        Specification<Product> combineSpecifications = Specification.where(null);
        if (Objects.nonNull(productCriteriaDTO.getFactory()) && productCriteriaDTO.getFactory().isPresent()) {
            combineSpecifications = combineSpecifications
                    .and(ProductSpecifications.matchList(productCriteriaDTO.getFactory().get(), Product_.FACTORY));
        }
        if (Objects.nonNull(productCriteriaDTO.getTarget()) && productCriteriaDTO.getTarget().isPresent()) {
            combineSpecifications = combineSpecifications
                    .and(ProductSpecifications.matchList(productCriteriaDTO.getTarget().get(), Product_.TARGET));
        }
        if (Objects.nonNull(productCriteriaDTO.getPrice()) && productCriteriaDTO.getPrice().isPresent()) {
            combineSpecifications = combineSpecifications
                    .and(buildPriceSpecification(productCriteriaDTO.getPrice().get()));
        }
        return productRepository.findAll(combineSpecifications, pageable);
    }

    private Specification<Product> buildPriceSpecification(List<String> prices) {
        Specification<Product> combineSpecifications = Specification.where(null);
        for (String p : prices) {
            double min = 0;
            double max = 0;
            switch (p) {
                case "duoi-10-trieu":
                    min = Double.MIN_VALUE;
                    max = 10_000_000;
                    break;
                case "tu-10-15-trieu":
                    min = 10_000_000;
                    max = 15_000_000;
                    break;
                case "tu-15-20-trieu":
                    min = 15_000_000;
                    max = 20_000_000;
                    break;
                case "tren-20-trieu":
                    min = 20_000_000;
                    max = Double.MAX_VALUE;
                    break;
                default:
                    break;
            }
            if (min != 0 && max != 0) {
                combineSpecifications = combineSpecifications.or(ProductSpecifications.matchPrice(min, max));
            }
        }
        return combineSpecifications;
    }

    public PageRequest getPageRequest(ProductCriteriaDTO productCriteriaDTO, int page) {
        PageRequest pageRequest = PageRequest.of(page - 1, 6);
        if (Objects.nonNull(productCriteriaDTO.getSort()) && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if (sort.equals("gia-tang-dan")) {
                pageRequest = PageRequest.of(page - 1, 6, Sort.by(Product_.PRICE).ascending());
            } else if (sort.equals("gia-giam-dan")) {
                pageRequest = PageRequest.of(page - 1, 6, Sort.by(Product_.PRICE).descending());
            }
        }
        return pageRequest;
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

    public void handleAddProductToCart(HttpSession session, Long id, long quantity) {
        User user = userRepository.findByEmail(session.getAttribute("email").toString());
        if (Objects.isNull(user)) {
            System.out.println("User not found");
        }
        //Create new cart
        Cart cart = cartRepository.findByUser(user);
        if (Objects.isNull(cart)) {
            cart = new Cart();
            cart.setUser(user);
            cart.setSum(0);
            cart = cartRepository.save(cart);
        }
        //Save cart detail
        Product product = findById(id);
        CartDetail cartDetail = cartDetailRepository.findByCartAndProduct(cart, product);
        if (Objects.isNull(cartDetail)) {
            cartDetail = new CartDetail();
            cartDetail.setCart(cart);
            cartDetail.setProduct(product);
            cartDetail.setQuantity(quantity);
            cartDetail.setPrice(product.getPrice());

            //Update sum cart
            cart.setSum(cart.getSum() + 1);
            cartRepository.save(cart);
            session.setAttribute("sum", cart.getSum());
        } else {
            cartDetail.setQuantity(cartDetail.getQuantity() + quantity);
        }
        cartDetailRepository.save(cartDetail);
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
