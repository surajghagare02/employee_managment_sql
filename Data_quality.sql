--Data quality
--Find duplicate employees
select emp_name
from employees
group by emp_name
having count(*)>1;

--Delete duplicate records
delete from employees
where emp_id in(
    select emp_id 
    from(
    select emp_id,
            row_number() over(partition by emp_name order by emp_id)as rn
            from employees
    )where rn>1
);