--Date logic
--Employees hired in last 6 months (using table data)
select * from employees;
select * from employees
where hire_date>=(
        select ADD_MONTHS(max(hire_date),-6)
        from employees
        );

--Employees hired in same year
select e1.*
from employees e1
where exists (
    SELECT 1
    FROM employees e2
    WHERE EXTRACT(YEAR FROM e1.hire_date) =
          EXTRACT(YEAR FROM e2.hire_date)
      AND e1.emp_id <> e2.emp_id
);
