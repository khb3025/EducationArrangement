
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME ,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY
       ,nvl(COMMISSION_PCT,0) COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID
from employees;

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME ,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY
      	        ,nvl2(COMMISSION_PCT,COMMISSION_PCT,0) COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID
from employees;

-- coalesce(attr1,attr2,attr3)
with coalesce_T as (
        select 20  attr1, null as attr2,null as attr3 from dual
        union
        select null, 10, 20 from dual
        union 
        select null, null, 30 from dual
        union 
        select 10, null , 30 from dual
        union
        select null, 20 , null from dual) 
select coalesce(attr1,attr2,attr3),attr1,attr2,attr3 from coalesce_T;

-- nullif
select nullif(10,10), nullif(10,20)
from dual;

