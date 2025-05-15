-- Insert Users
INSERT INTO users (name, email, password, role)
VALUES 
('Alice Sharma', 'alice@example.com', 'pass123', 'CUSTOMER'),
('Bob Rana', 'bob@example.com', 'securepass', 'STAFF'),
('Admin Dev', 'admin@store.com', 'adminpass', 'ADMIN'),
('Chandra Joshi', 'chandra@example.com', 'pass456', 'CUSTOMER'),
('Deepa Thapa', 'deepa@example.com', 'deepa123', 'CUSTOMER');

-- Insert Suppliers
INSERT INTO suppliers (name, contact_number, email, address)
VALUES 
('Fresh Supplies Ltd.', '9812345678', 'fresh@supplies.com', 'Kathmandu, Nepal'),
('Daily Essentials Co.', '9801234567', 'daily@essentials.com', 'Lalitpur, Nepal'),
('QuickMart Pvt Ltd.', '9847654321', 'quick@mart.com', 'Bhaktapur, Nepal'),
('Green Farms', '9850012345', 'greenfarms@farm.com', 'Pokhara, Nepal'),
('Urban Wholesalers', '9865432109', 'urban@wholesale.com', 'Butwal, Nepal');

-- Insert Categories
INSERT INTO categories (name, description)
VALUES 
('Beverages', 'Cold drinks, juices, water, and more.'),
('Groceries', 'Daily groceries including rice, lentils, etc.'),
('Snacks', 'Chips, cookies, chocolates.'),
('Household Items', 'Cleaning and maintenance products.'),
('Personal Care', 'Toiletries and personal care goods.');

-- Insert Products
INSERT INTO products (name, price, quantity, category_id, supplier_id)
VALUES
('Coca Cola 1L', 120.00, 50, 1, 1),
('Basmati Rice 5kg', 800.00, 20, 2, 2),
('Oreo Biscuits', 90.00, 100, 3, 2),
('Orange Juice 500ml', 150.00, 30, 1, 3),
('Lentils 1kg', 200.00, 40, 2, 4),
('Surf Excel 1kg', 350.00, 25, 4, 5),
('Shampoo 400ml', 270.00, 60, 5, 5),
('Dettol Soap 100g', 40.00, 100, 5, 4),
('Mango Juice 1L', 160.00, 35, 1, 1),
('Potato Chips 200g', 110.00, 80, 3, 3);

-- Insert Orders
INSERT INTO orders (user_id, total_amount)
VALUES
(1, 330.00),
(1, 950.00),
(2, 270.00),
(3, 160.00),
(4, 620.00);

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 120.00),     -- 2 x Coca Cola
(1, 3, 1, 90.00),      -- 1 x Oreo
(2, 2, 1, 800.00),     -- 1 x Basmati Rice
(2, 5, 1, 150.00),     -- 1 x Lentils
(3, 7, 1, 270.00),     -- 1 x Shampoo
(4, 9, 1, 160.00),     -- 1 x Mango Juice
(5, 6, 1, 350.00),     -- 1 x Surf Excel
(5, 8, 2, 40.00),      -- 2 x Dettol Soap
(5, 10, 1, 110.00);    -- 1 x Chips