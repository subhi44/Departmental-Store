package com.departmentalstore.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.departmentalstore.controller.database.DatabaseConnection;
import com.departmentalstore.model.User;

public class UserDAO {
    private Connection conn;
    private PreparedStatement ps;

    // Constructor: Initializes the database connection when an object is created
    public UserDAO() throws ClassNotFoundException, SQLException {
        this.conn = DatabaseConnection.getConnection();
    }

    // Registers a new user in the database
    public boolean register(User user) {
        boolean isUserRegistered = false;
        // SQL statement to insert user details (without password hashing)
        String query = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
        if (conn != null) {
            try {
                ps = conn.prepareStatement(query);
                ps.setString(1, user.getName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPassword()); // Store the password as is (plain text)
                ps.setString(4, user.getRole());

                // Execute the insert query
                if (ps.executeUpdate() > 0) {
                    isUserRegistered = true;
                }
            } catch (SQLException e) {
                // Log the exception (replace with a proper logger in production)
                e.printStackTrace();
            }
        }
        return isUserRegistered;
    }

    // Get all the users from the database
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";
        if (conn != null) {
            try {
                ps = conn.prepareStatement(query);
                ResultSet userSet = ps.executeQuery(); // Stores all the user information retrieved by running query in the database

                // Iterate over the result set and populate User objects
                while (userSet.next()) {
                    User user = new User();
                    user.setUserId(userSet.getInt("user_id"));
                    user.setName(userSet.getString("name"));
                    user.setEmail(userSet.getString("email"));
                    user.setPassword(userSet.getString("password")); // Store password in plain text
                    user.setRole(userSet.getString("role"));
                    users.add(user);
                }
            } catch (SQLException e) {
                // Log the exception (replace with a proper logger in production)
                e.printStackTrace();
            }
        }
        return users;
    }

    // Authenticates the user by checking email and password
    public User login(String emailToCheck, String passwordToCheck) {
        User user = null;
        String query = "SELECT * FROM users WHERE email = ?";
        if (conn != null) {
            try {
                ps = conn.prepareStatement(query);
                ps.setString(1, emailToCheck);
                ResultSet userSet = ps.executeQuery();

                // If user is found, compare password (no hashing)
                if (userSet.next()) {
                    String storedPassword = userSet.getString("password");

                    // Check if the entered password matches the stored password (plain text)
                    if (storedPassword.equals(passwordToCheck)) {
                        user = new User(
                                userSet.getInt("user_id"),
                                userSet.getString("name"),
                                userSet.getString("email"),
                                storedPassword,
                                userSet.getString("role"),
                                userSet.getTimestamp("created_at")
                        );
                    }
                }
            } catch (SQLException e) {
                // Log the exception (replace with a proper logger in production)
                e.printStackTrace();
            }
        }
        return user; // Returns null if no match is found, or the user info if found
    }
}