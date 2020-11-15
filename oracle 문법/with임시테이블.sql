create table emp as
select * from scott.EMP; 

-- 다른계정의 테이블 복사
copy from scott/tiger@orcl create emp using select * from emp;

alter table emp2 rename to employees_2; 


-- with 절을 이용한 가상 테이블 생성
with duplicate_union_table as(
    select * from emp
    union all
    select * from emp
)select * from duplicate_union_table order by empno;




