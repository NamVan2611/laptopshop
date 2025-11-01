<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
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
    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
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

        .btn-create {
            background: linear-gradient(135deg, var(--success-color) 0%, #26b05a 100%);
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-create:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(46, 202, 106, 0.4);
            color: white;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(65, 84, 241, 0.25);
        }

        .pagination .page-link {
            color: var(--primary-color);
            border-color: var(--border-color);
        }

        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border-color: var(--primary-color);
        }

        .badge {
            padding: 0.5rem 0.75rem;
            font-weight: 500;
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
                        <h2 class="mb-1"><i class="bi bi-box-seam me-2"></i>Product Management</h2>
                        <p class="mb-0 opacity-75">Manage your product inventory efficiently</p>
                    </div>
                    <a href="/admin/product/create" class="btn btn-create">
                        <i class="bi bi-plus-circle me-2"></i>Create New Product
                    </a>
                </div>
            </div>

            <!-- Filter Card -->
            <div class="filter-card">
                <form method="GET" action="/admin/product" class="row g-3">
                    <input type="hidden" name="page" value="1">
                    
                    <!-- Search -->
                    <div class="col-md-4">
                        <div class="form-group">
                            <i class="bi bi-search search-icon"></i>
                            <input type="text" 
                                   class="form-control ps-5" 
                                   name="search" 
                                   placeholder="Search by name or factory..." 
                                   value="${search}">
                        </div>
                    </div>

                    <!-- Factory Filter -->
                    <div class="col-md-3">
                        <select class="form-select" name="factory">
                            <option value="">All Factories</option>
                            <option value="APPLE" ${factory == 'APPLE' ? 'selected' : ''}>Apple</option>
                            <option value="LENOVO" ${factory == 'LENOVO' ? 'selected' : ''}>Lenovo</option>
                            <option value="ACER" ${factory == 'ACER' ? 'selected' : ''}>Acer</option>
                            <option value="ASUS" ${factory == 'ASUS' ? 'selected' : ''}>Asus</option>
                            <option value="DELL" ${factory == 'DELL' ? 'selected' : ''}>Dell</option>
                            <option value="LG" ${factory == 'LG' ? 'selected' : ''}>LG</option>
                        </select>
                    </div>

                    <!-- Target Filter -->
                    <div class="col-md-3">
                        <select class="form-select" name="target">
                            <option value="">All Targets</option>
                            <option value="GAMING" ${target == 'GAMING' ? 'selected' : ''}>Gaming</option>
                            <option value="OFFICE" ${target == 'OFFICE' ? 'selected' : ''}>Office</option>
                            <option value="DESIGN" ${target == 'DESIGN' ? 'selected' : ''}>Design</option>
                            <option value="CONVENIENT" ${target == 'CONVENIENT' ? 'selected' : ''}>Convenient</option>
                        </select>
                    </div>

                    <!-- Actions -->
                    <div class="col-md-2">
                        <div class="d-grid gap-2 d-md-flex">
                            <button type="submit" class="btn btn-primary flex-fill">
                                <i class="bi bi-funnel me-1"></i>Filter
                            </button>
                            <a href="/admin/product" class="btn btn-outline-secondary">
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
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Factory</th>
                                <th>Target</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty products}">
                                    <c:forEach var="product" items="${products}">
                                        <tr>
                                            <td><strong>#${product.id}</strong></td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div>
                                                        <div class="fw-bold">${product.name}</div>
                                                        <small class="text-muted">${product.shortDesc}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-success">
                                                    <fmt:formatNumber type="number" value="${product.price}" pattern="#,##0" /> VNĐ
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${product.quantity}</span>
                                            </td>
                                            <td>
                                                <span class="badge bg-primary">${product.factory}</span>
                                            </td>
                                            <td>
                                                <span class="badge bg-secondary">${product.target}</span>
                                            </td>
                                            <td class="text-center">
                                                <a href="/admin/product/${product.id}"
                                                    class="btn btn-sm btn-action btn-view">
                                                    <i class="bi bi-eye"></i> View
                                                </a>
                                                <a href="/admin/product/update/${product.id}"
                                                    class="btn btn-sm btn-action btn-update">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </a>
                                                <a href="/admin/product/delete/${product.id}"
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
                                            <h5>No products found</h5>
                                            <p>Try adjusting your filters or create a new product.</p>
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
                               href="/admin/product?page=${currentPage - 1}&search=${search}&factory=${factory}&target=${target}" 
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                            <li class="page-item ${loop.index == currentPage ? 'active' : ''}">
                                <a class="page-link" 
                                   href="/admin/product?page=${loop.index}&search=${search}&factory=${factory}&target=${target}">
                                    ${loop.index}
                                </a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" 
                               href="/admin/product?page=${currentPage + 1}&search=${search}&factory=${factory}&target=${target}" 
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
