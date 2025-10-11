<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta content="width=device-width, initial-scale=1.0" name="viewport">

            <title>Dashboard - NiceAdmin Bootstrap Template</title>
            <meta content="" name="description">
            <meta content="" name="keywords">

            <!-- Favicons -->
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

            <!-- ======= Header ======= -->
            <jsp:include page="../layout/header.jsp" />
            <!-- ======= Sidebar ======= -->
            <jsp:include page="../layout/sidebar.jsp" />

            <main id="main" class="main">

                <div class="pagetitle">
                    <h1>Dashboard</h1>
                    <nav>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="admin/dashboard">Home</a></li>
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                    </nav>
                </div><!-- End Page Title -->

                <section class="section dashboard">
                    <div class="row">

                        <div class="col-lg-12">
                            <div class="row">
                                <!-- Order Card -->
                                <div class="col-xxl-4 col-md-6">
                                    <div class="card info-card sales-card">
                                        <div class="filter">
                                            <a class="icon" data-bs-toggle="dropdown"><i
                                                    class="bi bi-three-dots"></i></a>
                                        </div>
                                        <div class="card-body">
                                            <h5 class="card-title">Orders</h5>

                                            <div class="d-flex align-items-center">
                                                <div
                                                    class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                    <i class="bi bi-cart"></i>
                                                </div>
                                                <div class="ps-3">
                                                    <h6>
                                                        <div class="card-body">Order (${countOrders})</div>
                                                    </h6>
                                                    <span style="margin-left: 30px;" class="text-muted small pt-2 ps-1">
                                                        <a href="/admin/order">View Details</a>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- End Order Card -->

                                <!-- User Card -->
                                <div class="col-xxl-4 col-md-6">
                                    <div class="card info-card revenue-card">
                                        <div class="filter">
                                            <a class="icon" data-bs-toggle="dropdown"><i
                                                    class="bi bi-three-dots"></i></a>
                                        </div>

                                        <div class="card-body">
                                            <h5 class="card-title">Users</h5>
                                            <div class="d-flex align-items-center">
                                                <div
                                                    class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                    <i class="bi bi-people"></i>
                                                </div>
                                                <div class="ps-3">
                                                    <h6>
                                                        <div class="card-body">User (${countUsers})</div>
                                                    </h6>
                                                    <span style="margin-left: 30px;" class="text-muted small pt-2 ps-1">
                                                        <a href="/admin/user">View Details</a>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div><!-- End User Card -->

                                <!-- Product Card -->
                                <div class="col-xxl-4 col-md-6">
                                    <div class="card info-card customers-card">
                                        <div class="filter">
                                            <a class="icon" data-bs-toggle="dropdown"><i
                                                    class="bi bi-three-dots"></i></a>
                                        </div>

                                        <div class="card-body">
                                            <h5 class="card-title">Products</h5>
                                            <div class="d-flex align-items-center">
                                                <div
                                                    class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                    <i class="bi bi-laptop"></i>
                                                </div>
                                                <div class="ps-3">
                                                    <h6>
                                                        <div class="card-body">Product (${countProducts})</div>
                                                    </h6>
                                                    <span style="margin-left: 30px;" class="text-muted small pt-2 ps-1">
                                                        <a href="/admin/product">View Details</a>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div><!-- End Product Card -->

                                <!-- Top Selling -->
                                <div class="col-12">
                                    <div class="card">

                                        <div class="filter">
                                            <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                    class="bi bi-three-dots"></i></a>
                                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                <li class="dropdown-header text-start">
                                                    <h6>Filter</h6>
                                                </li>

                                                <li><a class="dropdown-item" href="#">Today</a></li>
                                                <li><a class="dropdown-item" href="#">This Month</a></li>
                                                <li><a class="dropdown-item" href="#">This Year</a></li>
                                            </ul>
                                        </div>

                                        <div class="card-body">
                                            <h5 class="card-title">Reports <span>/Today</span></h5>

                                            <!-- Line Chart -->
                                            <div id="reportsChart"></div>

                                            <script>
                                                document.addEventListener("DOMContentLoaded", () => {
                                                    new ApexCharts(document.querySelector("#reportsChart"), {
                                                        series: [{
                                                            name: 'Sales',
                                                            data: [31, 40, 28, 51, 42, 82, 56],
                                                        }, {
                                                            name: 'Revenue',
                                                            data: [11, 32, 45, 32, 34, 52, 41]
                                                        }, {
                                                            name: 'Customers',
                                                            data: [15, 11, 32, 18, 9, 24, 11]
                                                        }],
                                                        chart: {
                                                            height: 350,
                                                            type: 'area',
                                                            toolbar: {
                                                                show: false
                                                            },
                                                        },
                                                        markers: {
                                                            size: 4
                                                        },
                                                        colors: ['#4154f1', '#2eca6a', '#ff771d'],
                                                        fill: {
                                                            type: "gradient",
                                                            gradient: {
                                                                shadeIntensity: 1,
                                                                opacityFrom: 0.3,
                                                                opacityTo: 0.4,
                                                                stops: [0, 90, 100]
                                                            }
                                                        },
                                                        dataLabels: {
                                                            enabled: false
                                                        },
                                                        stroke: {
                                                            curve: 'smooth',
                                                            width: 2
                                                        },
                                                        xaxis: {
                                                            type: 'datetime',
                                                            categories: ["2018-09-19T00:00:00.000Z", "2018-09-19T01:30:00.000Z", "2018-09-19T02:30:00.000Z", "2018-09-19T03:30:00.000Z", "2018-09-19T04:30:00.000Z", "2018-09-19T05:30:00.000Z", "2018-09-19T06:30:00.000Z"]
                                                        },
                                                        tooltip: {
                                                            x: {
                                                                format: 'dd/MM/yy HH:mm'
                                                            },
                                                        }
                                                    }).render();
                                                });
                                            </script>
                                            <!-- End Line Chart -->

                                        </div>

                                    </div>
                                </div><!-- End Reports -->
                            </div>
                        </div><!-- End Left side columns -->

                    </div>
                </section>

            </main><!-- End #main -->

            <!-- ======= Footer ======= -->
            <jsp:include page="../layout/footer.jsp" />


            <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                    class="bi bi-arrow-up-short"></i></a>

            <!-- Vendor JS Files -->
            <script src="/vendor/apexcharts/apexcharts.min.js"></script>
            <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            <script src="/vendor/chart.js/chart.umd.js"></script>
            <script src="/vendor/echarts/echarts.min.js"></script>
            <script src="/vendor/quill/quill.js"></script>
            <script src="/vendor/simple-datatables/simple-datatables.js"></script>
            <script src="/vendor/tinymce/tinymce.min.js"></script>
            <script src="/vendor/php-email-form/validate.js"></script>

            <!-- Template Main JS File -->
            <script src="/js/main.js"></script>

        </body>

        </html>