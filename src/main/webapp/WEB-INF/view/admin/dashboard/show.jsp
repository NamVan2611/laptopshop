<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Admin Panel</title>
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
    <link href="/vendor/apexcharts/apexcharts.css" rel="stylesheet">
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

        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(65, 84, 241, 0.3);
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            transition: width 0.3s ease;
        }

        .stat-card:hover::before {
            width: 100%;
            opacity: 0.1;
        }

        .stat-card.primary::before {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        }

        .stat-card.success::before {
            background: linear-gradient(135deg, var(--success-color) 0%, #26b05a 100%);
        }

        .stat-card.warning::before {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e0a800 100%);
        }

        .stat-card.danger::before {
            background: linear-gradient(135deg, var(--danger-color) 0%, #e64a19 100%);
        }

        .stat-card.info::before {
            background: linear-gradient(135deg, var(--info-color) 0%, #138496 100%);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 1rem;
        }

        .stat-icon.primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
        }

        .stat-icon.success {
            background: linear-gradient(135deg, var(--success-color) 0%, #26b05a 100%);
            color: white;
        }

        .stat-icon.warning {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e0a800 100%);
            color: #333;
        }

        .stat-icon.danger {
            background: linear-gradient(135deg, var(--danger-color) 0%, #e64a19 100%);
            color: white;
        }

        .stat-icon.info {
            background: linear-gradient(135deg, var(--info-color) 0%, #138496 100%);
            color: white;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #212529;
            margin: 0.5rem 0;
        }

        .stat-label {
            color: #6c757d;
            font-weight: 500;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .stat-link {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s ease;
        }

        .stat-link:hover {
            color: var(--secondary-color);
            transform: translateX(5px);
        }

        .chart-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
            margin-bottom: 2rem;
        }

        .quick-action-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
        }

        .action-btn {
            padding: 1rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            margin-bottom: 0.75rem;
            border: none;
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .action-btn i {
            margin-right: 0.5rem;
            font-size: 1.2rem;
        }

        .revenue-badge {
            background: linear-gradient(135deg, var(--success-color) 0%, #26b05a 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            display: inline-block;
            margin-top: 0.5rem;
        }

        .trend-up {
            color: var(--success-color);
        }

        .trend-down {
            color: var(--danger-color);
        }
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main id="main" class="main">
        <div class="container-fluid px-4 py-4">
            <!-- Dashboard Header -->
            <div class="dashboard-header">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h2 class="mb-1"><i class="bi bi-speedometer2 me-2"></i>Dashboard Overview</h2>
                        <p class="mb-0 opacity-75">Welcome to the admin control panel</p>
                    </div>
                    <div class="text-end">
                        <p class="mb-0 opacity-75">Last updated: <span id="currentTime"></span></p>
                    </div>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-4 mb-4">
                <!-- Total Revenue -->
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card success">
                        <div class="stat-icon success">
                            <i class="bi bi-currency-dollar"></i>
                        </div>
                        <div class="stat-label">Total Revenue</div>
                        <div class="stat-value">
                            <fmt:formatNumber type="number" value="${totalRevenue}" pattern="#,##0" /> VNĐ
                        </div>
                        <a href="/admin/order" class="stat-link">
                            View Orders <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Total Orders -->
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card primary">
                        <div class="stat-icon primary">
                            <i class="bi bi-cart-check"></i>
                        </div>
                        <div class="stat-label">Total Orders</div>
                        <div class="stat-value">${countOrders}</div>
                        <a href="/admin/order" class="stat-link">
                            Manage Orders <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Total Products -->
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card info">
                        <div class="stat-icon info">
                            <i class="bi bi-box-seam"></i>
                        </div>
                        <div class="stat-label">Total Products</div>
                        <div class="stat-value">${countProducts}</div>
                        <div class="mt-2">
                            <small class="text-muted">Total Sold: <strong class="text-success">${totalSold}</strong> units</small>
                        </div>
                        <a href="/admin/product" class="stat-link">
                            Manage Products <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Total Users -->
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card warning">
                        <div class="stat-icon warning">
                            <i class="bi bi-people"></i>
                        </div>
                        <div class="stat-label">Total Users</div>
                        <div class="stat-value">${countUsers}</div>
                        <a href="/admin/user" class="stat-link">
                            Manage Users <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Order Status Cards -->
            <div class="row g-4 mb-4">
                <div class="col-xl-4 col-md-6">
                    <div class="stat-card">
                        <div class="d-flex align-items-center">
                            <div class="stat-icon warning" style="width: 50px; height: 50px; font-size: 1.5rem;">
                                <i class="bi bi-clock"></i>
                            </div>
                            <div class="ms-3 flex-grow-1">
                                <div class="stat-label">Pending Orders</div>
                                <div class="stat-value" style="font-size: 1.75rem;">${pendingOrders}</div>
                            </div>
                        </div>
                        <a href="/admin/order?status=PENDING" class="stat-link mt-2">
                            View Pending <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <div class="col-xl-4 col-md-6">
                    <div class="stat-card">
                        <div class="d-flex align-items-center">
                            <div class="stat-icon info" style="width: 50px; height: 50px; font-size: 1.5rem;">
                                <i class="bi bi-arrow-repeat"></i>
                            </div>
                            <div class="ms-3 flex-grow-1">
                                <div class="stat-label">Processing Orders</div>
                                <div class="stat-value" style="font-size: 1.75rem;">${processingOrders}</div>
                            </div>
                        </div>
                        <a href="/admin/order?status=PROCESSING" class="stat-link mt-2">
                            View Processing <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <div class="col-xl-4 col-md-6">
                    <div class="stat-card">
                        <div class="d-flex align-items-center">
                            <div class="stat-icon success" style="width: 50px; height: 50px; font-size: 1.5rem;">
                                <i class="bi bi-check-circle"></i>
                            </div>
                            <div class="ms-3 flex-grow-1">
                                <div class="stat-label">Completed Orders</div>
                                <div class="stat-value" style="font-size: 1.75rem;">${completedOrders}</div>
                            </div>
                        </div>
                        <a href="/admin/order?status=COMPLETED" class="stat-link mt-2">
                            View Completed <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Charts and Quick Actions Row -->
            <div class="row g-4">
                <!-- Chart Card -->
                <div class="col-lg-8">
                    <div class="chart-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold mb-0"><i class="bi bi-bar-chart me-2"></i>Sales Overview</h5>
                            <div class="btn-group btn-group-sm" role="group">
                                <button type="button" class="btn btn-outline-primary active">7 Days</button>
                                <button type="button" class="btn btn-outline-primary">30 Days</button>
                                <button type="button" class="btn btn-outline-primary">1 Year</button>
                            </div>
                        </div>
                        <div id="salesChart" style="height: 350px;"></div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="col-lg-4">
                    <div class="quick-action-card">
                        <h5 class="fw-bold mb-4"><i class="bi bi-lightning-charge me-2"></i>Quick Actions</h5>
                        <a href="/admin/product/create" class="btn btn-success action-btn w-100">
                            <i class="bi bi-plus-circle"></i> Add New Product
                        </a>
                        <a href="/admin/user/create" class="btn btn-primary action-btn w-100">
                            <i class="bi bi-person-plus"></i> Add New User
                        </a>
                        <a href="/admin/order?status=PENDING" class="btn btn-warning action-btn w-100">
                            <i class="bi bi-clock"></i> Review Pending Orders
                        </a>
                        <a href="/admin/product" class="btn btn-info action-btn w-100">
                            <i class="bi bi-box-seam"></i> Manage Products
                        </a>
                        <a href="/admin/user" class="btn btn-secondary action-btn w-100">
                            <i class="bi bi-people"></i> Manage Users
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <!-- Prepare chart data variables -->
    <c:set var="revenueBase" value="${totalRevenue != null ? totalRevenue : 0}" />
    <c:set var="ordersBase" value="${countOrders != null ? countOrders : 0}" />

    <!-- Vendor JS Files -->
    <script src="/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>

    <script>
        // Update current time
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleString('en-US', {
                weekday: 'short',
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
            document.getElementById('currentTime').textContent = timeString;
        }
        updateTime();
        setInterval(updateTime, 60000);

        // Initialize Sales Chart
        document.addEventListener("DOMContentLoaded", () => {
            const revenueBase = parseFloat('${revenueBase}' || '0');
            const ordersBase = parseInt('${ordersBase}' || '0');
            
            const salesChart = new ApexCharts(document.querySelector("#salesChart"), {
                series: [{
                    name: 'Revenue',
                    data: [
                        revenueBase,
                        Math.round(revenueBase * 0.85),
                        Math.round(revenueBase * 0.92),
                        Math.round(revenueBase * 1.1),
                        Math.round(revenueBase * 0.88),
                        Math.round(revenueBase * 1.15),
                        revenueBase
                    ]
                }, {
                    name: 'Orders',
                    data: [
                        ordersBase,
                        Math.max(0, ordersBase - 2),
                        Math.max(0, ordersBase - 1),
                        ordersBase + 3,
                        Math.max(0, ordersBase - 1),
                        ordersBase + 2,
                        ordersBase
                    ]
                }],
                chart: {
                    height: 350,
                    type: 'area',
                    toolbar: {
                        show: true,
                        tools: {
                            download: true,
                            selection: false,
                            zoom: true,
                            zoomin: true,
                            zoomout: true,
                            pan: false,
                            reset: true
                        }
                    }
                },
                colors: ['#4154f1', '#2eca6a'],
                dataLabels: {
                    enabled: false
                },
                stroke: {
                    curve: 'smooth',
                    width: 3
                },
                fill: {
                    type: 'gradient',
                    gradient: {
                        shadeIntensity: 1,
                        opacityFrom: 0.4,
                        opacityTo: 0.2,
                        stops: [0, 90, 100]
                    }
                },
                markers: {
                    size: 5,
                    hover: {
                        size: 7
                    }
                },
                xaxis: {
                    categories: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    labels: {
                        style: {
                            colors: '#6c757d',
                            fontSize: '12px'
                        }
                    }
                },
                yaxis: {
                    labels: {
                        style: {
                            colors: '#6c757d',
                            fontSize: '12px'
                        }
                    }
                },
                legend: {
                    position: 'top',
                    horizontalAlign: 'right',
                    floating: true,
                    offsetY: -25,
                    offsetX: -5
                },
                tooltip: {
                    theme: 'light',
                    y: {
                        formatter: function(val) {
                            return val.toLocaleString('en-US');
                        }
                    }
                },
                grid: {
                    borderColor: '#e3e6f0',
                    strokeDashArray: 4,
                    xaxis: {
                        lines: {
                            show: true
                        }
                    },
                    yaxis: {
                        lines: {
                            show: true
                        }
                    }
                }
            });

            salesChart.render();
        });
    </script>
</body>

</html>
