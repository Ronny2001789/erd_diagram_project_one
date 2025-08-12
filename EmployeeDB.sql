CREATE DATABASE EmployeeDB;
\c EmployeeDB

-- ---------------------------------------------
-- Table 1: departments
-- ---------------------------------------------
CREATE TABLE departments (
    depart_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    depart_name VARCHAR(100) NOT NULL,
    depart_city VARCHAR(100) NOT NULL
);

-- ---------------------------------------------
-- Table 2: roles
-- ---------------------------------------------
CREATE TABLE roles (
    role_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

-- ---------------------------------------------
-- Table 3: salaries
-- ---------------------------------------------
CREATE TABLE salaries (
    salary_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    salary_pa DECIMAL(10, 2) NOT NULL CHECK (salary_pa > 0)
);

-- ---------------------------------------------
-- Table 4: overtime_hours
-- ---------------------------------------------
CREATE TABLE overtime_hours (
    overtime_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    overtime_hours DECIMAL(5, 2) DEFAULT 0.00
);

-- ---------------------------------------------
-- Table 5: employees
-- ---------------------------------------------
CREATE TABLE employees (
    emp_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    address TEXT,
    email VARCHAR(100) UNIQUE,
    depart_id INT NOT NULL,
    role_id INT NOT NULL,
    salary_id INT NOT NULL,
    overtime_id INT NOT NULL,

    CONSTRAINT fk_depart FOREIGN KEY (depart_id) REFERENCES departments(depart_id),
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES roles(role_id),
    CONSTRAINT fk_salary FOREIGN KEY (salary_id) REFERENCES salaries(salary_id),
    CONSTRAINT fk_overtime FOREIGN KEY (overtime_id) REFERENCES overtime_hours(overtime_id)
);

-- =============================================
-- Insert Data
-- =============================================

-- Departments
INSERT INTO departments (depart_name, depart_city) 
VALUES
('Engineering', 'San Francisco'),
('Marketing', 'New York'),
('Human Resources', 'Chicago');

-- Roles
INSERT INTO roles (role_name) VALUES
('Software Engineer'),
('Team Lead'),
('HR Manager'),
('Marketing Specialist');

-- Salaries
INSERT INTO salaries (salary_pa) VALUES
(80000.00),
(95000.00),
(70000.00),
(110000.00);

-- Overtime Hours
INSERT INTO overtime_hours (overtime_hours) VALUES
(5.50),
(3.25),
(0.00),
(8.75);

-- Employees
INSERT INTO employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
('John', 'Doe', 'M', '123 Tech St, SF', 'john.doe@company.com', 1, 1, 1, 1),
('Jane', 'Smith', 'F', '456 Market Ave, NY', 'jane.smith@company.com', 2, 4, 2, 2),
('Robert', 'Brown', 'M', '789 HR Blvd, Chicago', 'robert.brown@company.com', 3, 3, 3, 3);

-- =============================================
-- LEFT JOIN: Show Department, Role, Salary, Overtime
-- =============================================
SELECT 
    d.depart_name AS "Department",
    r.role_name AS "Job Title",
    s.salary_pa AS "Salary ($)",
    o.overtime_hours AS "Overtime (Hours)"
FROM employees e
LEFT JOIN departments d ON e.depart_id = d.depart_id
LEFT JOIN roles r ON e.role_id = r.role_id
LEFT JOIN salaries s ON e.salary_id = s.salary_id
LEFT JOIN overtime_hours o ON e.overtime_id = o.overtime_id
ORDER BY d.depart_name, r.role_name;
