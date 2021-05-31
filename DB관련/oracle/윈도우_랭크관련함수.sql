--
select * from employees;

-- 부서별 급여 순위
select employees.* ,rank() over(partition by department_id order by salary) rank
from employees;

-- 부서별 누적 급여
select emp.*, sum(salary) over(partition by department_id order by salary) as "부서별 누적합계"
from employees emp;

---------------------------------------------------------------------------------------------------------------
-- 급여 누적합계 
select emp.*, sum(salary) over(order by salary) as "누적합계"
from employees emp;

select emp.*, sum(salary) over(order by salary rows between unbounded preceding and current row) as "누적합계"    
-- 파티션은 없음으로 emp테이블의 모든 튜플이 하나의 윈도우이며 급여로 정렬한 결과에서 가장 첫번쨰 튜플 (unbound preceding) 에서 부터 현재 출력하고자하는 튜플(current row) 까지 sum(salary) 해나간 결과를 각 행에 반환한다.
from employees emp;
---------------------------------------------------------------------------------------------------------------
-- 최종 누적합계에서 해당하는 사원의 급여를 제외해 나가는 쿼리
select emp.*, sum(salary) over(order by salary rows between current row and unbounded following) as "제외합계"
-- 파티션은 없음으로 emp테이블의 모든 튜플이 하나의 윈도우이며 급여로 정렬한 결과에서 현재 튜플에서 부터 가장 마지막에 출력하고자하는 튜플(unbound following) 까지 sum(salary)해나간 결과를 각 행에 반환한다..
from employees emp;
---------------------------------------------------------------------------------------------------------------
-- 윈도우는 급여를 오름차순 정렬한 결과에서 첫번쨰 튜플에서 부터 마지막 튜플까지 sum(salary)한 값을 모든 행에 반환한다.
select emp.*, sum(salary) over(order by salary rows between unbounded preceding and unbounded following) as "급여 누적합계"
from employees emp;


-- 부서를 파티션으로 윈도우 적용 누적합계
-- 부서별 누적 급여
select emp.*, sum(salary) over(partition by department_id order by salary) as "부서별 누적합계"
from employees emp;

select emp.*, sum(salary) over(partition by department_id order by salary rows between unbounded preceding and current row) as "부서별 누적합계"
from employees emp;

--※ 윈도우 절을 사용하지 않는경우는 윈도우 절을 unbound preceding 과 current row 의 범위조건으로 설정한 결과와 같다.


--range (https://gaiag.tistory.com/27) 참고
select emp.*, sum(salary) over(partition by department_id order by rowcnt range between 1 preceding and 2 following)
from (select rownum as rowcnt, employees.* from employees) emp;

/*
기준이 되는 행의 salary를 보면  1 preceding 은 기준행으로부터 한 행 전의 행을 나타낸다 [order by 가 rowcnt라서 그렇다. 쫌 더 상세한 preceding과 following을 확인하고 싶으면, 20-2-4.번 문제와 함께 출력결과를 살펴보자.]
2 following은 기준이 되는 행에서 2행 떨어진 행까지의 범위를 뜻한다. 
즉. 결론을 말하자면 기준행에 나온 sum(salary) 값은 {기준행의 한 행전 두 행 후 ->15~ 18번쨰행의 salary 값을 합한 값을 뜻한다.}

15	114	Den	        Raphaely	DRAPHEAL	515.127.4561	02/12/07	PU_MAN	    11000		100	30	17000
16	115	Alexander	Khoo	    AKHOO	    515.127.4562	03/05/18	PU_CLERK	3100		114	30	19800   - 기준{11000+3100+2900+2800 = 19800}
17	116	Shelli	    Baida	    SBAIDA	    515.127.4563	05/12/24	PU_CLERK	2900		114	30	11400
18	117	Sigal	    Tobias	    STOBIAS 	515.127.4564	05/07/24	PU_CLERK	2800		114	30	10800
19	118	Guy	        Himuro	    GHIMURO	    515.127.4565	06/11/15	PU_CLERK	2600		114	30	7900
20	119	Karen	    Colmenares	KCOLMENA	515.127.4566	07/08/10	PU_CLERK	2500		114	30	5100
*/

-- 20-1-1. employees 테이블에서 윈도우 절을 사용하지 않고 누적합계를 구하시오. (정렬은 salary속성을 기준으로 정렬하시오.)
select emp.* , sum(salary) over(order by salary)
from employees emp;
-- 20-1-2. employees 테이블에서 윈도우 절을 사용하여 않고 누적합계를 구하시오. (정렬은 salary속성을 기준으로 정렬하시오.)
select emp.* , sum(salary) over(order by salary rows between unbounded preceding and current row)
from employees emp;

--20-1-3. 20-1-1과 20-1-2의 출력결과의 차이점을 설명하시오.
select emp.*, sum(salary) over(order by salary rows between current row and unbounded following)
from employees emp;

--20-1-5.부서별 누적 금액을 구하시오.
select emp.* , sum(salary) over(partition by department_id order by salary)
from employees emp;



--20-1-6. 20-1-5. 의 sql문과 동일한 출력을 하는 sql문을 윈도우절을 포함하여 작성하시오.

select emp.*, sum(salary) over(partition by department_id order by salary rows between unbounded preceding and current row)
from employees emp;


--20-1-7. 각 부서의 구성원들의 튜플에 부서별 합계 금액 속성을 추가하시오.

select emp.*, sum(salary) over(partition by department_id order by salary rows between unbounded preceding and unbounded following)
from employees emp;

--20-2-1. range를 이용하여 두 행이전의 금액에서부터 현재 출력행 까지의 누적 금액을 구하시오.
select emp.* , sum(salary) over(order by rowcnt range 2 preceding)
from (select rownum rowcnt, employees.*from employees) emp;

--20-2-2. 20-2-1.의 출력결과와 같은 출력을 가지는 sql문을 between 구절을 사용하여 작성하시오.
select emp.* , sum(salary) over(order by rowcnt range between 2 preceding and current row)
from (select rownum rowcnt, employees.*from employees) emp;

--20-2-3. range를 이용하여 한 행 이전의 금액부터 두 행 이후의 금액을 누적한 금액을 구하시오.
select emp.*, sum(salary) over(order by rowcnt range between 1 preceding and 2 following)
from (select rownum rowcnt, employees.*from employees) emp;

--20-2-4. 현재 행의 salary를 기준으로 밑으로 1000이하로 차이나는 금액과 위로 2000 이하로 차이나는 금액을 더하시오.
select emp.*, sum(salary) over(order by salary range between 1000 preceding and 2000 following)
from (select rownum as rowcnt, employees.* from employees) emp;

--20-3-1. rank() 순위 함수 [특정 파티션 내에서 순위를 계산하는 함수로 같은 값에서는 같은 순위를 할당한다. 그러나 다음 순위를 부여할때는 동률순위를 부여받은 사람수에 영향을 받아 순위가 결정된다.]

	--1) 부서별 직원들의 급여 순위를 나타내시오.[가장 많이 받는 사람이 1등](같은 급여를 받는 직원은 동률 순위를 부여하며, 동률 순위를 부여한 후에는 다음에 와야하는 순위가 생략된다.)
	select emp.* , rank() over(partition by department_id order by salary desc) rank
	from employees emp
    order by department_id;
    
    --※ rank 관련함수는 윈도우절을 사용할 수 없다. ==> 당연하다. window절의 current row를 생각하면 가변적으로 순위가 정해져야 하는데 한 윈도우에 한 행이 추가될때마다 순위를 변경해주어야 한다는게
    -- 인공지능도 아니고 불가능하다는게 느낌이 오지 않나?
    -- 아래의 sql문은 당연히 에러를 발생시킨다.
    select emp.* , rank() over(partition by department_id order by salary desc rows between unbounded preceding and unbounded following) rank
	from employees emp
    order by department_id;
   
--20-3-2. dense_rank() 순위 함수 [동일한 값에서는 같은 순위로 계산한다. 동률 순위를 부여하더라도 다음 순위를 부여할 때 영향이 없다.]
-- ※ 1등이 1명 2등이 2명이라면 3등은 없고 다음 순위로 4등이 부여
	--1) 같은 급여를 받는 직원은 동률 순위를 부여하며, 이후에 순위를 부여받는 사람은 동률 순위를 부여받은 사람 수의 영향을 받지않는 sql문을 작성하시오.
	select emp.* , dense_rank() over(partition by department_id order by salary) dense_rank
	from employees emp
	order by department_id;
   
--20-3-3. row_number() [같은 값을 가지더라도 정렬되는 순서대로 고유한 값을 부여한다.]
-- ※ 같은 값을 가진 2등을 부여하려하는데 같은 값이 3명이라고 가정하면 정렬 순서에 따라 가장 먼저오는 튜플에 2등을 부여 나머지는 3등 4등 을 부여

	--1) 동률 급여일 시 정렬순서에 따라순위를 부여하는 sql문을 작성하시오. 
	select emp.* , row_number() over(partition by department_id order by salary) row_num
	from employees emp;
    
--20-4. 행관련 수도컬럼 함수

--20-4-1. 파티션의 첫 번째 값을 반환하는 FIRST_VALUE()함수
	select   emp.* , 
             first_value(salary) over(partition by department_id order by salary rows between unbounded preceding and unbounded following) as "첫행-끝행",
		     first_value(salary) over(partition by department_id order by salary rows between unbounded preceding and current row) as "첫행-현재행",
		     first_value(salary) over(partition by department_id order by salary rows between current row and unbounded following) as "현재행-끝행"
	from employees emp;
    
--20-4-2. 파티션의 마지막 값을 반환하는 LAST_VALUE() 함수
	select   emp.* , 
             last_value(salary) over(partition by department_id order by salary rows between unbounded preceding and unbounded following) as "첫행-끝행",
		     last_value(salary) over(partition by department_id order by salary rows between unbounded preceding and current row) as "첫행-현재행",
		     last_value(salary) over(partition by department_id order by salary rows between current row and unbounded following) as "현재행-끝행"
	from employees emp;
    
--20-4-3. 현재 행 이전의 @행의 값을 반환하는 LAG() 함수
    select   emp.* , 
             LAG(salary,2) over(partition by department_id order by salary ) lag
	from employees emp;
    
     select   emp.* , 
             LAG(salary,2,null) over(partition by department_id order by salary ) lag
	from employees emp;

--20-4-3. 현재행을 기준으로 특정 행 떨어져 있는 행의 값을 반환하는 lead()함수
--※ lead는 이끈다라는 뜻이 있어 현재 행을 기준으로 @행 이전의 행의 값을 결과로 가져올것 같지만.
-- 사실 lead는 현재행이 이끈다 라는 의미로써 @행 이후의 행의 값을 결과로 가져온다.
    select   emp.* , 
             lead(salary,2) over(partition by department_id order by salary ) lead
	from employees emp;
    
    select   emp.* , 
             lead(salary,2,null) over(partition by department_id order by salary ) lead
	from employees emp;
    --※ lead, lag함수는 가져올 행이 없을 경우 대체할 값을 3번째 인자로 설정할 수 있다.
    
    
    
--20-5-1. 누적백분률을 구하는 함수 cume_dist()함수 [자신보다 작거나 같은 행에 대한 누적 백분률을 구하는 함수이다.]
       -- 와 순위 퍼센트를 구하는 함수인 percent_rank() 함수.
    select emp.* , rank()over(partition by department_id order by salary) rank,
           percent_rank() over(partition by department_id order by salary) as  "순위퍼센트" ,
           cume_dist() over(partition by department_id order by salary)as "순위누적백분률",
           RATIO_TO_REPORT(salary) over(partition by department_id)as "합계누적백분율"
    from employees emp
    where emp.department_id = 60;
    
--20-5-2. 파티션별로 N등분한 결과를 조회하는 NTILE함수
    select emp.*, Ntile(4) over(partition by department_id order by salary) as "n등분순위"
    from employees emp
    where emp.department_id in (50,60);
    

    
    