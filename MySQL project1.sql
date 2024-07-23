Create database Library;
Use Library;
CREATE TABLE Branch (
 Branch_no INT PRIMARY KEY,
 Manager_Id INT,
 Branch_address VARCHAR(255),
 Contact_no VARCHAR(15)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, '123 Main St', '123-456-7890'),
(2, 102, '456 Elm St', '234-567-8901'),
(3, 103, '789 Oak St', '345-678-9012'),
(4, 104, '101 Pine St', '456-789-0123'),
(5, 105, '202 Maple St', '567-890-1234');
Select* from Branch;
CREATE TABLE Employee (
 Emp_Id INT PRIMARY KEY,
 Emp_name VARCHAR(100),
 Position VARCHAR(50),
 Salary DECIMAL(10, 2),
 Branch_no INT,
 FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'Alice Smith', 'Manager', 60000, 1),
(102, 'Bob Johnson', 'Assistant', 45000, 1),
(103, 'Carol White', 'Manager', 70000, 2),
(104, 'David Brown', 'Clerk', 40000, 3),
(105, 'Eve Black', 'Assistant', 55000, 3);
Select* from Employee;
CREATE TABLE Books (
 ISBN VARCHAR(13) PRIMARY KEY,
 Book_title VARCHAR(255),
 Category VARCHAR(100),
 Rental_Price DECIMAL(10, 2),
 Status ENUM('yes', 'no'),
 Author VARCHAR(100),
 Publisher VARCHAR(100)
);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('978-3-16-1481', 'History of Art', 'Art', 30, 'yes', 'John Doe', 'ArtPub'),
('978-0-12-3456', 'Advanced Mathematics', 'Science', 25, 'no', 'Jane Roe', 'SciPub'),
('978-1-23-4567', 'Modern History', 'History', 35, 'yes', 'Mary Major', 'HisPub'),
('978-9-87-6543', 'World Geography', 'Geography', 20, 'yes', 'Paul Minor', 'GeoPub'),
('978-8-76-5432', 'Physics Fundamentals', 'Science', 40, 'no', 'Eve Adams', 'SciPub');
Select* from Books;
CREATE TABLE Customer (
 Customer_Id INT PRIMARY KEY,
 Customer_name VARCHAR(100),
 Customer_address VARCHAR(255),
 Reg_date DATE
);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'John Williams', '123 Maple St', '2020-06-15'),
(202, 'Jane Miller', '456 Oak St', '2021-07-20'),
(203, 'Jack Davis', '789 Pine St', '2022-08-25'),
(204, 'Jill Wilson', '101 Elm St', '2023-09-30'),
(205, 'Jerry Martin', '202 Cedar St', '2019-10-05');
Select* from Customer;
CREATE TABLE IssueStatus (
 Issue_Id INT PRIMARY KEY,
 Issued_cust INT,
 Issued_book_name VARCHAR(255),
 Issue_date DATE,
 Isbn_book VARCHAR(13),
 FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
 FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 201, 'History of Art', '2023-06-05', '978-3-16-1481'),
(2, 202, 'Modern History', '2023-06-10', '978-1-23-4567'),
(3, 203, 'World Geography', '2023-06-15', '978-9-87-6543'),
(4, 204, 'History of Art', '2023-07-01', '978-3-16-1481'),
(5, 205, 'Advanced Mathematics', '2023-07-05', '978-0-12-3456');
Select* from IssueStatus;
CREATE TABLE ReturnStatus (
 Return_Id INT PRIMARY KEY,
 Return_cust INT,
 Return_book_name VARCHAR(255),
 Return_date DATE,
 Isbn_book2 VARCHAR(13),
 FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
 FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 201, 'History of Art', '2023-06-20', '978-3-16-1481'),
(2, 202, 'Modern History', '2023-06-25', '978-1-23-4567'),
(3, 203, 'World Geography', '2023-06-30', '978-9-87-6543'),
(4, 204, 'History of Art', '2023-07-10', '978-3-16-1481'),
(5, 205, 'Advanced Mathematics', '2023-07-15', '978-0-12-3456');
Select* from ReturnStatus;
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;
SELECT c.Customer_name
FROM Customer c
LEFT JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE c.Reg_date < '2022-01-01' AND i.Issue_Id IS NULL;
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE i.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;
SELECT e.Emp_name, b.Branch_address
FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id;
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE b.Rental_Price > 25;
