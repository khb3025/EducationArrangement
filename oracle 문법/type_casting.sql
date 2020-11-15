
--암시적 타입 캐스팅

select * from employees;

-- salary 값은 number 자료형으로 되어있으나 문자형 숫자 '24000'으로도 조회가 가능하다.
select *
from employees
where salary = '24000';


-- to_number 문자열 숫자 -> 숫자형 데이터 변환
select *
from employees
where salary = to_number('24000');


-- to_char 숫자형 날짜형 데이터를S 주어진 포맷 형식의 문자열로 변환하는 함수
select hire_date, to_char(hire_date,'yyyy-mm-dd')
from employees;

-- to_date 문자열 데이터를 주어진 포맷 형식의 날짜 데이터로 변환하는 함수
select to_date('2020-03-15','yy/mm/dd')
from dual;

-- 숫자 -> 문자열
select to_char(salary) char_salary, salary
from employees;

-- 날짜 -> 문자열 날짜
select to_char(hire_date, 'yyyy-mm-dd') char_hire_date, hire_date
	from employees;
-- 문자 -> 날짜
select to_date('2012-05-21')
from dual;

-- 문자-> 날짜 변환시 sqldeveloper에 설정된 포맷 형식으로 출력된다.
select to_date('2012-05-21','yyyy-mm-dd')
from dual;




