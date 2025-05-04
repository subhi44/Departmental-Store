package com.departmentalstore.controller.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.departmentalstore.controller.dao.UserDAO;
import com.departmentalstore.model.User;

/**
 * Servlet implementation class LogInController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/LogInController" })
public class LogInController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogInController() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Default GET method, just for testing purposes
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String emailToCheck = request.getParameter("login_garda_deko_email");
        String passwordToCheck = request.getParameter("login_garda_deko_password");
        String rememberMe = request.getParameter("rememberMe");

        try {
            UserDAO userdao = new UserDAO();
            User user = userdao.login(emailToCheck, passwordToCheck);

            if (user != null) {
                // Create a session for the logged-in user
                HttpSession session = request.getSession();
                session.setAttribute("userWithSession", user);
                session.setMaxInactiveInterval(60 * 60);  // 1 hour session

                // Handle the "Remember Me" functionality
                if ("on".equals(rememberMe)) {
                    // Create a cookie to remember the user's email for 30 days
                    Cookie emailCookie = new Cookie("userEmail", emailToCheck);
                    emailCookie.setMaxAge(30 * 24 * 60 * 60);  // 30 days
                    emailCookie.setPath("/");  // Set the path to the root to make the cookie available across the entire site
                    response.addCookie(emailCookie);
                } else {
                    // If "Remember Me" is not checked, delete the cookie if it exists
                    Cookie emailCookie = new Cookie("userEmail", "");
                    emailCookie.setMaxAge(0);  // Set to 0 to delete the cookie
                    emailCookie.setPath("/");  // Set the path to the root
                    response.addCookie(emailCookie);
                }

                // Redirect to the Dashboard or home page (could be a different page based on your setup)
                response.sendRedirect(request.getContextPath() + "/pages/Dashboard.jsp");
            } else {
                // If login fails, send an error message to the login page
                request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
                request.getRequestDispatcher("/pages/Login.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Log the error properly in production (use a logger)
            request.setAttribute("errorMessage", "A system error occurred. Please try again later.");
            request.getRequestDispatcher("/pages/Login.jsp").forward(request, response);
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
}