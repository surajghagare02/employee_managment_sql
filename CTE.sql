--CTE
--Generate numbers using CTE
with numbers (n) as(
        select 1 
        from dual
        UNION ALL
        select n+1
        from numbers
        where n<10
)
select * 
from numbers;

--Department salary using CTE
with dep as(
    select dept_id,sum(salary) as total_salary
    from employees
    group by dept_id
)
select * from dep;
