<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
/* 
  Get all cookies sent by the browser
  We look for a cookie named "userEmail" to pre-fill the email input if user chose "Remember Me"
*/
javax.servlet.http.Cookie[] cookies = request.getCookies();
String savedEmail = "";
if (cookies != null) {
	for (javax.servlet.http.Cookie cookie : cookies) {
		if ("userEmail".equals(cookie.getName())) {
	savedEmail = cookie.getValue(); // Save the email from the cookie
		}
	}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login | Departmental System</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Link to favicon file to show logo in browser tab -->
<link rel="icon" href="${pageContext.request.contextPath}/favicon.ico"
	type="image/x-icon" />

<style>
/* Basic styling for body */
body {
	font-family: 'Segoe UI', sans-serif;
	background: linear-gradient(135deg, #f0f7fb, #f9fafb);
	/* Light blue gradient background */
	margin: 0;
	padding: 0;
}

/* Container box for login form */
.login-container {
	max-width: 400px; /* fixed width */
	margin: 7% auto; /* center horizontally and add top margin */
	background: #ffffff;
	border-radius: 16px;
	padding: 30px;
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1); /* subtle shadow */
	transition: transform 0.3s ease; /* smooth animation */
}

/* Slightly lift container on hover */
.login-container:hover {
	transform: translateY(-5px);
}

/* Heading style */
.login-container h2 {
	text-align: center;
	margin-bottom: 25px;
	color: #2c7a7b; /* teal-ish blue color */
}

/* Space between form groups */
.form-group {
	margin-bottom: 18px;
}

/* Labels style */
.form-group label {
	font-weight: 600;
	display: block;
	margin-bottom: 5px;
	color: #2f855a; /* green color */
}

/* Input field styles */
.form-group input {
	width: 100%;
	padding: 10px;
	border: 2px solid #cbd5e0;
	border-radius: 10px;
	transition: 0.3s ease;
}

/* Input focus state */
.form-group input:focus {
	border-color: #2f855a;
	outline: none;
}

/* Checkbox container styling */
.form-check {
	margin-bottom: 15px;
	color: #2f855a;
}

/* Checkbox input margin */
.form-check input {
	margin-right: 8px;
}

/* Login button styles */
.btn-login {
	background-color: #2f855a;
	color: #fff;
	padding: 12px;
	border: none;
	width: 100%;
	border-radius: 12px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

/* Button hover color */
.btn-login:hover {
	background-color: #276749;
}

/* Alert message box */
.alert {
	padding: 10px;
	margin-bottom: 15px;
	border-radius: 8px;
	font-size: 14px;
}

/* Success message style */
.alert-success {
	background-color: #d4edda;
	color: #155724;
}

/* Error message style */
.alert-danger {
	background-color: #f8d7da;
	color: #721c24;
}

/* Close button style for alert messages */
.close-btn {
	float: right;
	cursor: pointer;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="login-container">
		<h2>Login</h2>

		<!-- Show message if user logged out successfully -->
		<c:if test="${param.logout eq 'success'}">
			<div class="alert alert-success">
				You have successfully logged out. <span class="close-btn"
					onclick="this.parentElement.style.display='none'">×</span>
			</div>
		</c:if>

		<!-- Show error message if login failed -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger">
				${errorMessage} <span class="close-btn"
					onclick="this.parentElement.style.display='none'">×</span>
			</div>
		</c:if>

		<!-- Login form -->
		<form action="${pageContext.request.contextPath}/LogInController"
			method="post">
			<!-- Email input field -->
			<div class="form-group">
				<label for="email">Email</label> <input type="email" id="email"
					name="login_garda_deko_email" placeholder="user@example.com"
					value="<%=savedEmail%>" required>
			</div>

			<!-- Password input field -->
			<div class="form-group">
				<label for="password">Password</label> <input type="password"
					id="password" name="login_garda_deko_password" required>
			</div>

			<!-- Remember Me checkbox -->
			<div class="form-check">
				<input type="checkbox" id="rememberMe" name="rememberMe"> <label
					for="rememberMe">Remember Me</label>
			</div>

			<!-- Submit button -->
			<button type="submit" class="btn-login">Log In</button>
		</form>
	</div>

	<!-- JavaScript to auto-check "Remember Me" if cookie saved an email -->
	<script>
        window.addEventListener("DOMContentLoaded", function() {
            const savedEmail = "<%=savedEmail%>
		";
			if (savedEmail !== "") {
				document.getElementById("rememberMe").checked = true;
			}
		});
	</script>
</body>
</html>
