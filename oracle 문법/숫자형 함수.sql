
-----------------------------------------
-- 절대값 반환함수
select abs(-10) from dual;

-- 반올림 함수
select round(10.2),round(10.8)
from dual;

--소수점 3번째 자리에서 반올림 하시오.
select round(10.123456, 2)from dual;

-- 2번째 자리에서 반올림 하시오.
select round(12345,-2) from dual;

-- 소수점 3번째 자리에서 올림하시오.
select round(10.123456+0.005,2) from dual;

-- 정수 올림 함수
select ceil(10), ceil(10.1)
from dual;

-- 정수 내림 함수
select floor(10),floor(9.9)
from dual;

-- 9의 제곱근을 구하시오
select sqrt(9) from dual;

-- 3의 세 제곱을 구하시오.
select POWER(3,3) from dual;

-- 9에서 2를 나눈 나머지 값을 구하시오
select mod(9,2) from dual;

-- 소수점 2번째 자리 까지 버리시오.
select trunc(10.1234, 2) from dual;

--음수 값이면 -1 0이면 0 양수 값이면 +1을 반환하는 함수
select sign(-19), sign(0), sign(10)
from dual;



