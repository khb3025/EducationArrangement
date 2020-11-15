--19.서브쿼리

--※서브쿼리는 select 구문 안에 존재하는 또다른 select쿼리를 뜻한다.

--select 절에 사용되는 서브쿼리는 스칼라 서브쿼리라고 하며, 
--from 절에 사용되는 서브쿼리는 인라인 뷰라고 한다.
--마지막으로 where절에 사용되는 서브쿼리는 이름 그대로 서브쿼리라고 불린다.
select * 
from employees;
select * from departments;
-- 스칼라 서브쿼리 
-- ※스칼라 서브쿼리는 한 행을 반환해야 한다. 그러나 아래 결과를 보면 dept_min_sal 컬럼에는 동일한 값을 가지는 여러개의 
-- 행을 반환하는 것이 아닌 각 부서의 값에 맞는 최소 급여값을 반환한다. 
-- (분명 스칼라쿼리는 하나의 행만을 반환해야 sql문이 동작하는데? 어떡게 서브쿼리를 이용한 컬럼에 다 다른 값의 행을 가질수 있을까?)
select  dept.* , (select MIN(emp.salary) from employees emp where emp.department_id = dept.department_id) as dept_min_sal
from departments dept ;
-- 해석: 우리 눈에는 한번에 모든 행을 처리하여 결과를 보여주는 것 같지만. db는 from -> where -> group by -> having -> select -> order by 
-- 순으로 각 구문들을 실행시키고 있다.
-- 즉 where 절의 emp.department_id = dept.department_id 조건의 예로 dept의 첫번째 행의 department_id[10] 값과 emp의 department_id[10]의 값이 
-- 일치하는 행들중 min(salary) 값은 하나의 행만을 반환한다. 이 떄 반환값은 10번 부서의 최저 급여액이다.
-- 두번쨰 행에 관하여 서브쿼리가 동작할 때는 20번 부서의 최저 급여만을 반환한다. 이를 모든 부서에 대해 반복하다 보면, 각 부서별 최저급여를 출력하게 되어 
-- 마치 서브쿼리가 하나의 행만을 반환한것이 아닌 것처럼 서브쿼리의 모든행의 값들이 서로 다른 값으로 출력되어 보여지게 되는것이다.

-- 인라인 뷰
-- from 절에 select를 이용한 조건 검색결과를 새로운 임시 테이블로 정의하여 조건 검색에 사용할 수 있다. 
select *
from (select emp.*, rownum as rowcnt
      from employees emp)
where rowcnt >10;


-- 서브쿼리
-- 서브쿼리를 이용한 조건 검색은 동등비교(=) 시에는 서브쿼리의 검색결과가 하나의 행만을 반환하여야 한다.
-- >, < ,!= 등의 비동등 조검 검색시에는 all, any, exist 등의 sql 함수가 필요하다.
-- 스칼라 서브쿼리에선 메인쿼리의 튜플을 출력할 때 서브쿼리 검색 튜플도 같은 시기에 동작하지만 
-- [위 스칼라 쿼리 예제에서 dept.* 인스턴스 스키마를 가지는 하나의 행을 출력할 때, 서브쿼리가 출력하는 하나의 행도 함께 같은 시기에 출력]
-- 조건에서 동작하는 서브쿼리는 비교시 서브쿼리의 모든 행이 출력된 이후 비교되는 것이기에 동등조건에서는 하나의 행만을 서브쿼리가 반환해야 한다.

-- job_id 가 'AD_PRES'인 사원은 하나뿐이다. 결국 서브쿼리의 반환하는 값은 하나의 행임으로 동등 비교가 가능하다.
select *
from employees emp
where emp.employee_id = (select employee_id from employees where  job_id = 'AD_PRES');

-- 아래 sql문은 서브쿼리 결과는 1~99의 사원번호를 가진 사원들의 사원번호을 반환한다.
-- all은 서브쿼리의 반환된 모든 행들의 값이 조건이 되어, 해당 조건들을 모두 만족하는 emp의 튜플만을 반환한다.
-- 즉. where절의 결과는 employee_id>1 and employee_id> 2 and employee_id>3 and,.....and employee_id >199 조건이라 생각하면 되며,
-- 이 조건들을 모두 만족하는 결과는 employee_id 가 200 이상인 직원들임으로 
-- all을 이용한 검색결과는 서브쿼리에서 반환된 결과값의 최대 값보다 큰 직원번호를 가지고 있는 튜플이라는 것을 알 수 있다.

select *
from employees emp
where emp.employee_id > all(select employee_id from employees where employee_id < 200);
---------------------------------------------------------------------
-- any는 서브쿼리에서 튜플들을 조건들로하여 단 하나의 조건이라도 만족하는 경우 해당하는 메인쿼리의 튜플을 출력한다.
-- 아래 sql의 where 구의 조건은 employee_id <= 199 or employee_id <= 198 or employee_id <=197 or ..... employee_id<= 100 과 같다
-- 즉 or로 연결된 조건중 어느 하나라도 만족하면 메인쿼리의 튜플을 출력한다.
select *
from employees emp
where emp.employee_id <= any(select employee_id from employees where employee_id < 200);


-----------------------------------------------------------------------
-- exists(서브쿼리)  exists() 함수는 서브쿼리의 검색결과(결과 튜플)이 메인쿼리 내 테이블에 존재할 경우 true를 반환하는 함수이다.

select *
from employees
where exists(select 1 from employees where employee_id = 150);
-- where 절에서 검색된 결과 값[select절에는 표시할 속성을 작성안하여 보이진 않으나 검색 결과 테이블은 내부적으로 존재] 이 employees 테이블에 존재하는지 확인하여 있으면 true를 내보낸다.
-- 만약 서브쿼리의 결과에 직원아이디가 150인 사람이 없으면 false를 반환함으로 employees의 모든 행이 출력되지 않는다.





