package vn.spring.laptopshop.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.spring.laptopshop.domain.Product;
import vn.spring.laptopshop.service.ProductService;
import vn.spring.laptopshop.service.UploadService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProductController {

    private final ProductService productService;

    private final UploadService uploadService;

    ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getProductPage(Model model, @RequestParam(name = "page", defaultValue = "1") int page) {
        Pageable pageable = PageRequest.of(page-1, 8);
        Page<Product> productPage = this.productService.getAllProduct(pageable);
        List<Product> productList = productPage.getContent();
        model.addAttribute("products", productList);
        model.addAttribute("currentPage", page);   
        model.addAttribute("totalPages", productPage.getTotalPages());   
        return "admin/product/show";
    }

    @RequestMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("id", id);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        Product product = new Product();
        model.addAttribute("newProduct", product);
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProductPage(Model model, @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProductBindingResult, @RequestParam("file") MultipartFile file) {
        List<FieldError> errors = newProductBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>>" + error.getField() + error.getDefaultMessage() + "<<<<<<<");
        }
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create";
        }
        product.setImage(this.uploadService.handleSaveUploadFile(file, "product"));
        this.productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }

    @RequestMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Product currentProduct = this.productService.getProductById(id);
        model.addAttribute("newProduct", currentProduct);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postUpdateProduct(Model model, @ModelAttribute("newProduct") @Valid Product product,
            BindingResult setProductBindingResult,
            @RequestParam("file") MultipartFile file) {
        List<FieldError> errors = setProductBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>>" + error.getField() + ": " + error.getDefaultMessage() + "<<<<<");
        }
        if (setProductBindingResult.hasErrors()) {
            return "admin/product/update";
        }
        Product currentProduct = this.productService.getProductById(product.getId());
        if (currentProduct != null) {
            currentProduct.setName(product.getName());
            currentProduct.setQuantity(product.getQuantity());
            currentProduct.setPrice(product.getPrice());
            currentProduct.setFactory(product.getFactory());
            currentProduct.setTarget(product.getTarget());
            currentProduct.setShortDesc(product.getShortDesc());
            currentProduct.setDetailDesc(product.getDetailDesc());
            currentProduct.setImage(this.uploadService.handleSaveUploadFile(file, "product"));
            this.productService.handleSaveProduct(currentProduct);
        }
        return "redirect:/admin/product";
    }

    @RequestMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        Product product = new Product();
        product.setId(id);
        model.addAttribute("newProduct", product);
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newProduct") Product product) {
        this.productService.deleteProductById(product.getId());
        return "redirect:/admin/product";
    }
}
