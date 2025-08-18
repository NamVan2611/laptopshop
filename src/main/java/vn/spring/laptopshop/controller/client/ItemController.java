package vn.spring.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.spring.laptopshop.domain.Cart;
import vn.spring.laptopshop.domain.CartDetail;
import vn.spring.laptopshop.domain.Product;
import vn.spring.laptopshop.domain.User;
import vn.spring.laptopshop.service.ProductService;

import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ItemController {

    private ProductService productService;

    public ItemController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product/{id}")
    public String getHomePage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("id", id);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long productId = id;
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, productId, session, 1);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = new User();
        user.setId((Long) session.getAttribute("id"));

        Cart cart = this.productService.getProductByUser(user);
        List<CartDetail> cartDetails = Optional.ofNullable(cart).map(Cart::getCartDetails).orElse(new ArrayList<>());
        double totalPrice = 0;
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("cart", cart);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        return "client/cart/show";
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = new User();
        user.setId((Long) session.getAttribute("id"));

        Cart cart = this.productService.getProductByUser(user);
        List<CartDetail> cartDetails = Optional.ofNullable(cart).map(Cart::getCartDetails).orElse(new ArrayList<>());
        double totalPrice = 0;
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("cart", cart);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String postCheckoutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String postDeleteCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.productService.handleRemoveProductFromCart(id, session);
        return "redirect:/cart";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpServletRequest request, @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {
        User user = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        user.setId(id);
        this.productService.handlePlaceOrder(user, session, receiverName, receiverAddress, receiverPhone);
        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getSuccessOrderPage() {
        return "client/cart/thanks";
    }

    @PostMapping("/add-product-from-view-detail")
    public String addProductFromViewDetail(@RequestParam("id") long id, @RequestParam("quantity") long quantity,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity);
        return "redirect:/product/" + id;
    }

    @GetMapping("/products")
    public String getProductPage(Model model, @RequestParam(name = "page", defaultValue = "1") int page) {
        Pageable pageable = PageRequest.of(page - 1, 6);
        Page<Product> productPage = this.productService.getAllProduct(pageable);
        List<Product> productList = productPage.getContent();
        model.addAttribute("products", productList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        return "client/product/show";
    }

}
