<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Dashboard - SB Admin</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <div id="layoutSidenav_nav">
                            <jsp:include page="../layout/sidebar.jsp" />
                        </div>
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <div class="container mt-5">
                                        <div class="row">
                                            <div class="col-12 col-12 mx-auto">
                                                <div class="d-flex justify-content-between">
                                                    <h3>Table product</h3>
                                                    <a href="/admin/product/create" class="btn btn-primary">Create</a>
                                                </div>
                                                <hr>
                                                <table class="table table-bordred table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Name</th>
                                                            <th>Price</th>
                                                            <th>Factory</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <c:forEach var="product" items="${products}">
                                                        <tr>
                                                            <td>${product.id}</td>
                                                            <td>${product.name}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number" value="${product.price}"
                                                                    pattern="#,##0" />
                                                            </td>
                                                            <td>${product.factory}</td>
                                                            <td>
                                                                <a href="/admin/product/${product.id}"
                                                                    class="btn btn-success">View</a>
                                                                <a href="/admin/product/update/${product.id}"
                                                                    class="btn btn-warning">Update</a>
                                                                <a href="/admin/product/delete/${product.id}"
                                                                    class="btn btn-danger">Delete</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item">
                                            <a class="${1 eq currentPage? 'disabled page-link' : 'page-link'}" href="/admin/product?page=${currentPage - 1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <c:forEach begin="0" end="${totalPages-1}" varStatus="loop">
                                            <li class="page-item"><a
                                                    class="${(loop.index + 1) eq currentPage? 'page-link active' : 'page-link'}"
                                                    href="/admin/product?page=${loop.index + 1}">${loop.index + 1}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item">
                                            <a class="${totalPages eq currentPage? 'disabled page-link' : 'page-link'}" href="/admin/product?page=${currentPage + 1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </main>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="js/scripts.js"></script>
                </body>

                </html>