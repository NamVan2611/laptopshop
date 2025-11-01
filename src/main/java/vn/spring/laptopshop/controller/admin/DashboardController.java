package vn.spring.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.spring.laptopshop.service.OrderService;
import vn.spring.laptopshop.service.ProductService;
import vn.spring.laptopshop.service.UserService;


@Controller
public class DashboardController {

    private final OrderService orderService;

    private final ProductService productService;

    private final UserService userService;

    DashboardController(UserService userService, ProductService productService, OrderService orderService) {
        this.userService = userService;
        this.productService = productService;
        this.orderService = orderService;
    }
    
    @GetMapping("/admin")
    public String getDashboard(Model model) {
        model.addAttribute("countUsers", this.userService.countUsers());
        model.addAttribute("countProducts", this.productService.countProducts());
        model.addAttribute("countOrders", this.orderService.countOrders());
        model.addAttribute("totalRevenue", this.orderService.getTotalRevenue());
        model.addAttribute("totalSold", this.productService.getTotalSold());
        model.addAttribute("pendingOrders", this.orderService.countOrdersByStatus("PENDING"));
        model.addAttribute("completedOrders", this.orderService.countOrdersByStatus("COMPLETED"));
        model.addAttribute("processingOrders", this.orderService.countOrdersByStatus("PROCESSING"));
        return "admin/dashboard/show";
    }
    
}
