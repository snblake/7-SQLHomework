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

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	e.gender, 
	s.salary
FROM employees e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no
ORDER BY e.emp_no

-- 2. List employees who were hired in 1986.
SELECT 
	e.emp_no,
	e.last_name, 
	e.first_name,
	e.hire_date
FROM employees e
WHERE DATE_PART('year', CAST(e.hire_date AS DATE)) = '1986'

-- 3. List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name, and start and end employment dates.

SELECT
	d.dept_no,
	d.dept_name,
	e.emp_no,
	e.last_name,
	e.first_name,
	e.hire_date,
	dm.from_date AS mgr_from_date,
	dm.to_date AS mgr_to_date
FROM 
	dept_manager dm
	LEFT JOIN departments d
		ON d.dept_no = dm.dept_no
	LEFT JOIN employees e
		ON e.emp_no = dm.emp_no	
ORDER BY e.emp_no;	
	
-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees e
	LEFT JOIN dept_emp de
		ON de.emp_no = e.emp_no
	LEFT JOIN departments d
		ON d.dept_no = de.dept_no
WHERE de.to_date > current_date
ORDER BY 1;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT 
	e.first_name,
	e.last_name
FROM employees e
WHERE e.first_name IN ('Hercules')AND e.last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees e
	LEFT JOIN dept_emp de
		ON de.emp_no = e.emp_no
	LEFT JOIN departments d
		ON d.dept_no = de.dept_no
WHERE d.dept_name ='Sales'
ORDER BY e.last_name

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees e
	LEFT JOIN dept_emp de
		ON de.emp_no = e.emp_no
	LEFT JOIN departments d
		ON d.dept_no = de.dept_no
WHERE d.dept_name ='Sales' OR d.dept_name ='Development'
ORDER BY e.last_name

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT
	e.last_name,
	COUNT(e.last_name)
FROM employees e
GROUP BY e.last_name
ORDER BY e.last_name DESC;