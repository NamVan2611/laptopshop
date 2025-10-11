<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <title>Update order</title>
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
                    <link href="/vendor/quill/quill.snow.css" rel="stylesheet">
                    <link href="/vendor/quill/quill.bubble.css" rel="stylesheet">
                    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">
                    <link href="/vendor/simple-datatables/style.css" rel="stylesheet">

                    <!-- Template Main CSS File -->
                    <link href="/css/style.css" rel="stylesheet">
                </head>

                <body>
                    <jsp:include page="../layout/header.jsp" />

                    <jsp:include page="../layout/sidebar.jsp" />

                    <main id="main" class="main">
                        <div class="container-fluid px-4">
                            <div class="container mt-5">
                                <div class="row">
                                    <div class="col-md-6 col-12 mx-auto">
                                        <h2>Update a order</h2>
                                        <hr>
                                        <form:form method="post" action="/admin/order/update" modelAttribute="newOrder"
                                            class="row" enctype="multipart/form-data">
                                            <div class="mb-3 col-6">
                                                <div class="mb-3" style="display: none;">
                                                    <label class="form-label">Id:</label>
                                                    <form:input type="text" class="form-control" path="id" />
                                                </div>
                                                <label class="form-label">Status: </label>
                                                <form:select class="form-select" path="status">
                                                    <option value="PENDING">Pending</option>
                                                    <option value="COMPLETE">Complete</option>
                                                    <option value="SHIPPING">Shipping</option>
                                                </form:select>
                                            </div>

                                            <div class="mb-3">
                                                <button class="btn btn-warning">Update</button>
                                            </div>
                                        </form:form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                    <jsp:include page="../layout/footer.jsp" />
                    
                    <script src="/vendor/apexcharts/apexcharts.min.js"></script>
                    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                    <script src="/vendor/chart.js/chart.umd.js"></script>
                    <script src="/vendor/echarts/echarts.min.js"></script>
                    <script src="/vendor/quill/quill.js"></script>
                    <script src="/vendor/simple-datatables/simple-datatables.js"></script>
                    <script src="/vendor/tinymce/tinymce.min.js"></script>
                    <script src="/vendor/php-email-form/validate.js"></script>
                    <script src="/js/main.js"></script>
                </body>

                </html>