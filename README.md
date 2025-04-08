Employee Management System — SQL Project Documentation
🔹 Project Overview
The Employee Management System is a real-world SQL-based application to manage employee data, department info, and payroll. It demonstrates relational database design, query optimization, security, and automation using SQL features.

🔹 Key Features Implemented
Database Schema Design: Normalized tables for Departments, Employees, and Payroll.

Data Integrity: Foreign key constraints, unique checks, salary validation trigger.

Stored Procedure: ProcessPayroll to automate salary calculation.

Trigger: Prevent inserting employees with salary < ₹30,000.

Indexing: On email (Employees) and pay_date (Payroll) for performance.

Security (RBAC):

hr_manager: Limited access to Employees table.

payroll_manager: Limited access to Payroll table.

🔹 How to Use
Run the SQL script using MySQL Workbench or CLI.

Use provided SELECT queries to:

View employees by department

Calculate department-wise payroll

Fetch employee payroll history

Use the ProcessPayroll procedure to update final salary values.

sql
Copy
Edit
CALL ProcessPayroll(1);
 Bonus Features
Triggers for data validation

Stored procedures for automation

Indexed columns for optimized access

Role-based permissions (RBAC)
