<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <title>Create product</title>
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
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <script>
                        $(document).ready(() => {
                            const imageFile = $("#imageFile");
                            imageFile.change(function (e) {
                                const imgURL = URL.createObjectURL(e.target.files[0]);
                                $("#imagePreview").attr("src", imgURL);
                                $("#imagePreview").css({ "display": "block" });
                            });
                        });
                    </script>
                </head>

                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/sidebar.jsp" />

                <main class="main" id="main">
                    <div class="container-fluid px-4">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h2>Create a product</h2>
                                    <hr>
                                    <form:form method="post" action="/admin/product/create" modelAttribute="newProduct"
                                        class="row" enctype="multipart/form-data">
                                        <div class="mb-3 col-6">
                                            <c:set var="errorName">
                                                <form:errors path="name" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Name:</label>
                                            <form:input type="text"
                                                class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                path="name" />
                                            ${errorName}
                                        </div>
                                        <div class="mb-3 col-6">
                                            <c:set var="errorPrice">
                                                <form:errors path="price" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Price:</label>
                                            <form:input type="text"
                                                class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                path="price" />
                                            ${errorPrice}
                                        </div>
                                        <div class="mb-3">
                                            <c:set var="errorDetailDesc">
                                                <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Detail description:</label>
                                            <form:textarea type="text"
                                                class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                                path="detailDesc" />
                                            ${errorDetailDesc}
                                        </div>
                                        <div class="mb-3 col-6">
                                            <c:set var="errorShortDesc">
                                                <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Short description:</label>
                                            <form:input type="text"
                                                class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}"
                                                path="shortDesc" />
                                            ${errorShortDesc}
                                        </div>
                                        <div class="mb-3 col-6">
                                            <c:set var="errorQuantity">
                                                <form:errors path="quantity" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Quantity:</label>
                                            <form:input type="text"
                                                class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                                                path="quantity" />
                                            ${errorQuantity}
                                        </div>
                                        <div class="mb-3 col-6">
                                            <label class="form-label">Factory: </label>
                                            <form:select class="form-select" path="factory">
                                                <option value="APPLE">Apple</option>
                                                <option value="LENOVO">Lenovo</option>
                                                <option value="ACER">Acer</option>
                                                <option value="ACER">Asus</option>
                                                <option value="DELL">Dell</option>
                                                <option value="LG">LG</option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-6">
                                            <label class="form-label">Target: </label>
                                            <form:select class="form-select" path="target">
                                                <option value="GAMING">Gaming</option>
                                                <option value="OFFICE">Office</option>
                                                <option value="DESIGN">Design</option>
                                                <option value="CONVENIENT">Convenient</option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="imageFile" class="form-label">Image:</label>
                                            <input class="form-control" type="file" id="imageFile"
                                                accept=".png, .jpg, .jpeg" name="file" />
                                        </div>
                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="image preview"
                                                id="imagePreview" name="file" />
                                        </div>
                                        <div class="mb-3">
                                            <button class="btn btn-primary">Create</button>
                                        </div>
                                    </form:form>
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