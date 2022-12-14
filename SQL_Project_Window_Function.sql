--creating a employee table and insserting values
drop table employee;
create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);
COMMIT;



select * from employee;

-- Using Aggregate function as Window Function
-- Without window function, SQL will reduce the no of records.

SELECT DEPT_NAME, MAX(SALARY) AS MAX_SALARY 
FROM employee group by DEPT_NAME;

-- By using MAX as an window function, SQL will not reduce records but the result will be shown corresponding to each record.

select e.*,  MAX(SALARY) OVER() AS MAX_SALARY FROM employee e;

select e.*,
max(salary) over(partition by dept_name) as max_salary
from employee e;


-- row_number(), rank() and dense_rank()
select e.*,
row_number() over(partition by dept_name order by salary) as rn
from employee e;

SELECT e.*,
row_number() over(partition by dept_name) as rn
from employee e;


-- Fetch the first 2 employees from each department to join the company.
select * from (
	select e.*,
	row_number() over(partition by dept_name order by emp_id) as rn
	from employee e) x
where x.rn < 3;

select * from (
select e.*,
row_number() over(partition by dept_name order by emp_ID) as rn
from employee e) x 
where x.rn <3;


-- Fetch the top 3 employees in each department earning the max salary.
select * from (
	select e.*,
	rank() over(partition by dept_name order by salary desc) as rnk
	from employee e) x
where x.rnk < 4;

--1
select e.*,
rank() over(partition by dept_name order by salary desc) as rank
from employee e;
--2
select e.*,
rank() over(partition by dept_name order by salary desc) as rank,
dense_rank() over(partition by dept_name order by salary desc) as dense_rank
from employee e;

--3
select * from(
select e.*,
rank() over(partition by dept_name order by salary desc) as rnk
from employee e) x
where x.rnk <4;


-- Checking the different between rank, dense_rnk and row_number window functions:
select e.*,
rank() over(partition by dept_name order by salary desc) as rank,
dense_rank() over(partition by dept_name order by salary desc) as dense_rank,
row_number() over(partition by dept_name order by salary desc) as row_number
from employee e;

select e.*,
row_number() over(partition by dept_name order by salary) as row_number,
rank() over(partition by dept_name order by salary) as rank,
dense_rank() over(partition by dept_name order by salary) as dense_rank
from employee e;

-- lead and lag

-- fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
case when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
     when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
	 when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same than previous employee' 
	 end as sal_range
from employee e;

--1
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_emp_salary,
lead(salary) over (partition by dept_name order by emp_id) as next_emp_salary
from employee e;

--2
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_emp_salary,
CASE when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
	 when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
	 when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same as previous employee'
	 END AS salary_range
from employee e;


-- Similarly using lead function to see how it is different from lag.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
lead(salary) over(partition by dept_name order by emp_id) as next_empl_sal
from employee e;
