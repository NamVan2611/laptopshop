<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <aside id="sidebar" class="sidebar">

      <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
          <a class="nav-link collapsed" href="/admin">
            <i class="bi bi-grid"></i>
            <span>Dashboard</span>
          </a>
        </li><!-- End Dashboard Nav -->

        <li class="nav-item">
          <a class="nav-link collapsed" href="/admin/user">
            <i class="bi bi-person"></i>
            <span>User</span>
          </a>
        </li><!-- End Profile Page Nav -->

        <li class="nav-item">
          <a class="nav-link ${pageContext.request.requestURI.contains('/admin/product') ? '' : 'collapsed'}"
            data-bs-target="#product-nav" data-bs-toggle="collapse" href="#">
            <i class="bi bi-laptop"></i><span>Product</span><i class="bi bi-chevron-down ms-auto"></i>
          </a>

          <ul id="product-nav"
            class="nav-content collapse ${pageContext.request.requestURI.contains('/admin/product') ? 'show' : ''}"
            data-bs-parent="#sidebar-nav">

            <li><a href="/admin/product" class="${empty factory ? 'active' : ''}">
                <i class="bi bi-circle"></i><span>All Products</span></a></li>

            <li><a href="/admin/product?factory=Dell" class="${factory eq 'Dell' ? 'active' : ''}">
                <i class="bi bi-circle"></i><span>Dell</span></a></li>

            <li><a href="/admin/product?factory=Asus" class="${factory eq 'Asus' ? 'active' : ''}">
                <i class="bi bi-circle"></i><span>Asus</span></a></li>

            <li><a href="/admin/product?factory=Apple" class="${factory eq 'Apple' ? 'active' : ''}">
                <i class="bi bi-circle"></i><span>Apple</span></a></li>

            <li><a href="/admin/product?factory=Lenovo" class="${factory eq 'Lenovo' ? 'active' : ''}">
                <i class="bi bi-circle"></i><span>Lenovo</span></a></li>

            <li><a href="/admin/product?factory=LG" class="${factory eq 'LG' ? 'active' : ''}">
                <i class="bi bi-circle"></i><span>LG</span></a></li>

          </ul>
        </li>

        <li class="nav-item">
          <a class="nav-link collapsed" href="/admin/order">
            <i class="bi bi-cart"></i>
            <span>Order</span>
          </a>
        </li><!-- End Contact Page Nav -->

        <li class="nav-item">
          <a class="nav-link collapsed" href="/">
            <i class="bi bi-card-list"></i>
            <span>Homepage</span>
          </a>
        </li><!-- End Register Page Nav -->

        <li class="nav-item">
          <a class="nav-link collapsed" href="/login">
            <i class="bi bi-box-arrow-in-right"></i>
            <span>Login</span>
          </a>
        </li><!-- End Login Page Nav -->

      </ul>
      <script>
        document.addEventListener("DOMContentLoaded", function () {
          const currentPath = window.location.pathname;
          document.querySelectorAll("#sidebar-nav a.nav-link").forEach(link => {
            if (link.getAttribute("href") === currentPath) {
              link.classList.add("active");
              link.classList.remove("collapsed");
            }
          });
        });
      </script>

    </aside><!-- End Sidebar-->