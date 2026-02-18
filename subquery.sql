--Subqueries
--Employees earning above average salary
select emp_name,salary
from employees
where salary>(
        select avg(salary)as avg_salary
        from employees
        );

--Second highest salary
select emp_name,salary
from(
    select emp_name,salary,dense_rank() over(order by salary desc)as rnk
    from employees
    )
where rnk=2;

--Employees with duplicate salaries
select emp_name,salary
from employees 
where salary in(
    select salary
    from employees
    group by salary
    having count(*)>1
    );

--Employees with unique salary

select emp_name,salary
from employees 
where salary in(
    select salary
    from employees
    group by salary
    having count(*)=1
    );
