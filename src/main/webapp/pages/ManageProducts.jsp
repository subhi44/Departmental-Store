<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
// Set active page attribute for sidebar highlighting
request.setAttribute("activePage", "products");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin - Product Management</title>
<jsp:include page="AdminHeader.jsp" />

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Bootstrap Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet" />

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
}

.top-navbar {
	background-color: #3e5c3c;
	padding: 15px 30px;
	color: white;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.top-navbar h4 {
	margin: 0;
	font-size: 20px;
}

.top-navbar .features {
	display: flex;
	gap: 15px;
}

.top-navbar .features i {
	font-size: 18px;
	cursor: pointer;
}

.sidebar {
	position: fixed;
	top: 60px;
	left: 0;
	height: 100vh;
	width: 180px;
	background-color: #2f4f4f;
	color: white;
	padding-top: 20px;
	display: flex;
	flex-direction: column;
}

.sidebar a {
	padding: 15px 20px;
	color: #ddd;
	text-decoration: none;
	display: flex;
	align-items: center;
	transition: all 0.3s ease;
	font-size: 16px;
}

.sidebar a i {
	margin-right: 10px;
	font-size: 18px;
}

.sidebar a:hover {
	background-color: #556B2F;
	color: white;
}

.sidebar a.active {
	background-color: #6B8E23;
	color: white;
	font-weight: bold;
	border-left: 4px solid white;
}

header {
	margin-left: 210px;
	margin-top: 20px;
	text-align: center;
}

header h1 {
	font-size: 2rem;
	color: #333;
}

header p {
	color: #666;
}

main {
	margin-left: 210px;
	padding: 30px;
}

h3 {
	margin-bottom: 20px;
	font-size: 1.5rem;
}

table {
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

th, td {
	text-align: center;
	vertical-align: middle !important;
}

.product-img {
	width: 100px;
	height: auto;
	border-radius: 8px;
}

td:nth-child(5) {
	max-width: 200px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.btn-edit {
	background-color: #556B2F;
	color: white;
}

.btn-edit:hover {
	background-color: #3e5c3c;
	color: white;
}

.btn-delete {
	background-color: #dc3545;
	color: white;
}

.btn-delete:hover {
	background-color: #a71d2a;
	color: white;
}

.alert-success {
	margin-bottom: 20px;
}
</style>

</head>
<body>

	<header>
		<h1>Manage Products</h1>
		<p>View, add, edit, or delete products in your store</p>
	</header>

	<main class="container-fluid">

		<!-- Display Success Messages -->
		<c:if test="${param.success == 'true'}">
			<div class="alert alert-success text-center" role="alert">✅ Product added successfully!</div>
		</c:if>
		<c:if test="${param.successEdit == 'true'}">
			<div class="alert alert-success text-center" role="alert">✅ Product edited successfully!</div>
		</c:if>
		<c:if test="${param.successDelete == 'true'}">
			<div class="alert alert-success text-center" role="alert">✅ Product deleted successfully!</div>
		</c:if>

		<!-- Add Product Button -->
		<a href="AddProduct.jsp" class="btn btn-success mb-3 float-right">
			<i class="bi bi-plus-circle"></i> Add Product
		</a>
		
		<!-- Product Table -->
		<div class="table-responsive">
			<table class="table table-bordered table-striped">
				<thead class="thead-dark">
					<tr>
						<th>ID</th>
						<th>Image</th>
						<th>Name</th>
						<th>Price (₹)</th>
						<th>Description</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					// Hardcoded sample data for now; replace with DB fetch as needed
					String[][] adminProducts = {
							{ "1", "coca cola.jpg", "Coca Cola 1L", "250", "Refreshing carbonated soft drink, perfect for any occasion." },
							{ "2", "rice.jpg", "Basmati Rice 5kg", "500", "Long-grain aromatic rice with a light nutty flavor." },
							{ "3", "Oreo.jpg", "Oreo Biscuits", "180", "Classic chocolate sandwich cookies with sweet cream filling." },
							{ "4", "orangejuice.jpg", "Orange Juice 500ml", "120",
							"Fresh and tangy juice rich in vitamin C and potassium." },
							{ "5", "dal.jpg", "Lentils 1kg", "350", "Nutritious and protein-rich pulses for daily cooking." },
							{ "6", "surf excel.jpg", "Surf Excel 1k", "250", "Powerful detergent for tough stain removal." },
							{ "7", "shampoo.jpg", "Shampoo", "1500", "Nourishing formula for clean, soft, and healthy hair." },
							{ "8", "dettol.jpg", "Dettol Soap 100g", "70", "Trusted antibacterial soap for daily hygiene." },
							{ "9", "mango juice.jpg", "Mango Juice", "380", "Sweet and refreshing drink made from ripe mangoes." },
							{ "10", "pressurecooker.jpg", "Pressure Cooker", "1500",
							"Durable cooker for safe, fast, and efficient meals." },
							{ "11", "slippers.jpg", "Slippers", "200", "Comfortable and soft footwear for indoor use." },
							{ "12", "headphones.jpg", "Wireless Headphones", "1500", "High-quality sound with wireless convenience." },
							{ "13", "LaptopBag.jpg", "Laptop Bag", "1000", "Stylish and sturdy bag for laptops and daily essentials." },
							{ "14", "MicrowaveOven.jpg", "Microwave Oven", "5000",
							"Compact and efficient microwave oven for quick meals." } };

					for (String[] product : adminProducts) {
					%>
					<tr>
						<td><%=product[0]%></td>
						<td><img
							src="${pageContext.request.contextPath}/images/<%= product[1] %>"
							alt="<%= product[2] %>" class="product-img" /></td>
						<td><%=product[2]%></td>
						<td><%=product[3]%></td>
						<td><%=product[4]%></td>
						<td>
							<!-- Edit button triggers edit modal -->
							<button type="button" class="btn btn-sm btn-edit" data-toggle="modal" data-target="#editModal<%=product[0]%>">Edit</button>
							
							<!-- Delete button triggers delete modal -->
							<button type="button" class="btn btn-sm btn-delete" data-toggle="modal" data-target="#deleteModal<%=product[0]%>">Delete</button>
						</td>
					</tr>

					<!-- Edit Modal -->
					<div class="modal fade" id="editModal<%=product[0]%>" tabindex="-1" role="dialog" aria-labelledby="editModalLabel<%=product[0]%>" aria-hidden="true">
					  <div class="modal-dialog" role="document">
						<div class="modal-content">
						  <form action="updateProduct" method="post">
							<div class="modal-header">
							  <h5 class="modal-title" id="editModalLabel<%=product[0]%>">Edit Product - <%=product[2]%></h5>
							  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							  </button>
							</div>
							<div class="modal-body">
							  <input type="hidden" name="productId" value="<%=product[0]%>" />
							  <div class="form-group">
								<label for="productName<%=product[0]%>">Name</label>
								<input type="text" class="form-control" id="productName<%=product[0]%>" name="name" value="<%=product[2]%>" required>
							  </div>
							  <div class="form-group">
								<label for="productPrice<%=product[0]%>">Price (₹)</label>
								<input type="number" class="form-control" id="productPrice<%=product[0]%>" name="price" value="<%=product[3]%>" min="0" required>
							  </div>
							  <div class="form-group">
								<label for="productDesc<%=product[0]%>">Description</label>
								<textarea class="form-control" id="productDesc<%=product[0]%>" name="description" rows="3" required><%=product[4]%></textarea>
							  </div>
							</div>
							<div class="modal-footer">
							  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							  <button type="submit" class="btn btn-primary">Save changes</button>
							</div>
						  </form>
						</div>
					  </div>
					</div>

					<!-- Delete Modal -->
					<div class="modal fade" id="deleteModal<%=product[0]%>" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel<%=product[0]%>" aria-hidden="true">
					  <div class="modal-dialog" role="document">
						<div class="modal-content">
						  <form action="deleteProduct" method="post">
							<div class="modal-header">
							  <h5 class="modal-title" id="deleteModalLabel<%=product[0]%>">Delete Product - <%=product[2]%></h5>
							  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							  </button>
							</div>
							<div class="modal-body">
							  Are you sure you want to delete <strong><%=product[2]%></strong>?
							  <input type="hidden" name="productId" value="<%=product[0]%>" />
							</div>
							<div class="modal-footer">
							  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							  <button type="submit" class="btn btn-danger">Delete</button>
							</div>
						  </form>
						</div>
					  </div>
					</div>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</main>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>

</body>
</html> <!-- ends here -->
