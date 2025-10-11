<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <title>Create user</title>
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
                    <script>
                        $(document).ready(() => {
                            const avatarFile = $("#avatarFile");
                            avatarFile.change(function (e) {
                                const imgURL = URL.createObjectURL(e.target.files[0]);
                                $("#avatarPreview").attr("src", imgURL);
                                $("#avatarPreview").css({ "display": "block" });
                            });
                        });
                    </script>
                </head>

                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/sidebar.jsp" />
                <main id="main" class="main">
                    <div class="container-fluid px-4">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h2>Create a user</h2>
                                    <hr>
                                    <form:form method="post" action="/admin/user/create" modelAttribute="newUser"
                                        class="row" enctype="multipart/form-data">
                                        <div class="mb-3 col-6">
                                            <c:set var="errorEmail">
                                                <form:errors path="email" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Email:</label>
                                            <form:input type="email"
                                                class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                path="email" />
                                            ${errorEmail}
                                        </div>
                                        <div class="mb-3 col-6">
                                            <c:set var="errorPassword">
                                                <form:errors path="password" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Password:</label>
                                            <form:input type="password"
                                                class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                path="password" />
                                            ${errorPassword}
                                        </div>
                                        <div class="mb-3 col-6">
                                            <c:set var="errorFullname">
                                                <form:errors path="fullName" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Fullname:</label>
                                            <form:input type="text"
                                                class="form-control ${not empty errorFullname ? 'is-invalid': ''}"
                                                path="fullName" />
                                            ${errorFullname}
                                        </div>
                                        <div class="mb-3 col-6">
                                            <label class="form-label">Address:</label>
                                            <form:input type="text" class="form-control" path="address" />
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Phone:</label>
                                            <form:input type="text" class="form-control" path="phone" />
                                        </div>
                                        <div class="mb-3 col-6">
                                            <label class="form-label">Role</label>
                                            <form:select class="form-select" path="role.name">
                                                <option value="ADMIN">Admin</option>
                                                <option value="USER">User</option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-6">
                                            <label for="avatarFile" class="form-label">Avatar :</label>
                                            <input class="form-control" type="file" id="avatarFile"
                                                accept=".png, .jpg, .jpeg" name="file" />
                                        </div>
                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                id="avatarPreview" name="file" />
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