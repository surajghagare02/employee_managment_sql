--Aggregates
--Department‑wise employee count
select dept_id, count(*)as total_count
from employees
group by dept_id;

--Department‑wise total salary
select dept_id,sum(salary)as total_salary
from employees 
group by dept_id;

--Department with highest total salary
select dept_id,salary
from (
    select dept_id,salary,dense_rank() over(partition by dept_id order by salary desc) as rnk
    from employees
    )
where rnk=1;

--Average salary per department
select dept_id,round(avg(salary),2)as avg_salary
from employees
group by dept_id;
