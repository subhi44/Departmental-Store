<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
.navbar-custom {
	background: linear-gradient(to right, #28a745, #007bff);
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

.navbar-custom .navbar-brand {
	color: #ffffff;
	font-weight: bold;
	font-size: 1.2rem;
}

.navbar-custom .navbar-nav .nav-link {
	color: #ffffff;
	transition: color 0.3s, background 0.3s;
	margin-left: 10px;
	border-radius: 5px;
	padding: 0.4rem 0.8rem;
}

.navbar-custom .navbar-nav .nav-link.active,
.navbar-custom .navbar-nav .nav-link:hover {
	background-color: rgba(255, 255, 255, 0.2);
	color: #ffffff;
}

.navbar-toggler {
	border-color: rgba(255, 255, 255, 0.7);
}

.navbar-toggler-icon {
	background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba%28255, 255, 255, 0.7%29' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
}
</style>

<nav class="navbar navbar-expand-lg navbar-custom">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/pages/Dashboard.jsp">
			🛍️ Departmental Store
		</a>

		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
			aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item">
					<a class="nav-link ${activePage == 'dashboard' ? 'active' : ''}"
					   href="${pageContext.request.contextPath}/pages/Dashboard.jsp">Dashboard</a>
				</li>
				<li class="nav-item">
					<a class="nav-link ${activePage == 'categories' ? 'active' : ''}"
					   href="${pageContext.request.contextPath}/ViewCategories.jsp">Categories</a>
				</li>
				<li class="nav-item">
					<a class="nav-link ${activePage == 'products' ? 'active' : ''}"
					   href="${pageContext.request.contextPath}/pages/Product.jsp">Products</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/LogOutController">Logout</a>
				</li>
			</ul>
		</div>
	</div>
</nav>

<!-- Bootstrap JS & dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script><!-- ends here -->
