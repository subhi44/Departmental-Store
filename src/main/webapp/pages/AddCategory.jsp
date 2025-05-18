<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="AdminHeader.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body style="background-color:#f8f9fa;">

    <div class="container mt-5">

        <!-- Add New Category Section -->
        <div class="card mb-4 shadow">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Add New Category</h4>
            </div>
            <div class="card-body">

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success py-1">
                        <c:out value="${successMessage}" />
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger py-1">
                        <c:out value="${errorMessage}" />
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/AddCategoryServlet" method="post">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="categoryName">Category Name</label>
                            <input type="text" class="form-control" id="categoryName" name="categoryName" placeholder="e.g. Snacks" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="categoryDescription">Description</label>
                            <textarea class="form-control" id="categoryDescription" name="categoryDescription" rows="1" placeholder="e.g. Chips, cookies, chocolates"></textarea>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success">Add Category</button>
                </form>
            </div>
        </div>

        <!-- Existing Categories Table --> 
        <div class="card shadow">
            <div class="card-header bg-dark text-white">
                <h4 class="mb-0">Existing Categories</h4>
            </div>
            <div class="card-body">
                <c:if test="${empty categories}">
                    <p class="text-muted">No categories found.</p>
                </c:if>
                <c:if test="${not empty categories}">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped table-hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Category ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Created At</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cat" items="${categories}">
                                    <tr>
                                        <td>${cat.categoryId}</td>
                                        <td>${cat.name}</td>
                                        <td>${cat.description}</td>
                                        <td>${cat.createdAt}</td>
                                        <td>
                                            <a href="EditCategoryServlet?id=${cat.categoryId}" class="btn btn-sm btn-warning">Edit</a>
                                            <a href="DeleteCategoryServlet?id=${cat.categoryId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this category?');">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>

    </div>

</body>
</html> <!-- ends here -->
