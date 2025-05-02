<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Upload your picture</h1>
	<form action="${pageContext.request.contextPath}/UploadPhotoServlet"
		method="post" enctype="multipart/form-data">
		<input type="file" name="image" accept="image/*" required />
	  </br>
		<input type="submit" value="Upload Photo" />
	</form>
	<h2>Upload Photo:</h2>
	<img src="${path}" alt="Uploaded Image" style="max-width: 500px;" />
</body>
</html>