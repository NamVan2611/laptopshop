package vn.spring.laptopshop.controller.admin;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.spring.laptopshop.domain.Order;
import vn.spring.laptopshop.service.OrderService;

@Controller
public class OrderController {
    private final OrderService orderService;

    OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getDashboard(Model model, 
                               @RequestParam(name="page", defaultValue = "1") int page,
                               @RequestParam(name="search", required = false) String search,
                               @RequestParam(name="status", required = false) String status) {
        Pageable pageable = PageRequest.of(page-1, 10);
        Page<Order> orderPage;
        
        if ((search != null && !search.isEmpty()) || (status != null && !status.isEmpty())) {
            orderPage = this.orderService.findWithFilters(
                search != null ? search : "",
                status != null ? status : "",
                pageable);
        } else {
            orderPage = this.orderService.getAllOrder(pageable);
        }
        
        List<Order> orderList = orderPage.getContent();
        model.addAttribute("order", orderList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("search", search);
        model.addAttribute("status", status);
        return "admin/order/show";
    }

    @RequestMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Optional<Order> orderOptional = this.orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            model.addAttribute("order", order);
            return "admin/order/detail";
        } else {
            return "redirect:/admin/order";
        }
    }

    @RequestMapping("/admin/order/update/{id}")
    public String getUpdateUpdateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> orderOptional = this.orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            model.addAttribute("newOrder", order);
            return "admin/order/update";
        } else {
            return "redirect:/admin/order";
        }
    }

    @PostMapping("/admin/order/update")
    public String postUpdateOrder(Model model, @ModelAttribute("newOrder") Order order) {
        Optional<Order> orderOptional = this.orderService.getOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            if (currentOrder != null) {
                currentOrder.setStatus(order.getStatus());
                this.orderService.handleSaveOrder(currentOrder);
            }

        }
        return "redirect:/admin/order";
    }

    @RequestMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id) {
        Optional<Order> orderOptional = this.orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            model.addAttribute("newOrder", order);
            model.addAttribute("id", id);
        } else {
            model.addAttribute("id", id);
            Order order = new Order();
            order.setId(id);
            model.addAttribute("newOrder", order);
        }
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newOrder") Order order) {
        this.orderService.deleteOrderById(order.getId());
        return "redirect:/admin/order";
    }
}
