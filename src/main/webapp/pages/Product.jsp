<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Products</title>
<jsp:include page="Header.jsp" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<!-- FontAwesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
.product {
	background-color: white;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	transition: transform 0.3s, box-shadow 0.3s;
	position: relative;
}
.product:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}
.product img {
	max-width: 100%;
	height: 200px;
	object-fit: cover;
	border-radius: 8px;
	margin-bottom: 10px;
	transition: transform 0.3s ease-in-out;
}
.product img:hover {
	transform: scale(1.05);
}
.badge-custom {
	position: absolute;
	top: 10px;
	left: 10px;
	background-color: #e74c3c;
	color: white;
	padding: 5px 10px;
	border-radius: 5px;
	font-size: 0.75rem;
}
</style>
</head>
<body>
<main class="container mt-4">
	<!-- Featured Products -->
	<section class="featured-products">
		<h3 class="mb-4">Featured Products</h3>
		<div class="row">
			<%
			String[][] featuredProducts = {
				{"1", "coca cola.jpg", "Coca Cola 1L", "250", "Refreshing soft drink"},
				{"2", "rice.jpg", "Basmati Rice 5kg", "500", "Premium long grain rice"},
				{"3", "Oreo.jpg", "Oreo Biscuits", "180", "Chocolate sandwich cookies"},
				{"4", "orangejuice.jpg", "Orange Juice 500ml", "120", "Freshly squeezed orange juice"},
				{"5", "dal.jpg", "Lentils 1kg", "350", "Nutritious and protein-rich pulses for daily cooking."},
				{"6", "surf excel.jpg", "Surf Excel 1k", "250", "Powerful detergent for tough stain removal."},
				{"7", "shampoo.jpg", "Shampoo", "1500", "Nourishing formula for clean, soft, and healthy hair."},
				{"8", "dettol.jpg", "Dettol Soap 100g", "70", "Trusted antibacterial soap for daily hygiene."},
				{"9", "mango juice.jpg", "Mango Juice", "380", "Sweet and refreshing drink made from ripe mangoes."}
			};

			for (String[] product : featuredProducts) {
			%>
			<div class="col-md-4 mb-4 product text-center">
				<span class="badge-custom">Best Seller</span>
				<img src="${pageContext.request.contextPath}/images/<%=product[1]%>" alt="<%=product[2]%>" class="img-fluid">
				<p><%=product[2]%></p>
				<p><strong>Price: ₹<%=product[3]%></strong></p>
				<p><span style="color: gold;">★ ★ ★ ★ ☆</span> <small>(23 reviews)</small></p>
				<button class="btn btn-primary" onclick="showProductDetails('<%=product[0]%>', '<%=product[2]%>', '<%=product[3]%>', '<%=product[4]%>', '<%=product[1]%>')">View Details</button>
				<br>
				<button class="btn btn-success mt-2 add-to-cart-btn" data-productid="<%=product[0]%>">Add to Cart</button>
			</div>
			<% } %>
		</div>
	</section>

	<!-- Discounted Products -->
	<section class="discounted-products mt-5">
		<h3 class="text-center mb-4">Hot Discounts</h3>
		<div class="row">
			<%
			String[][] discountedProducts = {
				{"10", "dumbbell.jpg", "Discounted Dumbbell", "1999", "Heavy-duty dumbbells for home workouts"},
				{"11", "headphones.jpg", "Discounted Headphones", "4200", "Noise cancelling wireless headphones"},
				{"12", "pan.jpg", "Discounted Cooking Pan", "2800", "Non-stick frying pan for everyday cooking"}
			};

			for (String[] product : discountedProducts) {
			%>
			<div class="col-md-4 mb-4 product text-center">
				<span class="badge-custom bg-warning">Hot Deal</span>
				<img src="${pageContext.request.contextPath}/images/<%=product[1]%>" alt="<%=product[2]%>" class="img-fluid">
				<p><%=product[2]%></p>
				<p><strong>Price: ₹<%=product[3]%></strong></p>
				<p><span style="color: gold;">★ ★ ★ ★ ☆</span> <small>(15 reviews)</small></p>
				<button class="btn btn-danger" onclick="showProductDetails('<%=product[0]%>', '<%=product[2]%>', '<%=product[3]%>', '<%=product[4]%>', '<%=product[1]%>')">View Details</button>
				<br>
				<button class="btn btn-dark mt-2 add-to-cart-btn" data-productid="<%=product[0]%>">Add to Cart</button>
			</div>
			<% } %>
		</div>
	</section>
</main>

<!-- Product Modal -->
<div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<h5 class="modal-title" id="productModalLabel">Product Details</h5>
				<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body row">
				<div class="col-md-6">
					<img id="modalImage" src="" class="img-fluid rounded">
				</div>
				<div class="col-md-6">
					<h4 id="modalName"></h4>
					<p><strong>Price:</strong> ₹<span id="modalPrice"></span></p>
					<p>
						<span style="color: gold;">★ ★ ★ ★ ☆</span>
						<small>(23 reviews)</small>
					</p>
					<p><i class="fas fa-shipping-fast"></i> Delivery by <strong><%= LocalDate.now().plusDays(3) %></strong></p>
					<p id="modalDescription"></p>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Toast container for messages -->
<!-- Toast container for messages - centered -->
<div aria-live="polite" aria-atomic="true" 
     style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
            min-width: 250px; z-index: 1051;">
  <div id="toast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" 
       data-delay="2000" style="min-width: 250px;">
    <div class="toast-header bg-success text-white">
      <strong class="mr-auto">Success</strong>
      <small>Just now</small>
      <button type="button" class="ml-2 mb-1 close text-white" data-dismiss="toast" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <div class="toast-body">
      Product added to cart successfully!
    </div>
  </div>
</div>


<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function showProductDetails(id, name, price, description, image) {
	document.getElementById("modalName").innerText = name;
	document.getElementById("modalPrice").innerText = price;
	document.getElementById("modalDescription").innerText = description;
	document.getElementById("modalImage").src = '<%=request.getContextPath()%>/images/' + image;
	$('#productModal').modal('show');
}

$(document).ready(function() {
  $('.add-to-cart-btn').on('click', function() {
    // Here you can add AJAX call to backend to actually add product to cart if you want
    
    // Show toast message
    $('#toast').toast('show');
  });
});
</script>

</body>
</html><!-- ends here -->
