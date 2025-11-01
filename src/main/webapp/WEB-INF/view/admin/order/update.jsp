<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Order Status</title>
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
            --warning-color: #ffc107;
            --danger-color: #ff5722;
            --success-color: #2eca6a;
            --info-color: #17a2b8;
            --light-bg: #f8f9fc;
            --border-color: #e3e6f0;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Poppins', sans-serif;
        }

        .form-header {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e0a800 100%);
            color: #333;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
        }

        .form-card {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
        }

        .order-info-card {
            background: #f8f9fc;
            border-left: 4px solid var(--primary-color);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
            font-size: 1rem;
        }

        .form-select {
            padding: 0.75rem;
            border-radius: 8px;
            border: 2px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(65, 84, 241, 0.25);
        }

        .status-option {
            padding: 0.5rem;
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

        .btn-submit {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e0a800 100%);
            border: none;
            color: #333;
            padding: 0.75rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 193, 7, 0.4);
            color: #333;
        }

        .info-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.875rem;
        }

        .badge-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .badge-processing {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .badge-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .badge-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main id="main" class="main">
        <div class="container-fluid px-4 py-4">
            <!-- Header -->
            <div class="form-header">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h2 class="mb-1"><i class="bi bi-pencil-square me-2"></i>Update Order Status</h2>
                        <p class="mb-0 opacity-75">Order ID: #${newOrder.id}</p>
                    </div>
                    <a href="/admin/order/${newOrder.id}" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to Details
                    </a>
                </div>
            </div>

            <!-- Form Card -->
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <!-- Order Information -->
                    <div class="order-info-card">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-2"><strong><i class="bi bi-person me-2"></i>Customer:</strong> ${newOrder.receiverName}</p>
                                <p class="mb-2"><strong><i class="bi bi-telephone me-2"></i>Phone:</strong> ${newOrder.receiverPhone}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-2"><strong><i class="bi bi-tag me-2"></i>Total:</strong> 
                                    <span class="text-success fw-bold">
                                        <fmt:formatNumber type="number" value="${newOrder.totalPrice}" pattern="#,##0" /> VNĐ
                                    </span>
                                </p>
                                <p class="mb-0"><strong><i class="bi bi-list-check me-2"></i>Items:</strong> ${newOrder.orderDetails.size()} product(s)</p>
                            </div>
                        </div>
                    </div>

                    <div class="form-card">
                        <form:form method="post" action="/admin/order/update" modelAttribute="newOrder" class="row">
                            <!-- Hidden ID -->
                            <div style="display: none;">
                                <form:input type="text" class="form-control" path="id" />
                            </div>

                            <!-- Current Status -->
                            <div class="mb-4">
                                <label class="form-label"><i class="bi bi-info-circle me-2"></i>Current Status</label>
                                <div>
                                    <c:choose>
                                        <c:when test="${newOrder.status == 'PENDING'}">
                                            <span class="info-badge badge-pending">
                                                <i class="bi bi-clock me-1"></i>Pending
                                            </span>
                                        </c:when>
                                        <c:when test="${newOrder.status == 'PROCESSING'}">
                                            <span class="info-badge badge-processing">
                                                <i class="bi bi-arrow-repeat me-1"></i>Processing
                                            </span>
                                        </c:when>
                                        <c:when test="${newOrder.status == 'COMPLETED'}">
                                            <span class="info-badge badge-completed">
                                                <i class="bi bi-check-circle me-1"></i>Completed
                                            </span>
                                        </c:when>
                                        <c:when test="${newOrder.status == 'CANCELLED'}">
                                            <span class="info-badge badge-cancelled">
                                                <i class="bi bi-x-circle me-1"></i>Cancelled
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="info-badge badge-pending">${newOrder.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- New Status -->
                            <div class="mb-4">
                                <label class="form-label"><i class="bi bi-gear me-2"></i>Update Status *</label>
                                <form:select class="form-select" path="status">
                                    <option value="PENDING" ${newOrder.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                    <option value="PROCESSING" ${newOrder.status == 'PROCESSING' ? 'selected' : ''}>Processing</option>
                                    <option value="COMPLETED" ${newOrder.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                    <option value="CANCELLED" ${newOrder.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                </form:select>
                                <small class="form-text text-muted">Select the new status for this order</small>
                            </div>

                            <!-- Status Information -->
                            <div class="alert alert-info">
                                <h6 class="alert-heading"><i class="bi bi-info-circle me-2"></i>Status Guide</h6>
                                <ul class="mb-0 small">
                                    <li><strong>Pending:</strong> Order is waiting to be processed</li>
                                    <li><strong>Processing:</strong> Order is being prepared for shipment</li>
                                    <li><strong>Completed:</strong> Order has been delivered successfully</li>
                                    <li><strong>Cancelled:</strong> Order has been cancelled</li>
                                </ul>
                            </div>

                            <!-- Submit Button -->
                            <div class="d-flex gap-2 justify-content-end">
                                <a href="/admin/order/${newOrder.id}" class="btn btn-secondary">
                                    <i class="bi bi-x-circle me-2"></i>Cancel
                                </a>
                                <button type="submit" class="btn btn-submit">
                                    <i class="bi bi-check-circle me-2"></i>Update Status
                                </button>
                            </div>
                        </form:form>
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
