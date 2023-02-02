\c DEVAPP;

-- Create the table
CREATE TABLE departments (
    DEPT INT NOT NULL,
    DEPT_NAME VARCHAR(250) NOT NULL
);

-- Add demo data
INSERT INTO departments (DEPT, DEPT_NAME) VALUES (1000, 'Marketing');
INSERT INTO departments (DEPT, DEPT_NAME) VALUES (2000, 'Finance');
INSERT INTO departments (DEPT, DEPT_NAME) VALUES (3000, 'Information Technology');
INSERT INTO departments (DEPT, DEPT_NAME) VALUES (4000, 'Operations');
INSERT INTO departments (DEPT, DEPT_NAME) VALUES (5000, 'Human Resources');

-- Create primary key
ALTER TABLE departments
    ADD CONSTRAINT pk_departments PRIMARY KEY (DEPT);
