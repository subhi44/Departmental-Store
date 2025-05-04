package com.departmentalstore.controller.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.departmentalstore.controller.dao.ProductDAO;
import com.departmentalstore.model.Products;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve form data from the request
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int productId = Integer.parseInt(request.getParameter("ProductId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));

            // Add current timestamp
            Timestamp createdAt = new Timestamp(System.currentTimeMillis());

            // Create product model object with 7 parameters (including createdAt)
            Products product = new Products(productId, name, price, quantity, categoryId, supplierId, createdAt);

            // Create ProductDAO instance to interact with the database
            ProductDAO productDAO = new ProductDAO();

            // Call DAO to add product to the database
            boolean isProductAdded = productDAO.addProduct(product);

            // Handle the response based on whether the product was added successfully
            if (isProductAdded) {
                request.setAttribute("successMessage", "Product added successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to add product.");
            }
        } catch (NumberFormatException e) {
            // Handle invalid number format input
            request.setAttribute("errorMessage", "Invalid input. Please enter correct numeric values.");
        } catch (ClassNotFoundException | SQLException e) {
            // Handle database errors
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error occurred while adding product.");
        }

        // Forward the request to the AddProduct.jsp page with success/error message
        request.getRequestDispatcher("/pages/AddProduct.jsp").forward(request, response);
    }
}