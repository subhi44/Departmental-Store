<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Store Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f2f2;
        }
        .header {
            background: #2c3e50;
            color: white;
            padding: 15px;
            text-align: center;
        }
        .sidebar {
            width: 200px;
            background: #34495e;
            height: 100vh;
            float: left;
            color: white;
            padding: 20px;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 10px;
            text-decoration: none;
            margin-bottom: 5px;
        }
        .sidebar a:hover {
            background: #2c3e50;
        }
        .main {
            margin-left: 220px;
            padding: 20px;
        }
        .dashboard {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .card {
            background: white;
            padding: 20px;
            flex: 1;
            min-width: 250px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
        .card h3 {
            margin-top: 0;
            color: #333;
        }
        .footer {
            text-align: center;
            padding: 10px;
            background: #ddd;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Departmental Store Admin Dashboard</h1>
</div>

<div class="sidebar">
    <h3>Navigation</h3>
    <a href="#">Dashboard</a>
    <a href="#">Products</a>
    <a href="#">Sales</a>
    <a href="#">Customers</a>
    <a href="#">Reports</a>
    <a href="#">Logout</a>
</div>

<div class="main">
    <div class="dashboard">

        <div class="card">
            <h3>🔔 Notifications</h3>
            <ul>
                <li>Low stock: Rice - 5 units left</li>
                <li>New order placed: #1024</li>
                <li>New customer registered: John Doe</li>
            </ul>
        </div>

        <div class="card">
            <h3>💰 Sales Summary</h3>
            <p>Today’s Sales: <strong>$1,250</strong></p>
            <p>This Month: <strong>$23,410</strong></p>
        </div>

        <div class="card">
            <h3>👥 Customers</h3>
            <p>Total Customers: <strong>845</strong></p>
            <p>New This Week: <strong>37</strong></p>
        </div>

        <div class="card">
            <h3>📦 Inventory Overview</h3>
            <p>Items in Stock: <strong>1,320</strong></p>
            <p>Low Stock Alerts: <strong>12 items</strong></p>
        </div>
    </div>

    <div class="footer">
        &copy; 2025 Departmental Store Management System
    </div>
</div>

</body>
</html><!-- ends here -->
