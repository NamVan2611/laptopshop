<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Order</title>
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
            --danger-color: #ff5722;
            --light-bg: #f8f9fc;
            --border-color: #e3e6f0;
            --primary-color: #4154f1;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Poppins', sans-serif;
        }

        .delete-card {
            max-width: 700px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            padding: 3rem;
            box-shadow: 0 8px 30px rgba(255, 87, 34, 0.2);
            border: 2px solid var(--danger-color);
        }

        .warning-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #fff3cd 0%, #ffe69c 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            font-size: 3rem;
            color: var(--danger-color);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        .warning-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .warning-header h2 {
            color: var(--danger-color);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .order-info-box {
            background-color: #f8f9fc;
            border-left: 4px solid var(--primary-color);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .warning-message {
            background-color: #fff3cd;
            border-left: 4px solid var(--danger-color);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .warning-message ul {
            margin-bottom: 0;
            padding-left: 1.5rem;
        }

        .btn-delete {
            background: linear-gradient(135deg, var(--danger-color) 0%, #e64a19 100%);
            border: none;
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 87, 34, 0.4);
            color: white;
        }

        .btn-cancel {
            padding: 0.75rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--border-color);
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #495057;
        }

        .info-value {
            color: #212529;
        }
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main id="main" class="main">
        <div class="container-fluid px-4 py-5">
            <div class="delete-card">
                <div class="warning-icon">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                </div>

                <div class="warning-header">
                    <h2>Confirm Deletion</h2>
                    <p class="text-muted">Order ID: #${id}</p>
                </div>

                <!-- Order Information -->
                <c:if test="${not empty newOrder}">
                    <div class="order-info-box">
                        <h6 class="fw-bold mb-3"><i class="bi bi-info-circle me-2"></i>Order Information</h6>
                        <div class="info-row">
                            <span class="info-label">Customer:</span>
                            <span class="info-value">${newOrder.receiverName}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Phone:</span>
                            <span class="info-value">${newOrder.receiverPhone}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Total Amount:</span>
                            <span class="info-value fw-bold text-success">
                                <fmt:formatNumber type="number" value="${newOrder.totalPrice}" pattern="#,##0" /> VNĐ
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Items:</span>
                            <span class="info-value">${newOrder.orderDetails.size()} product(s)</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Status:</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${newOrder.status == 'PENDING'}">
                                        <span class="badge bg-warning">Pending</span>
                                    </c:when>
                                    <c:when test="${newOrder.status == 'PROCESSING'}">
                                        <span class="badge bg-info">Processing</span>
                                    </c:when>
                                    <c:when test="${newOrder.status == 'COMPLETED'}">
                                        <span class="badge bg-success">Completed</span>
                                    </c:when>
                                    <c:when test="${newOrder.status == 'CANCELLED'}">
                                        <span class="badge bg-danger">Cancelled</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${newOrder.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </c:if>

                <div class="warning-message">
                    <h5 class="mb-3"><i class="bi bi-info-circle me-2"></i>Warning - This Action Cannot Be Undone</h5>
                    <p class="mb-2">You are about to permanently delete this order. This will result in:</p>
                    <ul>
                        <li>Removal of all order details and product information</li>
                        <li>Deletion of order history records</li>
                        <li>Loss of all associated data</li>
                        <li>This action cannot be reversed</li>
                    </ul>
                </div>

                <form:form method="post" action="/admin/order/delete" modelAttribute="newOrder">
                    <div style="display: none;">
                        <form:input type="text" class="form-control" path="id" />
                    </div>

                    <div class="d-flex gap-3 justify-content-center">
                        <a href="/admin/order/${id}" class="btn btn-secondary btn-cancel">
                            <i class="bi bi-x-circle me-2"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-delete">
                            <i class="bi bi-trash me-2"></i>Delete Order
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
</body>

</html>
