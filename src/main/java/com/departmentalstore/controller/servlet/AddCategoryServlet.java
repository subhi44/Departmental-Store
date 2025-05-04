package com.departmentalstore.controller.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.departmentalstore.controller.dao.CategoryDAO;
import com.departmentalstore.model.Category;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddCategoryServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Get values from form
        String name = request.getParameter("categoryName");
        String description = request.getParameter("categoryDescription");

        // Create Category object and set values
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);

        try {
            CategoryDAO categoryDAO = new CategoryDAO();
            boolean isCategoryAdded = categoryDAO.addCategory(category);

            if (isCategoryAdded) {
                request.setAttribute("successMessage", "Category added successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to add category.");
            }

            request.getRequestDispatcher("/pages/Dashboard.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/pages/Dashboard.jsp").forward(request, response);
        }
    }
}