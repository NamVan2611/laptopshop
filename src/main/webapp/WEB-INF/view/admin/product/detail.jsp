<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>Product Detail</title>

                    <link href="/img/favicon.png" rel="icon">
                    <link href="/img/apple-touch-icon.png" rel="apple-touch-icon">

                    <!-- Google Fonts -->
                    <link href="https://fonts.gstatic.com" rel="preconnect">
                    <link
                        href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|Nunito:400,600,700|Poppins:400,500,600,700"
                        rel="stylesheet">

                    <!-- Vendor CSS -->
                    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
                    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">
                    <link href="/css/style.css" rel="stylesheet">

                    <style>
                        body {
                            background-color: #f8f9fc;
                        }

                        .card {
                            border-radius: 15px;
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                        }

                        .card-header {
                            background-color: #0d6efd;
                            color: white;
                            font-weight: 600;
                            text-transform: uppercase;
                            border-top-left-radius: 15px !important;
                            border-top-right-radius: 15px !important;
                        }

                        .product-avatar {
                            width: 200px;
                            height: 200px;
                            object-fit: cover;
                            border-radius: 15px;
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                            border: 4px solid #fff;
                            transition: transform 0.3s ease;
                        }

                        .product-avatar:hover {
                            transform: scale(1.05);
                        }

                        .info-label {
                            font-weight: 600;
                            color: #495057;
                        }

                        .info-value {
                            color: #0d6efd;
                        }

                        .back-btn {
                            margin-top: 25px;
                        }
                    </style>
                </head>

                <body>
                    <jsp:include page="../layout/header.jsp" />
                    <jsp:include page="../layout/sidebar.jsp" />

                    <main class="main" id="main">
                        <div class="container py-5">
                            <div class="card mx-auto" style="max-width: 700px;">
                                <div class="card-header text-center">
                                    <i class="bi bi-box-seam"></i> Product Detail - ID: ${product.id}
                                </div>
                                <div class="card-body text-center">
                                    <img src="/images/product/${product.image}" alt="${product.name}"
                                        class="product-avatar mb-4">

                                    <h4 class="mb-3">${product.name}</h4>

                                    <ul class="list-group list-group-flush text-start px-4">
                                        <li class="list-group-item">
                                            <span class="info-label">Quantity:</span>
                                            <span class="info-value">${product.quantity}</span>
                                        </li>
                                        <li class="list-group-item">
                                            <span class="info-label">Factory:</span>
                                            <span class="info-value">${product.factory}</span>
                                        </li>
                                        <li class="list-group-item">
                                            <span class="info-label">Target:</span>
                                            <span class="info-value">${product.target}</span>
                                        </li>
                                    </ul>

                                    <div class="text-center back-btn">
                                        <a href="/admin/product" class="btn btn-outline-primary">
                                            <i class="bi bi-arrow-left"></i> Back to list
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Vendor JS -->
                    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>