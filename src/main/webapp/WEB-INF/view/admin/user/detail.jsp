<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>User Detail</title>

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
                    <link href="/vendor/quill/quill.snow.css" rel="stylesheet">
                    <link href="/vendor/quill/quill.bubble.css" rel="stylesheet">
                    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">
                    <link href="/vendor/simple-datatables/style.css" rel="stylesheet">
                    <link href="/css/style.css" rel="stylesheet">

                    <style>
                        .user-detail-card {
                            max-width: 600px;
                            margin: 40px auto;
                            border-radius: 15px;
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                            overflow: hidden;
                        }

                        .user-header {
                            background: linear-gradient(135deg, #0d6efd, #1e40af);
                            color: white;
                            text-align: center;
                            padding: 40px 20px 60px 20px;
                            position: relative;
                        }

                        .user-avatar {
                            width: 130px;
                            height: 130px;
                            border-radius: 50%;
                            object-fit: cover;
                            border: 4px solid #fff;
                            background-color: #f8f9fa;
                            position: absolute;
                            left: 50%;
                            bottom: -65px;
                            transform: translateX(-50%);
                        }

                        .user-body {
                            padding: 80px 20px 30px 20px;
                        }

                        .user-body .list-group-item {
                            border: none;
                            padding: 12px 0;
                            font-size: 1rem;
                        }

                        .user-body strong {
                            width: 120px;
                            display: inline-block;
                            color: #012970;
                        }

                        .btn-back {
                            margin-top: 30px;
                        }
                    </style>
                </head>

                <body>
                    <jsp:include page="../layout/header.jsp" />
                    <jsp:include page="../layout/sidebar.jsp" />

                    <main class="main" id="main">
                        <div class="container-fluid px-4">
                            <div class="user-detail-card bg-white">
                                <div class="user-header">
                                    <h3 class="fw-bold">User Detail</h3>
                                    <p class="mb-0">ID: ${user.id}</p>
                                    <img src="<c:out value='${user.avatar != null ? " /images/avatar/" +=user.avatar
                                        : "/img/default-avatar.png" }' />"
                                    alt="Avatar" class="user-avatar">
                                </div>

                                <div class="user-body text-center">
                                    <h5 class="fw-bold mb-1 mt-2">${user.fullName}</h5>
                                    <p class="text-muted mb-4">${user.email}</p>

                                    <ul class="list-group text-start">
                                        <li class="list-group-item"><strong>Full Name:</strong> ${user.fullName}</li>
                                        <li class="list-group-item"><strong>Email:</strong> ${user.email}</li>
                                        <li class="list-group-item"><strong>Phone:</strong> ${user.phone}</li>
                                        <li class="list-group-item"><strong>Address:</strong> ${user.address}</li>
                                        <li class="list-group-item"><strong>Role:</strong> ${user.role.name}</li>
                                    </ul>

                                    <div class="btn-back">
                                        <a href="/admin/user" class="btn btn-outline-primary px-4">
                                            <i class="bi bi-arrow-left-circle me-1"></i> Back
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Vendor JS -->
                    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                    <script src="/vendor/apexcharts/apexcharts.min.js"></script>
                    <script src="/vendor/chart.js/chart.umd.js"></script>
                    <script src="/vendor/echarts/echarts.min.js"></script>
                    <script src="/vendor/quill/quill.js"></script>
                    <script src="/vendor/simple-datatables/simple-datatables.js"></script>
                    <script src="/vendor/tinymce/tinymce.min.js"></script>
                    <script src="/vendor/php-email-form/validate.js"></script>
                    <script src="/js/main.js"></script>
                </body>

                </html>