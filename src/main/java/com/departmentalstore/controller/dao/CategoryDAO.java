package com.departmentalstore.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.departmentalstore.controller.database.DatabaseConnection;
import com.departmentalstore.model.Category;

public class CategoryDAO {
    private Connection conn;

    public CategoryDAO() throws ClassNotFoundException, SQLException {
        conn = DatabaseConnection.getConnection(); // Establish a database connection
    }

    // Add a new category to the database
    public boolean addCategory(Category category) {
        boolean isRowInserted = false;
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            int rows = ps.executeUpdate();
            isRowInserted = rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isRowInserted;
    }

    // Get all categories from the database
    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> categories = new ArrayList<>();
        String sql = "SELECT category_id, name, description, created_at FROM categories";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category(
                    rs.getInt("category_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getTimestamp("created_at")
                );
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    // Optional: Get category by ID
    public Category getCategoryById(int id) {
        Category category = null;
        String sql = "SELECT * FROM categories WHERE category_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                category = new Category(
                    rs.getInt("category_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getTimestamp("created_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return category;
    }

    // Optional: Delete category by ID
    public boolean deleteCategory(int id) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        boolean isDeleted = false;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            isDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDeleted;
    }

    // Optional: Update category by ID
    public boolean updateCategory(Category category) {
        String sql = "UPDATE categories SET name = ?, description = ? WHERE category_id = ?";
        boolean isUpdated = false;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getCategoryId());
            isUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isUpdated;
    }
}