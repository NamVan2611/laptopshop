<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
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
            --warning-color: #ffc107;
            --danger-color: #ff5722;
            --light-bg: #f8f9fc;
            --border-color: #e3e6f0;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Poppins', sans-serif;
        }

        .form-header {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e0a800 100%);
            color: #333;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
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

        .image-preview-container {
            text-align: center;
            padding: 1rem;
            background-color: #f8f9fc;
            border-radius: 8px;
            border: 2px dashed var(--border-color);
            min-height: 250px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .image-preview {
            max-width: 100%;
            max-height: 400px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e0a800 100%);
            border: none;
            color: #333;
            padding: 0.75rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 193, 7, 0.4);
            color: #333;
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
            const orgImage = "${newProduct.image}";
            if (orgImage) {
                const urlImage = "/images/product/" + orgImage;
                $("#avatarPreview").attr("src", urlImage);
                $("#avatarPreview").css({ "display": "block" });
                $(".image-preview-container").css("background-color", "#fff");
                $("#previewPlaceholder").hide();
            }
            avatarFile.change(function (e) {
                if (e.target.files && e.target.files[0]) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL);
                    $("#avatarPreview").css({ "display": "block" });
                    $(".image-preview-container").css("background-color", "#fff");
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
                        <h2 class="mb-1"><i class="bi bi-pencil-square me-2"></i>Update Product</h2>
                        <p class="mb-0 opacity-75">Edit product information - ID: #${newProduct.id}</p>
                    </div>
                    <a href="/admin/product" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>

            <!-- Form Card -->
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="form-card">
                        <form:form method="post" action="/admin/product/update" modelAttribute="newProduct"
                            class="row" enctype="multipart/form-data">
                            
                            <!-- Hidden ID -->
                            <div style="display: none;">
                                <form:input type="text" class="form-control" path="id" />
                            </div>

                            <!-- Name -->
                            <div class="form-group col-md-6">
                                <c:set var="errorName">
                                    <form:errors path="name" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label"><i class="bi bi-tag me-1"></i>Product Name *</label>
                                <form:input type="text"
                                    class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                    path="name" placeholder="Enter product name" />
                                ${errorName}
                            </div>

                            <!-- Price -->
                            <div class="form-group col-md-6">
                                <c:set var="errorPrice">
                                    <form:errors path="price" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label"><i class="bi bi-currency-dollar me-1"></i>Price *</label>
                                <form:input type="number" step="0.01"
                                    class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                    path="price" placeholder="Enter price" />
                                ${errorPrice}
                            </div>

                            <!-- Short Description -->
                            <div class="form-group col-md-6">
                                <c:set var="errorShortDesc">
                                    <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label"><i class="bi bi-text-paragraph me-1"></i>Short Description *</label>
                                <form:input type="text"
                                    class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}"
                                    path="shortDesc" placeholder="Brief product description" />
                                ${errorShortDesc}
                            </div>

                            <!-- Quantity -->
                            <div class="form-group col-md-6">
                                <c:set var="errorQuantity">
                                    <form:errors path="quantity" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label"><i class="bi bi-box me-1"></i>Quantity *</label>
                                <form:input type="number"
                                    class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                                    path="quantity" placeholder="Enter quantity" />
                                ${errorQuantity}
                            </div>

                            <!-- Factory -->
                            <div class="form-group col-md-6">
                                <label class="form-label"><i class="bi bi-building me-1"></i>Factory *</label>
                                <form:select class="form-select" path="factory">
                                    <option value="APPLE" ${newProduct.factory == 'APPLE' ? 'selected' : ''}>Apple</option>
                                    <option value="LENOVO" ${newProduct.factory == 'LENOVO' ? 'selected' : ''}>Lenovo</option>
                                    <option value="ACER" ${newProduct.factory == 'ACER' ? 'selected' : ''}>Acer</option>
                                    <option value="ASUS" ${newProduct.factory == 'ASUS' ? 'selected' : ''}>Asus</option>
                                    <option value="DELL" ${newProduct.factory == 'DELL' ? 'selected' : ''}>Dell</option>
                                    <option value="LG" ${newProduct.factory == 'LG' ? 'selected' : ''}>LG</option>
                                </form:select>
                            </div>

                            <!-- Target -->
                            <div class="form-group col-md-6">
                                <label class="form-label"><i class="bi bi-people me-1"></i>Target Category *</label>
                                <form:select class="form-select" path="target">
                                    <option value="GAMING" ${newProduct.target == 'GAMING' ? 'selected' : ''}>Gaming</option>
                                    <option value="OFFICE" ${newProduct.target == 'OFFICE' ? 'selected' : ''}>Office</option>
                                    <option value="DESIGN" ${newProduct.target == 'DESIGN' ? 'selected' : ''}>Design</option>
                                    <option value="CONVENIENT" ${newProduct.target == 'CONVENIENT' ? 'selected' : ''}>Convenient</option>
                                </form:select>
                            </div>

                            <!-- Detail Description -->
                            <div class="form-group col-12">
                                <c:set var="errorDetailDesc">
                                    <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label"><i class="bi bi-card-text me-1"></i>Detail Description *</label>
                                <form:textarea class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                    path="detailDesc" rows="4" placeholder="Detailed product description"></form:textarea>
                                ${errorDetailDesc}
                            </div>

                            <!-- Image Upload -->
                            <div class="form-group col-12">
                                <label for="avatarFile" class="form-label"><i class="bi bi-image me-1"></i>Product Image</label>
                                <input class="form-control" type="file" id="avatarFile"
                                    accept=".png, .jpg, .jpeg" name="file" />
                                <small class="form-text text-muted">Leave empty to keep current image. Accepted formats: PNG, JPG, JPEG</small>
                            </div>

                            <!-- Image Preview -->
                            <div class="form-group col-12">
                                <div class="image-preview-container">
                                    <img id="avatarPreview" class="image-preview" style="display: none;" alt="Image preview" />
                                    <div id="previewPlaceholder" class="text-muted">
                                        <i class="bi bi-image fs-1"></i>
                                        <p class="mt-2">Current image or new image preview will appear here</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="form-group col-12">
                                <div class="d-flex gap-2 justify-content-end">
                                    <a href="/admin/product/${newProduct.id}" class="btn btn-secondary">
                                        <i class="bi bi-x-circle me-2"></i>Cancel
                                    </a>
                                    <button type="submit" class="btn btn-submit">
                                        <i class="bi bi-check-circle me-2"></i>Update Product
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
