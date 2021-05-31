-- 날짜 데이터에 숫자를 더하면 일(date) 데이터에 더해진다.
select sysdate +10
from dual;

-- 날짜 - 날짜 = 연산 가능 [+,*,/ 는 연산 불가] 
select sysdate - to_date('2020-07-10','yyyy-mm-dd') from dual;
select sysdate + to_date('2020-07-10','yyyy-mm-dd') from dual;
select sysdate * to_date('2020-07-10','yyyy-mm-dd') from dual;
select sysdate / to_date('2020-07-10','yyyy-mm-dd') from dual;

-- 월(month)데이터에 달 단위로 가산시 add_months()사용
select add_months(sysdate,5) from dual;

-- 두 날짜의 개월수 차이 구하기
select MONTHS_BETWEEN(SYSDATE,to_date('2020-04-12','yyyy-mm-dd')) from dual;

-- 날짜에서 년, 월, 일 을 따로 추출하기

select extract(year from sysdate) from dual;
select to_char(sysdate,'yyyy') from dual;
select to_char(sysdate,'yyyy/mm') from dual;

select extract(month from sysdate) from dual;
select to_char(sysdate,'MM') from dual;

select extract(day from sysdate) from dual;
select to_char(sysdate,'DD') from dual;

-- 년 월 일 을 더하거나 빼는 방법 (Interval 사용)
-- Interval 에는 year to month 와 day to [hour/minute/second] 가 존재한다.

select sysdate + interval '1-3' year to month from dual;
select sysdate - interval '5 2:30:1' day to second from dual;
select systimestamp,current_timestamp
from dual;

select systimestamp - interval '10 10:30:30' day to second from dual;
