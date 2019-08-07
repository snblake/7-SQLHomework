CREATE TABLE employees (
  emp_no INT NOT NULL PRIMARY KEY,
  birth_date DATE NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  gender VARCHAR(5),
  hire_date DATE NOT NULL
);

COPY employees(emp_no, birth_date, first_name, last_name, gender, hire_date)
FROM 'c:/Users/sblake/DENVDEN201905DATA4/Homework/7-SQL 8-3/Instructions/data/employees.csv' DELIMITERS ',' CSV HEADER;

select * from employees

CREATE TABLE departments (
  dept_no VARCHAR(255) NOT NULL PRIMARY KEY,
  dept_name VARCHAR(255) NOT NULL
);

COPY departments
FROM 'c:/Users/sblake/DENVDEN201905DATA4/Homework/7-SQL 8-3/Instructions/data/departments.csv' DELIMITERS ',' CSV HEADER;

CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);


CREATE TABLE salaries (
  emp_no INT NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  title VARCHAR(255) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);

CREATE TABLE dept_manager (  
  dept_no VARCHAR NOT NULL,
  emp_no INT NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);