-- 1. Customers Table 

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    phone_number VARCHAR(15)
);

INSERT INTO Customers (customer_id, customer_name, city, phone_number) VALUES
(1, 'Ramesh', 'Trichy', '9876543210'),
(2, 'Suresh', 'Chennai', '8765432109'),
(3, 'Priya', 'Trichy', '7654321098'),
(4, 'Karthik', 'Madurai', '6543210987'),
(5, 'Anita', 'Coimbatore', '5432109876'); 

SELECT *from Customers;

-- 2. Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Groceries'),
(2, 'Electronics'),
(3, 'Clothing');

SELECT *from Categories;


-- 3. Products Table 
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    selling_price DECIMAL(10, 2),
    stock_quantity INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

INSERT INTO Products (product_id, product_name, category_id, selling_price, stock_quantity) VALUES
(101, 'Rice 5kg', 1, 250.00, 50),
(102, 'Bluetooth Speaker', 2, 850.00, 20),
(103, 'T-Shirt', 3, 400.00, 100),
(104, 'Olive Oil 1L', 1, 600.00, 30),
(105, 'Coffee Powder', 1, 150.00, 80),
(106, 'Wireless Mouse', 2, 450.00, 25),
(107, 'Jeans', 3, 900.00, 40);

SELECT *from Products;

-- 4. Departments Table 
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Customer Support'),
(3, 'Inventory');

SELECT *from Departments;


-- 5. Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Employees (employee_id, employee_name, department_id) VALUES
(1, 'Murali', 1),
(2, 'Kavitha', 2),
(3, 'Bala', 3);

SELECT *from Employees;

----6. Orders Table 
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
	total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Orders (order_id, customer_id, employee_id, order_date, payment_method, payment_status,total_amount) VALUES
(1001, 1, 1, '2026-11-20', 'UPI', 'Success',450.00),
(1002, 2, 1, '2026-11-21', 'Credit Card', 'Success',1200.00),
(1003, 3, 2, '2026-11-22', 'Cash', 'Failed',850.00),
(1004, 1, 1, '2026-11-23', 'UPI', 'Success',2100.00),
(1005, 4, 1, '2026-11-24', 'Debit Card', 'Success',340.00);

SELECT *from Orders;


-- 7. Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_total DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, item_total) VALUES
(1, 1001, 101, 2, 500.00),  
(2, 1001, 105, 1, 150.00),    
(3, 1002, 102, 1, 850.00), 
(4, 1003, 104, 1, 600.00),     
(5, 1004, 103, 2, 800.00),  
(6, 1005, 107, 1, 900.00);    

SELECT *from Order_Items;


---Q1. Retrieve the complete details of all customers belonging to Trichy

SELECT * FROM Customers WHERE City = 'Trichy';

---Q2. Identify premium products priced above ₹300. Display product names and selling prices

SELECT Product_Name, Selling_Price FROM Products WHERE Selling_Price > 300;

---Q3. Display all cities without repeating any city

SELECT DISTINCT City FROM Customers;

---Q4. Retrieve products with selling prices ranging from ₹100 to ₹500 (budget promotion)

SELECT * FROM Products WHERE Selling_Price BETWEEN 100 AND 500;

---Q5. Identify the five most expensive products based on their selling prices

SELECT * FROM Products ORDER BY Selling_Price DESC LIMIT 5;

---Q6. Calculate the total number of registered customers

SELECT COUNT(Customer_ID) AS Total_Registered_Customers FROM Customers;

---Q7. Calculate the average selling price of all products

SELECT AVG(Selling_Price) AS Average_Selling_Price FROM Products;

---Q8. Calculate the combined available stock quantity of all products

SELECT SUM(Stock_Quantity) AS Total_Stock_Quantity FROM Products;

---Q9. Display the total collected amount for each payment method

SELECT Payment_Method, SUM(total_Amount) AS Total_Collected FROM Orders GROUP
BY Payment_Method 

---Q10. Display customer names along with their corresponding order IDs (Include customers with no purchases)

SELECT C.Customer_Name, O.Order_ID FROM Customers C LEFT JOIN Orders O ON
C.Customer_ID = O.Customer_ID;

---Q11. Display product names along with their respective category names

SELECT P.Product_Name, C.Category_Name FROM Products P JOIN Categories C ON
P.Category_ID = C.Category_ID;

---Q12. Display each employee's name along with their department name

SELECT E.Employee_Name, D.Department_Name FROM Employees E JOIN Departments D
ON E.Department_ID = D.Department_ID;

---Q13. Investigate complaint: Which product was purchased, which employee handled it, and payment status

SELECT P.Product_Name, E.Employee_Name, O.Payment_Status FROM Orders O JOIN
Order_Items OI ON O.Order_ID = OI.Order_ID JOIN Products P ON OI.Product_ID =
P.Product_ID JOIN Employees E ON O.Employee_ID = E.Employee_ID 

---Q14. Retrieve products priced above the overall average selling price

SELECT * FROM Products WHERE Selling_Price > (SELECT AVG(Selling_Price) FROM
Products);

---Q15. Identify the product with the second-highest selling price

SELECT Product_Name, Selling_Price FROM Products ORDER BY Selling_Price DESC
LIMIT 1 OFFSET 1;

---Q16. Identify customers who have placed more orders than the average order count per customer

SELECT Customer_ID, COUNT(Order_ID) AS Total_Orders FROM Orders GROUP BY
Customer_ID HAVING COUNT(Order_ID) > ( SELECT COUNT(Order_ID) / COUNT(DISTINCT
Customer_ID) FROM Orders );

---Q17. Retrieve complete details of customers who registered but never purchased anything

SELECT * FROM Customers WHERE Customer_ID NOT IN (SELECT DISTINCT Customer_ID
FROM Orders);

---Q18. Identify the three best-selling products in every category based on total quantity sold

WITH RankedProducts AS ( SELECT P.Category_ID, P.Product_Name,
SUM(OI.Quantity) AS Total_Quantity_Sold, DENSE_RANK() OVER(PARTITION BY
P.Category_ID ORDER BY SUM(OI.Quantity) DESC) as Rank_In_Category FROM
Products P JOIN Order_Items OI ON P.Product_ID = OI.Product_ID GROUP BY
P.Category_ID, P.Product_Name ) SELECT Category_ID, Product_Name,
Total_Quantity_Sold FROM RankedProducts WHERE Rank_In_Category <= 3;

---Q19. Display the sales amount for each day along with the cumulative sales amount up to that day

SELECT Order_Date, SUM(Total_Amount) AS Daily_Sales, SUM(SUM(Total_Amount))
OVER(ORDER BY Order_Date) AS Cumulative_Sales FROM Orders GROUP BY Order_Date;

---Q20. Complete sales performance report containing customer, product, employee, date, quantity, total, and status

SELECT C.Customer_Name, P.Product_Name, E.Employee_Name, O.Order_Date,
OI.Quantity, OI.Item_Total, O.Payment_Status FROM Orders O JOIN Customers C ON
O.Customer_ID = C.Customer_ID JOIN Employees E ON O.Employee_ID =
E.Employee_ID JOIN Order_Items OI ON O.Order_ID = OI.Order_ID JOIN Products P
ON OI.Product_ID = P.Product_ID;
