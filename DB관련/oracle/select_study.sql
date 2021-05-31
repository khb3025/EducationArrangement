select /*+ index_desc(A) */ *
from employees A;


-- distinct --
select distinct manager_id as "관리자id", department_id as "부서id"
from employees
order by manager_id desc;

select distinct manager_id  "관리자id", department_id "부서id"
from employees
order by manager_id desc;

select distinct manager_id  mi, department_id di
from employees
order by manager_id desc;

----------------
--비교 연산자--

select * from employees;
select * from departments;

select * from employees
where department_id not in(30,60,90);

select * from employees
where department_id not in(select department_id
                            from departments
                            where department_id in(30,60,90));

select * 
from employees emp
where not exists (select department_id
                  from departments dept
                  where department_id in(30,60,90)
                        and emp.department_id = dept.department_id);
select * 
	from employees
	where department_id not in(30,60,90) or department_id is null;


select dept.department_id
from departments dept, employees emp
where dept.department_id in(30,60,90)
  and emp.department_id = dept.department_id;


-- 잘못된 exists사용
select * 
from employees
where not exists (select department_id
                  from departments dept join employees emp using(department_id)
                  where department_id in(30,60,90));
--------------------------------------------------------------------
-- Like sql연산자 사용
select * from employees
where first_name like '__y%er';

-- between 사용     
select *
from employees
where salary between 5000 and 9000;
--------------------------------------------------------------------
--null 관련 함수--

select * from employees;

-- NVL(exp1,0)
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,EMAIL, PHONE_NUMBER, HIRE_DATE ,JOB_ID,SALARY, NVL(COMMISSION_PCT,0), MANAGER_ID, DEPARTMENT_ID
from employees;

-- NVL2(exp1,exp1,0)
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,EMAIL, PHONE_NUMBER, HIRE_DATE ,JOB_ID,SALARY, NVL2(COMMISSION_PCT,COMMISSION_PCT,0), MANAGER_ID, DEPARTMENT_ID
from employees;

-- colesce(exp1,exp2,exp3)
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,EMAIL, PHONE_NUMBER, HIRE_DATE ,JOB_ID,SALARY, coalesce(COMMISSION_PCT, null, 32), MANAGER_ID, DEPARTMENT_ID
from employees;

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,EMAIL, PHONE_NUMBER, HIRE_DATE ,JOB_ID,SALARY, coalesce(COMMISSION_PCT, manager_id, department_id),COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
from employees;

-- nullif
--exp1,exp2가 같은면 null 을 반환 같지 않다면 exp1 반환
select NULLIF(job_id,'FI_ACCOUNT')
from employees;

-----------------------------------------------------------------------------------------------
-- Group 화
select JOB_ID
from employees
group by JOB_ID;

-- 그룹화된 속성과 함께 일반속성의 참조는 불가하다.
select JOB_ID, employee_id, department_id
from employees
group by JOB_ID;
--------------

select JOB_ID, sum(salary),avg(salary),count(job_id),min(salary),max(salary),stddev(salary),VARIANCE(salary)
from employees
group by JOB_ID;

select * from employees;

select department_id, manager_id ,avg(salary)
from employees
group by department_id,manager_id;

select job_id,sum(salary),first_name ||' '||last_name
from employees
group by job_id,first_name,last_name
having sum(salary)>1000
order by job_id;

select department_id ,sum(salary)
from employees
where employee_id between 100 and 103
group by department_id;
-------------------------------------