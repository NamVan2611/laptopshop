<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create User</title>
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
    <link href="/css/style.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
        :root {
            --primary-color: #4154f1;
            --success-color: #2eca6a;
            --danger-color: #ff5722;
            --light-bg: #f8f9fc;
            --border-color: #e3e6f0;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Poppins', sans-serif;
        }

        .form-header {
            background: linear-gradient(135deg, var(--success-color) 0%, #26b05a 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(46, 202, 106, 0.3);
        }

        .form-card {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(65, 84, 241, 0.25);
        }

        .avatar-preview-container {
            text-align: center;
            padding: 1rem;
            background-color: #f8f9fc;
            border-radius: 8px;
            border: 2px dashed var(--border-color);
            min-height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .avatar-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--success-color) 0%, #26b05a 100%);
            border: none;
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(46, 202, 106, 0.4);
            color: white;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .invalid-feedback {
            display: block;
            font-size: 0.875rem;
            color: var(--danger-color);
            margin-top: 0.25rem;
        }
    </style>

    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                if (e.target.files && e.target.files[0]) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL);
                    $("#avatarPreview").css({ "display": "block" });
                    $(".avatar-preview-container").css("background-color", "#fff");
                    $("#previewPlaceholder").hide();
                }
            });
        });
    </script>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main id="main" class="main">
        <div class="container-fluid px-4 py-4">
            <!-- Header -->
            <div class="form-header">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h2 class="mb-1"><i class="bi bi-person-plus me-2"></i>Create New User</h2>
                        <p class="mb-0 opacity-75">Add a new user to the system</p>
                    </div>
                    <a href="/admin/user" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>

            <!-- Form Card -->
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="form-card">
                        <form:form method="post" action="/admin/user/create" modelAttribute="newUser"
                            class="row" enctype="multipart/form-data">
                            
                            <!-- Email -->
                            <div class="form-group col-md-6">
                                <c:set var="errorEmail">
                                    <form:errors path="email" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label"><i class="bi bi-envelope me-1"></i>Email *</label>
                                <form:input type="email"
                                    class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                    path="email" placeholder="user@example.com" />
                                ${errorEmail}
                            </div>

                            <!-- Password -->
                            <div class="form-group col-md-6">
                                <c:set var="errorPassword">
                                    <form:errors path="password" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label"><i class="bi bi-lock me-1"></i>Password *</label>
                                <form:input type="password"
                                    class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                    path="password" placeholder="Enter password" />
                                ${errorPassword}
                            </div>

                            <!-- Full Name -->
                            <div class="form-group col-md-6">
                                <c:set var="errorFullname">
                                    <form:errors path="fullName" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label"><i class="bi bi-person me-1"></i>Full Name *</label>
                                <form:input type="text"
                                    class="form-control ${not empty errorFullname ? 'is-invalid' : ''}"
                                    path="fullName" placeholder="Enter full name" />
                                ${errorFullname}
                            </div>

                            <!-- Phone -->
                            <div class="form-group col-md-6">
                                <label class="form-label"><i class="bi bi-telephone me-1"></i>Phone</label>
                                <form:input type="text" class="form-control" path="phone" placeholder="Enter phone number" />
                            </div>

                            <!-- Address -->
                            <div class="form-group col-12">
                                <label class="form-label"><i class="bi bi-geo-alt me-1"></i>Address</label>
                                <form:input type="text" class="form-control" path="address" placeholder="Enter address" />
                            </div>

                            <!-- Role -->
                            <div class="form-group col-md-6">
                                <label class="form-label"><i class="bi bi-shield-check me-1"></i>Role *</label>
                                <form:select class="form-select" path="role.name">
                                    <option value="USER">User</option>
                                    <option value="ADMIN">Administrator</option>
                                </form:select>
                            </div>

                            <!-- Avatar Upload -->
                            <div class="form-group col-md-6">
                                <label for="avatarFile" class="form-label"><i class="bi bi-image me-1"></i>Avatar</label>
                                <input class="form-control" type="file" id="avatarFile"
                                    accept=".png, .jpg, .jpeg" name="file" />
                                <small class="form-text text-muted">Accepted formats: PNG, JPG, JPEG</small>
                            </div>

                            <!-- Avatar Preview -->
                            <div class="form-group col-12">
                                <div class="avatar-preview-container">
                                    <img id="avatarPreview" class="avatar-preview" style="display: none;" alt="Avatar preview" />
                                    <div id="previewPlaceholder" class="text-muted">
                                        <i class="bi bi-person-circle fs-1"></i>
                                        <p class="mt-2">Avatar preview will appear here</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="form-group col-12">
                                <div class="d-flex gap-2 justify-content-end">
                                    <a href="/admin/user" class="btn btn-secondary">
                                        <i class="bi bi-x-circle me-2"></i>Cancel
                                    </a>
                                    <button type="submit" class="btn btn-submit">
                                        <i class="bi bi-check-circle me-2"></i>Create User
                                    </button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
</body>

</html>
