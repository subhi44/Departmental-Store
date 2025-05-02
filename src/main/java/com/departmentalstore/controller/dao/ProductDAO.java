package com.departmentalstore.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.departmentalstore.controller.database.DatabaseConnection;
import com.departmentalstore.model.Products;

public class ProductDAO {
    private Connection conn;
    private PreparedStatement ps;

    // Constructor: Establishes database connection when ProductDAO is created
    public ProductDAO() throws SQLException, ClassNotFoundException {
        this.conn = DatabaseConnection.getConnection();
    }

    // Add a new product to the database
    public boolean addProduct(Products product) {
        boolean isRowInserted = false;
        
        // SQL query to insert product data into the products table
        String query = "INSERT INTO products (name, description, price, quantity, category_id, supplier_id, created_at) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        if (conn != null) {
            try {
                ps = conn.prepareStatement(query);
                // Setting values from the product object into the SQL query
                ps.setString(1, product.getName());
                ps.setDouble(3, product.getPrice());
                ps.setInt(4, product.getQuantity()); // Using quantity field
                ps.setInt(5, product.getCategoryId());
                ps.setInt(6, product.getSupplierId()); // Added supplier_id
                ps.setTimestamp(7, product.getCreatedAt()); // Set createdAt timestamp

                int affectedRows = ps.executeUpdate(); // Execute the query and check if a row was inserted

                if (affectedRows > 0) {
                    isRowInserted = true; // Product added successfully
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Log error details if any
            }
        }
        return isRowInserted;
    }

    // Update product details in the database
    public boolean updateProductDetail(Products product) {
        boolean isUpdated = false;
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, quantity = ?, category_id = ? WHERE product_id = ?";

        if (conn != null) {
            try {
                ps = conn.prepareStatement(sql);
                ps.setString(1, product.getName());
                ps.setDouble(3, product.getPrice());
                ps.setInt(4, product.getQuantity()); // Using quantity field
                ps.setInt(5, product.getCategoryId());
                ps.setInt(6, product.getProductId());

                int affectedRows = ps.executeUpdate();
                if (affectedRows > 0) {
                    isUpdated = true; // Update successful
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Log error for debugging
            }
        }

        return isUpdated;
    }
}