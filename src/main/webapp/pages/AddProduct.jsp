<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Product | Departmental System</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Favicon shown on browser tab -->
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/images/favicon2.png">

<!-- Bootstrap CSS for styling -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- Custom CSS -->
<style>
body {
	background: linear-gradient(to right, #e3fdf5, #fdfcfc);
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.container {
	max-width: 720px;
	margin-top: 60px;
}

.card {
	border: none;
	border-radius: 20px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
	background: white;
}

.card-header {
	background: linear-gradient(135deg, #6DBE45, #3498db);
	color: white;
	border-top-left-radius: 20px;
	border-top-right-radius: 20px;
	padding: 25px 20px;
	text-align: center;
}

.card-header h4 {
	margin: 0;
	font-weight: bold;
	font-size: 1.6rem;
}

.form-label {
	font-weight: 600;
	color: #444;
}

.form-control {
	border-radius: 12px;
	border: 1px solid #ced4da;
	padding: 10px 15px;
	transition: border-color 0.3s ease;
}

.form-control:focus {
	border-color: #3498db;
	box-shadow: 0 0 5px rgba(52, 152, 219, 0.4);
}

.btn-primary {
	background-color: #3498db;
	border: none;
	border-radius: 12px;
	padding: 10px 20px;
	font-weight: 600;
}

.btn-primary:hover {
	background-color: #2d89cf;
}

.alert {
	border-radius: 10px;
	font-weight: 500;
}

select.form-control {
	appearance: none;
	background-image:
		url("data:image/svg+xml,%3Csvg viewBox='0 0 140 140' width='14' height='14' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M 70 100 L 30 60 L 110 60 Z' fill='%23333'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 1rem center;
	background-size: 1rem;
	padding-right: 2.5rem;
}
</style>
</head>
<body>

	<!-- Include navigation and logo (Header.jsp) -->
	<jsp:include page="/pages/Header.jsp" />

	<!-- Main Add Product Form -->
	<div class="container">

		<!-- Show success message -->
		<c:if test="${not empty successMessage}">
			<div class="alert alert-success">${successMessage}</div>
		</c:if>

		<!-- Show error message -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger">${errorMessage}</div>
		</c:if>

		<!-- Product Form Card -->
		<div class="card">
			<div class="card-header">
				<h4>Add New Product</h4>
			</div>
			<div class="card-body">
				<form action="${pageContext.request.contextPath}/AddProductServlet"
					method="post">

					<!-- Product Name -->
					<div class="form-group">
						<label for="name" class="form-label">Product Name</label> <input
							type="text" class="form-control" id="name" name="name" required
							placeholder="e.g., Organic Honey">
					</div>

					<!-- Product Description -->
					<div class="form-group">
						<label for="description" class="form-label">Description</label>
						<textarea class="form-control" id="description" name="description"
							rows="2" required placeholder="Short product description"></textarea>
					</div>

					<!-- Product Price -->
					<div class="form-group">
						<label for="price" class="form-label">Price (NPR)</label> <input
							type="number" step="1" class="form-control" id="price"
							name="price" required placeholder="e.g., 1500">
					</div>

					<!-- Product Stock -->
					<div class="form-group">
						<label for="stock" class="form-label">Stock Quantity</label> <input
							type="number" class="form-control" id="stock" name="stock"
							required placeholder="e.g., 20">
					</div>

					<!-- Product Category -->
					<div class="form-group">
						<label for="categoryId" class="form-label">Category</label> <select
							class="form-control" id="categoryId" name="categoryId" required>
							<option value="">-- Select Category --</option>
							<option value="1">Grocery</option>
							<option value="2">Fashion</option>
							<option value="3">Electronics</option>
							<option value="4">Beauty & Personal Care</option>
							<option value="5">Home Appliances</option>
							<option value="6">Sports</option>
							<option value="7">Toys</option>
							<option value="8">Other</option>
						</select>
					</div>

					<!-- Submit Button -->
					<button type="submit" class="btn btn-primary btn-block mt-3">Add
						Product</button>
				</form>
			</div>
		</div>
	</div>

	<!-- Include footer (Footer.jsp) -->
	<jsp:include page="/pages/Footer.jsp" />

	<!-- Bootstrap JS for functionality -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
