--Real scenarios
--Employees with no manager
select *
from employees 
where manager_id is null;

--Managers with more than 2 reportees
select manager_id,count(*)as total_repo
from employees
where manager_id is not null
group by manager_id
having count(*)>2;
select * from employees;

--Salary growth history

SELECT e.emp_id,
       NVL(sh.old_salary, e.salary) AS old_salary,
       NVL(sh.new_salary, e.salary) AS new_salary,
       NVL(sh.change_date, e.hire_date) AS change_date
FROM employees e
LEFT JOIN salary_history sh
ON e.emp_id = sh.emp_id
ORDER BY e.emp_id;


--Latest salary per employee
select e.emp_id,
       NVL(sh.new_salary,e.salary) AS Latest_salary
from employees e
left join salary_history sh
on e.emp_id=sh.emp_id
order by e.emp_id;


select * from salary_history;

--Employees never got hike
select e.*
from employees e
left join salary_history sh
on e.emp_id=sh.emp_id
where sh.emp_id is null;
       
--Highest paid employee per department
select emp_id,emp_name,salary,dept_id
from employees
where salary in(
select max(salary)as highest_salary
from employees
group by dept_id);

select * from employees;

--Advanced
--Employees sharing same salary in same department

select *
from employees 
where (dept_id,salary) in(
        select dept_id,salary
        from employees
        group by dept_id,salary
        having count(*)>1
);

--Cumulative salary per department
select emp_id,
    emp_name,
    salary,
    sum(salary) over(partition by dept_id order by salary)as cuml_salary,
    dept_id
from employees
order by dept_id,salary;

--Running total salary
select dept_id,sum(salary) as total_salary
from employees 
group by dept_id;

--count Employees hired month‑wise
select to_char(hire_date,'yyyy-mm')as hire_month,
        count(*)as total_emp
from employees
group by to_char(hire_date,'yyyy-mm')
order by hire_month;
    
--Department with lowest average salary
select dept_id,
    avg(salary) as avg_salary
from employees
group by dept_id
having avg(salary)=(
     select min(avg_salary)as min_salary
    from(
        select avg(salary) as avg_salary
        from employees
        group by dept_id)
);

