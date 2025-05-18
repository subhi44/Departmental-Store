<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Categories Dashboard</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Bootstrap 4 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	<style>
		body {
			font-size: 0.95rem;
			background-color: #f8f9fa;
		}
		.nav-tabs .nav-link.active {
			background-color: #343a40;
			color: #fff;
		}
		.category-badge {
			font-size: 0.85rem;
			margin: 0.25rem;
			padding: 0.5em 0.75em;
			background: linear-gradient(135deg, #6f42c1, #6610f2);
			color: #fff;
			border-radius: 20px;
			box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}
		.toast-container {
			position: fixed;
			top: 20px;
			right: 20px;
			z-index: 2000;
		}
	</style>
</head>
<body>

	<!-- Set active page for navbar -->
	<c:set var="activePage" value="categories" scope="request" />
	<jsp:include page="/pages/Header.jsp" />

	<div class="container mt-4 mb-5">
		<jsp:include page="/pages/AddCategory.jsp" />

		<!-- Toasts -->
		<c:if test="${not empty errorMessage}">
			<div class="toast-container">
				<div class="toast show bg-danger text-white" role="alert">
					<div class="toast-body">
						<i class="fas fa-exclamation-circle mr-2"></i> ${errorMessage}
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty successMessage}">
			<div class="toast-container">
				<div class="toast show bg-success text-white" role="alert">
					<div class="toast-body">
						<i class="fas fa-check-circle mr-2"></i> ${successMessage}
					</div>
				</div>
			</div>
		</c:if>

		<!-- Search Bar -->
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="categorySearch" placeholder="Search categories...">
			<div class="input-group-append">
				<span class="input-group-text"><i class="fas fa-search"></i></span>
			</div>
		</div>

		<!-- Tabs -->
		<ul class="nav nav-tabs mb-3" id="categoryTab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="list-tab" data-toggle="tab" href="#listView" role="tab">
					<i class="fas fa-list mr-1"></i> Category List
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="manage-tab" data-toggle="tab" href="#tableView" role="tab">
					<i class="fas fa-table mr-1"></i> Manage Categories
				</a>
			</li>
		</ul>

		<div class="tab-content" id="categoryTabContent">

			<!-- Badge View -->
			<div class="tab-pane fade show active" id="listView" role="tabpanel">
				<h5 class="mb-3">Available Categories</h5>
				<div id="badgeContainer">
					<c:forEach var="category" items="${categories}">
						<span class="badge category-badge">
							<i class="fas fa-tag mr-1"></i> ${category.name}
						</span>
					</c:forEach>
				</div>
			</div>

			<!-- Table View -->
			<div class="tab-pane fade" id="tableView" role="tabpanel">
				<h5 class="mb-3">Manage Categories</h5>
				<div class="table-responsive">
					<table class="table table-bordered table-hover table-sm" id="categoryTable">
						<thead class="thead-dark">
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Description</th>
								<th style="width: 160px;">Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="category" items="${categories}">
								<tr>
									<td>${category.categoryId}</td>
									<td>${category.name}</td>
									<td>
										<c:choose>
											<c:when test="${not empty category.description}">
												${category.description}
											</c:when>
											<c:otherwise>
												<span class="text-muted">No description</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<!-- Edit Button -->
										<button class="btn btn-sm btn-warning mb-1" data-toggle="modal"
											data-target="#editModal${category.categoryId}">
											<i class="fas fa-edit"></i>
										</button>
										<!-- Delete Form -->
										<form action="${pageContext.request.contextPath}/DeleteCategoryServlet" method="post" style="display: inline;">
											<input type="hidden" name="action" value="delete">
											<input type="hidden" name="categoryId" value="${category.categoryId}">
											<button type="submit" class="btn btn-sm btn-danger"
												onclick="return confirm('Delete ${category.name}?')">
												<i class="fas fa-trash-alt"></i>
											</button>
										</form>
									</td>
								</tr>

								<!-- Edit Modal -->
								<div class="modal fade" id="editModal${category.categoryId}" tabindex="-1">
									<div class="modal-dialog modal-md">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title">Edit: ${category.name}</h5>
												<button type="button" class="close" data-dismiss="modal">
													<span>&times;</span>
												</button>
											</div>
											<form action="${pageContext.request.contextPath}/AddCategoryServlet" method="post">
												<div class="modal-body">
													<input type="hidden" name="action" value="update">
													<input type="hidden" name="categoryId" value="${category.categoryId}">
													<div class="form-group">
														<label>Name</label>
														<input type="text" class="form-control" name="categoryName"
															value="${category.name}" required>
													</div>
													<div class="form-group">
														<label>Description</label>
														<textarea class="form-control" name="categoryDescription" rows="2">${category.description}</textarea>
													</div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
													<button type="submit" class="btn btn-success">
														<i class="fas fa-save mr-1"></i> Save
													</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>

	<jsp:include page="/pages/Footer.jsp" />

	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html><!-- ends here -->
