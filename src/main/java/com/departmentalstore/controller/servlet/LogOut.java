package com.departmentalstore.controller.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogOutController")
public class LogOut extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false); // Don't create if it doesn't exist
		if (session != null) {
			session.invalidate(); // Ends session
		}

		// Redirect to login page with logout message
		response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?logout=success");
	}
}