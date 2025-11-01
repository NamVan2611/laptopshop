<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
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

        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(65, 84, 241, 0.3);
        }

        .filter-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
        }

        .table-card {
            background: white;
            border-radius: 10px;
            padding: 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .table thead {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
        }

        .table thead th {
            border: none;
            padding: 1rem;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid var(--border-color);
        }

        .table tbody tr:hover {
            background-color: #f8f9fc;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
        }

        .btn-action {
            padding: 0.4rem 0.8rem;
            margin: 0 0.2rem;
            border-radius: 5px;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-view {
            background-color: var(--success-color);
            border-color: var(--success-color);
            color: white;
        }

        .btn-view:hover {
            background-color: #26b05a;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(46, 202, 106, 0.3);
        }

        .btn-update {
            background-color: var(--warning-color);
            border-color: var(--warning-color);
            color: #333;
        }

        .btn-update:hover {
            background-color: #e0a800;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 193, 7, 0.3);
        }

        .btn-delete {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
            color: white;
        }

        .btn-delete:hover {
            background-color: #e64a19;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 87, 34, 0.3);
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .form-group {
            position: relative;
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

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .status-processing {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: var(--border-color);
        }
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main id="main" class="main">
        <div class="container-fluid px-4 py-4">
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h2 class="mb-1"><i class="bi bi-cart-check me-2"></i>Order Management</h2>
                        <p class="mb-0 opacity-75">Track and manage customer orders</p>
                    </div>
                </div>
            </div>

            <!-- Filter Card -->
            <div class="filter-card">
                <form method="GET" action="/admin/order" class="row g-3">
                    <input type="hidden" name="page" value="1">
                    
                    <!-- Search -->
                    <div class="col-md-6">
                        <div class="form-group">
                            <i class="bi bi-search search-icon"></i>
                            <input type="text" 
                                   class="form-control ps-5" 
                                   name="search" 
                                   placeholder="Search by name, phone, or address..." 
                                   value="${search}">
                        </div>
                    </div>

                    <!-- Status Filter -->
                    <div class="col-md-4">
                        <select class="form-select" name="status">
                            <option value="">All Statuses</option>
                            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>Pending</option>
                            <option value="PROCESSING" ${status == 'PROCESSING' ? 'selected' : ''}>Processing</option>
                            <option value="COMPLETED" ${status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                            <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                        </select>
                    </div>

                    <!-- Actions -->
                    <div class="col-md-2">
                        <div class="d-grid gap-2 d-md-flex">
                            <button type="submit" class="btn btn-primary flex-fill">
                                <i class="bi bi-funnel me-1"></i>Filter
                            </button>
                            <a href="/admin/order" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-counterclockwise"></i>
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Table Card -->
            <div class="table-card">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Customer</th>
                                <th>Contact</th>
                                <th>Address</th>
                                <th>Total Price</th>
                                <th>Status</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty order}">
                                    <c:forEach var="order" items="${order}">
                                        <tr>
                                            <td><strong>#${order.id}</strong></td>
                                            <td>
                                                <div class="fw-bold">${order.receiverName}</div>
                                                <small class="text-muted">User ID: ${order.user.id}</small>
                                            </td>
                                            <td>
                                                <i class="bi bi-telephone me-1"></i>${order.receiverPhone}
                                            </td>
                                            <td>
                                                <small>${order.receiverAddress}</small>
                                            </td>
                                            <td>
                                                <strong class="text-success">
                                                    <fmt:formatNumber type="number" value="${order.totalPrice}" pattern="#,##0" /> VNĐ
                                                </strong>
                                            </td>
                                            <td>
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
                                            </td>
                                            <td class="text-center">
                                                <a href="/admin/order/${order.id}"
                                                    class="btn btn-sm btn-action btn-view">
                                                    <i class="bi bi-eye"></i> View
                                                </a>
                                                <a href="/admin/order/update/${order.id}"
                                                    class="btn btn-sm btn-action btn-update">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </a>
                                                <a href="/admin/order/delete/${order.id}"
                                                    class="btn btn-sm btn-action btn-delete">
                                                    <i class="bi bi-trash"></i> Delete
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="empty-state">
                                            <i class="bi bi-inbox"></i>
                                            <h5>No orders found</h5>
                                            <p>Try adjusting your filters.</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" 
                               href="/admin/order?page=${currentPage - 1}&search=${search}&status=${status}" 
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                            <li class="page-item ${loop.index == currentPage ? 'active' : ''}">
                                <a class="page-link" 
                                   href="/admin/order?page=${loop.index}&search=${search}&status=${status}">
                                    ${loop.index}
                                </a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" 
                               href="/admin/order?page=${currentPage + 1}&search=${search}&status=${status}" 
                               aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
</body>

</html>
