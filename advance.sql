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
