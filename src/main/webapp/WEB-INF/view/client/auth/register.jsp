<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Register - Laptopshop</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <style>
                    /* Thêm style nhẹ cho phần avatar */
                    #avatarPreview {
                        display: none;
                        width: 340px;
                        height: 240px;
                        object-fit: cover;
                        margin-top: 10px;
                        margin-left: 170px;
                        box-shadow: 0 0 10px rgba(13, 110, 253, 0.4);
                    }

                    label.form-label {
                        font-weight: 500;
                    }
                </style>
            </head>

            <body class="bg-primary">
                <div id="layoutAuthentication">
                    <div id="layoutAuthentication_content">
                        <main>
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-lg-7">
                                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                                            <div class="card-header">
                                                <h3 class="text-center font-weight-light my-4">Create Account</h3>
                                            </div>
                                            <div class="card-body">
                                                <form:form action="/register" method="POST"
                                                    modelAttribute="registerUser" enctype="multipart/form-data">

                                                    <!-- Họ và tên -->
                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input path="firstName"
                                                                    class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}"
                                                                    id="inputFirstName" type="text"
                                                                    placeholder="Enter your first name" />
                                                                <label for="inputFirstName">First name</label>
                                                                <form:errors path="firstName"
                                                                    cssClass="invalid-feedback" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-floating">
                                                                <form:input path="lastName" class="form-control"
                                                                    id="inputLastName" type="text"
                                                                    placeholder="Enter your last name" />
                                                                <label for="inputLastName">Last name</label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Email -->
                                                    <div class="form-floating mb-3">
                                                        <form:input path="email"
                                                            class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                            id="inputEmail" type="email"
                                                            placeholder="name@example.com" />
                                                        <label for="inputEmail">Email address</label>
                                                        <form:errors path="email" cssClass="invalid-feedback" />
                                                    </div>

                                                    <div class="form-floating mb-3">
                                                        <form:input path="phone" class="form-control" id="inputPhone"
                                                            placeholder="Enter your phone" />
                                                        <label for="inputPhone">Phone</label>
                                                    </div>

                                                    <div class="form-floating mb-3">
                                                        <form:input path="address" class="form-control"
                                                            id="inputAddress" placeholder="Enter your address" />
                                                        <label for="inputAddress">Address</label>
                                                    </div>

                                                    <!-- Password + Confirm -->
                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input path="password"
                                                                    class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                                    id="inputPassword" type="password"
                                                                    placeholder="Create a password" />
                                                                <label for="inputPassword">Password</label>
                                                                <form:errors path="password"
                                                                    cssClass="invalid-feedback" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input path="confirmPassword"
                                                                    class="form-control ${not empty errorConfirmPassword ? 'is-invalid' : ''}"
                                                                    id="inputPasswordConfirm" type="password"
                                                                    placeholder="Confirm password" />
                                                                <label for="inputPasswordConfirm">Confirm
                                                                    Password</label>
                                                                <form:errors path="confirmPassword"
                                                                    cssClass="invalid-feedback" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-floating mb-3">
                                                        <form:input path="avatar" type="file" class="form-control"
                                                            id="inputAvatar" />
                                                        <label for="inputAvatar">Avatar</label>
                                                        <img id="avatarPreview" alt="Avatar Preview" />
                                                    </div>

                                                    <!-- Nút Submit -->
                                                    <div class="mt-4 mb-0">
                                                        <div class="d-grid">
                                                            <button type="submit" class="btn btn-primary btn-lg">
                                                                <i class="fa-solid fa-user-plus"></i> Create Account
                                                            </button>
                                                        </div>
                                                    </div>

                                                </form:form>
                                            </div>
                                            <div class="card-footer text-center py-3">
                                                <div class="small">
                                                    <a href="/login">Have an account? Go to login</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

                <script>
                    // Preview avatar
                    document.getElementById("inputAvatar").addEventListener("change", function (e) {
                        const preview = document.getElementById("avatarPreview");
                        const file = e.target.files[0];
                        if (file) {
                            preview.src = URL.createObjectURL(file);
                            preview.style.display = "block";
                        } else {
                            preview.style.display = "none";
                        }
                    });
                </script>

            </body>

            </html>