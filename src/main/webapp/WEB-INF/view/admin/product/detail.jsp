<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
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
        :root {
            --primary-color: #4154f1;
            --secondary-color: #717ff5;
            --success-color: #2eca6a;
            --danger-color: #ff5722;
            --warning-color: #ffc107;
            --info-color: #17a2b8;
            --light-bg: #f8f9fc;
            --border-color: #e3e6f0;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Poppins', sans-serif;
        }

        .detail-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(65, 84, 241, 0.3);
        }

        .detail-card {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
        }

        .product-image-container {
            text-align: center;
            margin-bottom: 2rem;
        }

        .product-image {
            width: 100%;
            max-width: 400px;
            height: auto;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
            object-fit: cover;
        }

        .product-image:hover {
            transform: scale(1.02);
        }

        .info-section {
            margin-bottom: 2rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            transition: background-color 0.3s ease;
        }

        .info-item:hover {
            background-color: #f8f9fc;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            margin-right: 1rem;
            font-size: 1.2rem;
        }

        .info-icon.primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
        }

        .info-icon.success {
            background-color: var(--success-color);
            color: white;
        }

        .info-icon.warning {
            background-color: var(--warning-color);
            color: #333;
        }

        .info-icon.info {
            background-color: var(--info-color);
            color: white;
        }

        .info-label {
            font-weight: 600;
            color: #495057;
            min-width: 150px;
        }

        .info-value {
            color: #212529;
            flex: 1;
        }

        .badge-large {
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 8px;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 2rem;
        }

        .btn-action {
            padding: 0.75rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            min-width: 150px;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .description-box {
            background-color: #f8f9fc;
            border-left: 4px solid var(--primary-color);
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
        }
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main class="main" id="main">
        <div class="container-fluid px-4 py-4">
            <!-- Header -->
            <div class="detail-header">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h2 class="mb-1"><i class="bi bi-box-seam me-2"></i>Product Details</h2>
                        <p class="mb-0 opacity-75">ID: #${product.id}</p>
                    </div>
                    <a href="/admin/product" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>

            <div class="row">
                <!-- Product Image -->
                <div class="col-lg-4">
                    <div class="detail-card">
                        <div class="product-image-container">
                            <c:choose>
                                <c:when test="${not empty product.image}">
                                    <img src="/images/product/${product.image}" alt="${product.name}"
                                        class="product-image">
                                </c:when>
                                <c:otherwise>
                                    <div class="product-image bg-light d-flex align-items-center justify-content-center"
                                        style="height: 400px;">
                                        <i class="bi bi-image fs-1 text-muted"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="text-center">
                            <h4 class="fw-bold mb-3">${product.name}</h4>
                            <span class="badge bg-success badge-large">
                                <fmt:formatNumber type="number" value="${product.price}" pattern="#,##0" /> VNĐ
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Product Information -->
                <div class="col-lg-8">
                    <div class="detail-card">
                        <h5 class="fw-bold mb-4"><i class="bi bi-info-circle me-2"></i>Product Information</h5>
                        
                        <div class="info-section">
                            <div class="info-item">
                                <div class="info-icon primary">
                                    <i class="bi bi-box"></i>
                                </div>
                                <div class="info-label">Quantity:</div>
                                <div class="info-value">
                                    <span class="badge bg-info">${product.quantity} units</span>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon success">
                                    <i class="bi bi-cart-check"></i>
                                </div>
                                <div class="info-label">Sold:</div>
                                <div class="info-value">
                                    <span class="badge bg-success">${product.sold} units</span>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon warning">
                                    <i class="bi bi-building"></i>
                                </div>
                                <div class="info-label">Factory:</div>
                                <div class="info-value">
                                    <span class="badge bg-primary">${product.factory}</span>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon info">
                                    <i class="bi bi-people"></i>
                                </div>
                                <div class="info-label">Target:</div>
                                <div class="info-value">
                                    <span class="badge bg-secondary">${product.target}</span>
                                </div>
                            </div>
                        </div>

                        <div class="info-section">
                            <h6 class="fw-bold mb-3"><i class="bi bi-file-text me-2"></i>Short Description</h6>
                            <div class="description-box">
                                <p class="mb-0">${product.shortDesc}</p>
                            </div>
                        </div>

                        <div class="info-section">
                            <h6 class="fw-bold mb-3"><i class="bi bi-card-text me-2"></i>Full Description</h6>
                            <div class="description-box">
                                <p class="mb-0">${product.detailDesc}</p>
                            </div>
                        </div>

                        <div class="action-buttons">
                            <a href="/admin/product/update/${product.id}" class="btn btn-warning btn-action">
                                <i class="bi bi-pencil me-2"></i>Edit Product
                            </a>
                            <a href="/admin/product/delete/${product.id}" class="btn btn-danger btn-action">
                                <i class="bi bi-trash me-2"></i>Delete Product
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <!-- Vendor JS -->
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
</body>

</html>
