<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details</title>
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

        .user-avatar-container {
            text-align: center;
            margin-bottom: 2rem;
        }

        .user-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid white;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
        }

        .user-avatar:hover {
            transform: scale(1.05);
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

        .badge-role {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            font-weight: 600;
            border-radius: 20px;
        }

        .badge-admin {
            background-color: #dc3545;
            color: white;
        }

        .badge-user {
            background-color: var(--success-color);
            color: white;
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

    <main class="main" id="main">
        <div class="container-fluid px-4 py-4">
            <!-- Header -->
            <div class="detail-header">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h2 class="mb-1"><i class="bi bi-person-circle me-2"></i>User Details</h2>
                        <p class="mb-0 opacity-75">ID: #${user.id}</p>
                    </div>
                    <a href="/admin/user" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="detail-card">
                        <!-- Avatar Section -->
                        <div class="user-avatar-container">
                            <img src="/images/avatar/${user.avatar}" 
                                 alt="${user.fullName}" 
                                 class="user-avatar"
                                 onerror="this.src='/img/profile-img.jpg'">
                            <h4 class="fw-bold mt-3 mb-1">${user.fullName}</h4>
                            <p class="text-muted mb-0">${user.email}</p>
                        </div>

                        <!-- Information Section -->
                        <h5 class="fw-bold mb-4"><i class="bi bi-info-circle me-2"></i>User Information</h5>
                        
                        <div class="info-section">
                            <div class="info-item">
                                <div class="info-icon primary">
                                    <i class="bi bi-person"></i>
                                </div>
                                <div class="info-label">Full Name:</div>
                                <div class="info-value">${user.fullName}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon success">
                                    <i class="bi bi-envelope"></i>
                                </div>
                                <div class="info-label">Email:</div>
                                <div class="info-value">${user.email}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon info">
                                    <i class="bi bi-telephone"></i>
                                </div>
                                <div class="info-label">Phone:</div>
                                <div class="info-value">${user.phone != null ? user.phone : 'N/A'}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon primary">
                                    <i class="bi bi-geo-alt"></i>
                                </div>
                                <div class="info-label">Address:</div>
                                <div class="info-value">${user.address != null ? user.address : 'N/A'}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon success">
                                    <i class="bi bi-shield-check"></i>
                                </div>
                                <div class="info-label">Role:</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${user.role.name == 'ADMIN'}">
                                            <span class="badge badge-role badge-admin">
                                                <i class="bi bi-shield-check me-1"></i>Administrator
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-role badge-user">
                                                <i class="bi bi-person me-1"></i>User
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="action-buttons">
                            <a href="/admin/user/update/${user.id}" class="btn btn-warning btn-action">
                                <i class="bi bi-pencil me-2"></i>Edit User
                            </a>
                            <a href="/admin/user/delete/${user.id}" class="btn btn-danger btn-action">
                                <i class="bi bi-trash me-2"></i>Delete User
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
