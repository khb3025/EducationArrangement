select * from employees
where department_id is not null;
select * from departments;
--내부 조인(inner join)


-- equi 등가 조인[등가 조인은 where를 사용 한 조인을 말한다.]
select *
from employees, departments
where employees.department_id = departments.department_id;


-- 표준 내부 조인
-- natural join 

select *
from employees NATURAL JOIN departments;
/*
 SQL 문의 결과가 다르게 나온 이유는 EMPLOYEES 테이블과 DEPARTMENTS 테이블은 department_id, manager_id 두 개의 이름, 타입이 동일한 컬럼을 가지고 있다. department_id 컬럼은 두 테이블에서 의미하는 것이 같지만 manager_id 컬럼은 의미하는 것이 다르다.
employees.manager_id는 각 사원의 상사를 의미하는 번호이고 departments.manager_id는 그 부서의 부장을 의미하는 번호이다. 자연 조인은 컬럼의 이름, 타입이 같은 컬럼들을 모두 조인에 사용하기 때문에 원하지 않는 결과가 나올 수 있다.
자연 조인은 테이블간에 동일한 형식을 갖는 공통 컬럼이 반드시 하나만 존재해야 한다.
*/

----------------------------------------------

-- inner join ~using 사용
select * from employees inner join departments using(department_id);

-- inner join ~on 결합조건 사용
select * 
from employees emp inner join departments dept
on emp.department_id = dept.department_id;

--[inner 생략하여 조인 시 내부 조인으로 인식]
select * 
from employees emp join departments dept
on emp.department_id = dept.department_id;

--outer join
-- oracle 독자문법을 활용한 left outer join
select *
from employees emp, departments dept
where emp.department_id = dept.department_id(+);
-- ansi left outer join
select *
from employees emp left outer join departments dept using(department_id);

select * 
from employees emp left outer join departments dept
on emp.department_id = dept.department_id;

-- oracle 독자문법을 활용한 right outer join
select *
from employees emp , departments dept
where emp.department_id(+) = dept.department_id;
-- ansi right outer join
select *
from employees emp right outer join departments dept
on emp.department_id = dept.department_id;

-- full outer join
select *
from employees emp full outer join departments dept
on emp.department_id = dept.department_id;

---------------------------------------------------------------------------
-- union 합집합

select *
from (select rownum rowcnt, employees.* from employees) emp
where emp.rowcnt >=5 and emp.rowcnt<=10
union 
select *
from (select rownum rowcnt, employees.* from employees) emp
where emp.rowcnt >=15 and emp.rowcnt<=20;

-- 교집합
select department_id from employees
intersect
select department_id from departments;


-- different (oracle: Minus) 차집합
select *
from (select rownum rowcnt, employees.* from employees) emp
where emp.rowcnt >=5 and emp.rowcnt<=10
MINUS
select *
from (select rownum rowcnt, employees.* from employees) emp
where emp.rowcnt >=8 and emp.rowcnt<=15;

-- catesian product 교차곰(cross join)
-- employees 테이블과 department 테이블의 교차곱 테이블을 구하시오.

--1)
select * 
from employees, departments; --2889행 [107 x 27]
--2)
select * from employees cross join departments; --2889행 [107 x 27]

