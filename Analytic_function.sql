--Analytic functions
--Rank employees by salary
select emp_name,salary ,dense_rank() over(order by salary desc)as rnk
from employees;

--Top 2 earners per department
select *
from (
select e.*,dense_rank() over(partition by dept_id order by salary desc)as rnk
from employees e)
where rnk<=2;

--Dense rank vs rank example
select e.*,dense_rank() over(order by salary desc)as dens_rnk
        ,rank() over(order by salary desc)as rnk
from employees e;
