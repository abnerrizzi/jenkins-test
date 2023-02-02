-- Create the table
CREATE TABLE DEVAPP.departments (
    DEPT INT NOT NULL,
    DEPT_NAME VARCHAR(250) NOT NULL
);

-- Add demo data
INSERT INTO DEVAPP.departments (DEPT, DEPT_NAME) VALUES (1000, 'Marketing');
INSERT INTO DEVAPP.departments (DEPT, DEPT_NAME) VALUES (2000, 'Finance');
INSERT INTO DEVAPP.departments (DEPT, DEPT_NAME) VALUES (3000, 'Information Technology');
INSERT INTO DEVAPP.departments (DEPT, DEPT_NAME) VALUES (4000, 'Operations');
INSERT INTO DEVAPP.departments (DEPT, DEPT_NAME) VALUES (5000, 'Human Resources');

-- Create primary key
ALTER TABLE DEVAPP.departments
    ADD CONSTRAINT pk_departments PRIMARY KEY (DEPT);