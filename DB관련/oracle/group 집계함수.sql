-- count(*) 과 count(department_id) 의 차이 [null을 포함하여 count, null은 count하지 않음]
select department_id, count(*)
	from employees
	group by department_id;
    
select department_id, count(department_id)
	from employees
	group by department_id;
    
-- 부서별 최대급여, 최소급여, 급여합, 사원수 , 평균급여 , 분산, 표준편차
select max(salary),min(salary), sum(salary), count(*), avg(salary), variance(salary) , stddev(salary)
from employees
group by department_id;

--부서별 최대 급여가 6000이상인 부서만 출력하시오.
select department_id,max(salary)
from employees
group by department_id
having max(salary)>=6000;
