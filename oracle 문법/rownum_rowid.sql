-- ROWNUM --
-- rownum은 가상 컬럼(수도 컬럼) 으로 값이 할당된 이후에 증가가 이루어진다. [중요]
-- 1. 출력이 되는 경우
select rownum, emp.*
from employees emp
where rownum <10;
/*
1.에서의 경우 from 을 지나 where에서 내부적으로

rownum   emp.*
1<-할당  ~~~~  (rownum은 초기값 0으로 where에서 조건을 비교 -> 조건을 만족함으로 rownum에 1[다음값] 할당)
2<-할당  ~~~~  (rownum은 현재 1임으로 where에서 조건을 비교 -> 조건을 만족함으로 rownum에 2[다음값] 를 할당)
.
.
.
9<-할당  ~~~~ 반복
이런식으로 할당과 조건 비교를 반복하여 이루어진다.
*/
-------------------
--2. 출력이 안되는경우
select rownum, emp.*
from employees emp
where rownum >10;
/*
위와 같은경우 
rownum 의 초기 값은 0 임으로 조건을 비교 -> false -> 다음 값 할당 실패. 즉 rownum은 다음값인 1이 되지 못하고 null값으로 채워지게 되며, 출력값이 안나오게 된다.
*/
select rownum, emp.*
from employees emp
where rownum =1 or rownum>10;
-------------------
--rownum을 사용하여 10~15사이의 행을 출력하려면, 인라인 뷰(서브쿼리)를 이용한 응용이 필요하다.

select emp.*
from (select rownum rowNo, employees.* 
      from employees) emp
where emp.rowNo>=10 and emp.rowNo<=15;


select rownum 
from dual
where rownum=1 a;


select rowid, emp.*
from employees emp;

















select *
	from (select rownum as rowcount, employees.*
	       from employees) emp
	where emp.rowcount>10;


