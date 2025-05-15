<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- Set the active page for navbar highlighting --%>
<c:set var="activePage" value="dashboard" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Dashboard</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	font-size: 0.9rem;
}

.card-header h4 {
	font-size: 1.1rem;
}

h1, h3 {
	font-size: 1.3rem;
}

.form-control, textarea {
	font-size: 0.85rem;
	padding: 0.3rem 0.5rem;
}

.btn {
	font-size: 0.85rem;
	padding: 0.4rem 0.75rem;
}

label {
	margin-bottom: 0.2rem;
	font-weight: 500;
}

.profile-img {
	max-width: 300px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}
</style>
</head>
<body>

	<%-- Include header navigation --%>
	<jsp:include page="/pages/Header.jsp" />

	<div class="container mt-5">
		<div class="text-center mb-4">
			<h1>
				Welcome,
				<c:out value="${sessionScope.userWithSession.name}" />
				!
			</h1>
			<p class="text-muted mb-1">We are glad to have you here.</p>
			<p class="text-muted">
				Your Role: <strong><c:out
						value="${sessionScope.userWithSession.role}" /></strong>
			</p>
		</div>

		<div class="row justify-content-center">
			<div class="col-md-6">
				<div class="card shadow-sm">
					<div class="card-header text-center bg-light">
						<h5 class="mb-0">Upload Your Photo</h5>
					</div>
					<div class="card-body">
						<form
							action="${pageContext.request.contextPath}/UploadPhotoServlet"
							method="post" enctype="multipart/form-data">
							<div class="form-group">
								<input type="file" name="image" class="form-control-file"
									accept="image/*" required />
							</div>
							<button type="submit" class="btn btn-primary mt-2 w-100">Upload
								Photo</button>
						</form>
						<c:if test="${not empty path}">
							<div class="text-center mt-4">
								<img src="${path}" alt="Uploaded Image"
									class="img-fluid profile-img" />
							</div>
						</c:if>
						<c:if test="${empty path}">
							<p class="text-center text-muted mt-3">No photo uploaded yet.</p>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%-- Include footer --%>
	<jsp:include page="/pages/Footer.jsp" />
</body>
</html>
