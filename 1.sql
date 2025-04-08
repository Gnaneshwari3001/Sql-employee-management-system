CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) CHECK (salary >= 30000),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL
);

CREATE TABLE Payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    deductions DECIMAL(10,2),
    pay_date DATE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE CASCADE
);
INSERT INTO Departments (name, location) VALUES ('HR', 'New York'), ('Finance', 'London'), ('IT', 'San Francisco');
INSERT INTO Departments (name, location) VALUES ('Hardware', 'USA'), ('Cyber', 'UK'), ('Accounts', 'Dubai');

INSERT INTO Employees (first_name, last_name, email, phone, hire_date, salary, department_id) VALUES
('John', 'Doe', 'john.doe@email.com', '123-456-7890', '2022-06-15', 50000, 1),
('Jane', 'Smith', 'jane.smith@email.com', '123-456-7891', '2021-04-22', 60000, 2);
INSERT INTO Employees (first_name, last_name, email, phone, hire_date, salary, department_id) VALUES
('Joe', 'Dil', 'joe.dil@email.com', '123-456-7892', '2022-08-11', 50000, 3),
('James', 'sim', 'james.smi@email.com', '123-456-7893', '2021-03-12', 60000, 4);
INSERT INTO Employees (first_name, last_name, email, phone, hire_date, salary, department_id) VALUES
('Jack', 'loe', 'jack.loe@email.com', '123-456-7894', '2022-05-10', 50000, 5),
('Juse', 'kim', 'juse.kim@email.com', '123-456-7895', '2021-01-20', 60000, 6);

SELECT * FROM Departments;
SELECT * FROM Employees;



INSERT INTO Payroll (employee_id, salary, bonus, deductions, pay_date) VALUES
(1, 50000, 5000, 2000, '2024-03-31'),
(2, 60000, 6000, 2500, '2024-03-31');

SHOW TABLES;
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Payroll;

DELIMITER //
CREATE PROCEDURE ProcessPayroll(IN emp_id INT)
BEGIN
    UPDATE Payroll
    SET salary = salary + bonus - deductions
    WHERE employee_id = emp_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 30000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary must be at least 30,000';
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 30000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary must be at least 30,000';
    END IF;
END //
DELIMITER ;

CREATE INDEX idx_email ON Employees(email);
CREATE INDEX idx_pay_date ON Payroll(pay_date);

SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.name AS department
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id;

SELECT d.name AS department, SUM(p.salary + p.bonus - p.deductions) AS total_payroll
FROM Payroll p
JOIN Employees e ON p.employee_id = e.employee_id
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.name;




SELECT * FROM Payroll WHERE employee_id = 1;

CREATE USER 'hr_manager'@'localhost' IDENTIFIED BY 'hrpass';
GRANT SELECT, INSERT, UPDATE ON Employees TO 'hr_manager'@'localhost';

CREATE USER 'payroll_manager'@'localhost' IDENTIFIED BY 'paypass';
GRANT SELECT, INSERT, UPDATE ON Payroll TO 'payroll_manager'@'localhost';
FLUSH PRIVILEGES;