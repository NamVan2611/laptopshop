<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link href="/img/favicon.png" rel="icon">
    <link href="/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link
        href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
        rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
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
            margin-bottom: 2rem;
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

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.875rem;
            display: inline-block;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-processing {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .items-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .items-table thead {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
        }

        .items-table thead th {
            border: none;
            padding: 1rem;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .items-table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid var(--border-color);
        }

        .items-table tbody tr:hover {
            background-color: #f8f9fc;
        }

        .items-table tbody tr:last-child {
            border-bottom: none;
        }

        .items-table tbody td {
            padding: 1rem;
            vertical-align: middle;
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .total-section {
            background: linear-gradient(135deg, var(--success-color) 0%, #26b05a 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            margin-top: 1rem;
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
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main id="main" class="main">
        <div class="container-fluid px-4 py-4">
            <!-- Header -->
            <div class="detail-header">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h2 class="mb-1"><i class="bi bi-cart-check me-2"></i>Order Details</h2>
                        <p class="mb-0 opacity-75">Order ID: #${order.id}</p>
                    </div>
                    <a href="/admin/order" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>

            <div class="row">
                <!-- Customer Information -->
                <div class="col-lg-4">
                    <div class="detail-card">
                        <h5 class="fw-bold mb-4"><i class="bi bi-person-circle me-2"></i>Customer Information</h5>
                        
                        <div class="info-section">
                            <div class="info-item">
                                <div class="info-icon primary">
                                    <i class="bi bi-person"></i>
                                </div>
                                <div class="info-label">Customer:</div>
                                <div class="info-value fw-bold">${order.receiverName}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon success">
                                    <i class="bi bi-envelope"></i>
                                </div>
                                <div class="info-label">User ID:</div>
                                <div class="info-value">#${order.user.id}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon info">
                                    <i class="bi bi-telephone"></i>
                                </div>
                                <div class="info-label">Phone:</div>
                                <div class="info-value">${order.receiverPhone}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon primary">
                                    <i class="bi bi-geo-alt"></i>
                                </div>
                                <div class="info-label">Address:</div>
                                <div class="info-value">${order.receiverAddress}</div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Summary -->
                    <div class="detail-card">
                        <h5 class="fw-bold mb-4"><i class="bi bi-info-circle me-2"></i>Order Summary</h5>
                        
                        <div class="info-section">
                            <div class="info-item">
                                <div class="info-icon success">
                                    <i class="bi bi-tag"></i>
                                </div>
                                <div class="info-label">Order ID:</div>
                                <div class="info-value fw-bold">#${order.id}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon info">
                                    <i class="bi bi-list-check"></i>
                                </div>
                                <div class="info-label">Items:</div>
                                <div class="info-value">${order.orderDetails.size()} product(s)</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon primary">
                                    <i class="bi bi-cart-check"></i>
                                </div>
                                <div class="info-label">Status:</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="status-badge status-pending">
                                                <i class="bi bi-clock me-1"></i>Pending
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 'PROCESSING'}">
                                            <span class="status-badge status-processing">
                                                <i class="bi bi-arrow-repeat me-1"></i>Processing
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 'COMPLETED'}">
                                            <span class="status-badge status-completed">
                                                <i class="bi bi-check-circle me-1"></i>Completed
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">
                                            <span class="status-badge status-cancelled">
                                                <i class="bi bi-x-circle me-1"></i>Cancelled
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-pending">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="total-section">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fs-5 fw-bold">Total Amount:</span>
                                <span class="fs-4 fw-bold">
                                    <fmt:formatNumber type="number" value="${order.totalPrice}" pattern="#,##0" /> VNĐ
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Items -->
                <div class="col-lg-8">
                    <div class="detail-card">
                        <h5 class="fw-bold mb-4"><i class="bi bi-box-seam me-2"></i>Order Items</h5>
                        
                        <div class="table-responsive">
                            <table class="table items-table mb-0">
                                <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th class="text-end">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <tr>
                                            <td>
                                                <img src="/images/product/${orderDetail.product.image}" 
                                                     alt="${orderDetail.product.name}"
                                                     class="product-image"
                                                     onerror="this.src='/img/product-1.jpg'">
                                            </td>
                                            <td>
                                                <div>
                                                    <a href="/admin/product/${orderDetail.product.id}" 
                                                       class="text-decoration-none fw-bold">
                                                        ${orderDetail.product.name}
                                                    </a>
                                                    <br>
                                                    <small class="text-muted">ID: #${orderDetail.product.id}</small>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="fw-bold">
                                                    <fmt:formatNumber type="number" value="${orderDetail.price}" pattern="#,##0" /> VNĐ
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${orderDetail.quantity}</span>
                                            </td>
                                            <td class="text-end">
                                                <strong class="text-success">
                                                    <fmt:formatNumber type="number"
                                                        value="${orderDetail.price * orderDetail.quantity}"
                                                        pattern="#,##0" /> VNĐ
                                                </strong>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <a href="/admin/order/update/${order.id}" class="btn btn-warning btn-action">
                            <i class="bi bi-pencil me-2"></i>Update Status
                        </a>
                        <a href="/admin/order/delete/${order.id}" class="btn btn-danger btn-action">
                            <i class="bi bi-trash me-2"></i>Delete Order
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
</body>

</html>
