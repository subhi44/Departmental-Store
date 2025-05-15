<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/images/favicon2.png">

<style>
body {
	background: linear-gradient(to right, #f0f4f7, #d9e2ec);
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: #333;
}

.container {
	max-width: 720px;
	margin-top: 60px;
}

.card {
	border: none;
	border-radius: 20px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
	background: white;
}

.card-header {
	background: linear-gradient(135deg, #6DBE45, #4CAF50);
	color: white;
	border-top-left-radius: 20px;
	border-top-right-radius: 20px;
	padding: 25px 20px;
	text-align: center;
}

.card-header h4 {
	margin: 0;
	font-weight: bold;
	font-size: 1.5rem;
}

.form-label {
	font-weight: 600;
	color: #444;
}

.form-control {
	border-radius: 12px;
	border: 1px solid #ced4da;
	padding: 10px 15px;
	box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
	transition: border-color 0.3s, box-shadow 0.3s;
}

.form-control:focus {
	border-color: #4CAF50;
	box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
}

.btn-primary {
	background-color: #4CAF50;
	border: none;
	border-radius: 12px;
	padding: 10px 20px;
	font-weight: 600;
	transition: background-color 0.3s ease;
}

.btn-primary:hover {
	background-color: #45a049;
}

.alert {
	border-radius: 10px;
	font-weight: 500;
}

select.form-control {
	appearance: none;
	background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 140 140' width='14' height='14' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M 70 100 L 30 60 L 110 60 Z' fill='%23333'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 1rem center;
	background-size: 1rem;
	padding-right: 2.5rem;
}
</style>
</head>
<body>

	<jsp:include page="/pages/Header.jsp" />

	<div class="container">

		<!-- Success Message -->
		<c:if test="${not empty successMessage}">
			<div class="alert alert-success">${successMessage}</div>
		</c:if>

		<!-- Error Message -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger">${errorMessage}</div>
		</c:if>

		<!-- Card: Add Product -->
		<div class="card">
			<div class="card-header">
				<h4>Add New Product</h4>
			</div>
			<div class="card-body">
				<form action="${pageContext.request.contextPath}/AddProductServlet" method="post">

					<div class="form-group">
						<label for="name" class="form-label">Product Name</label>
						<input type="text" class="form-control" id="name" name="name"
							required placeholder="e.g., Organic Honey">
					</div>

					<div class="form-group">
						<label for="description" class="form-label">Description</label>
						<textarea class="form-control" id="description" name="description"
							rows="2" required placeholder="Short description about the product"></textarea>
					</div>

					<div class="form-group">
						<label for="price" class="form-label">Price (NPR)</label>
						<input type="number" step="1" class="form-control" id="price"
							name="price" required placeholder="e.g., 1500">
					</div>

					<div class="form-group">
						<label for="stock" class="form-label">Stock Quantity</label>
						<input type="number" class="form-control" id="stock" name="stock"
							required placeholder="e.g., 20">
					</div>

					<div class="form-group">
						<label for="categoryId" class="form-label">Category</label>
						<select class="form-control" id="categoryId" name="categoryId" required>
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

					<button type="submit" class="btn btn-primary btn-block mt-3">Add Product</button>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="/pages/Footer.jsp" />

	<!-- Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
