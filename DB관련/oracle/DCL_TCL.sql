/*
From oracle documentation:

This statement does not actually create a schema. Oracle Database automatically creates a schema when you create a user

So you first need to create a User with the schema name

As for your query it's fine, since username list is equal to schema names unavailable

오라클 다큐멘테이션에선
이 명령은 실제로 스키마를 생성치 않는다. 오라클 데이터베이스에선 자동적으로 스키마를 생성한다 create user를 할때,
그래서 당신은 당신의 쿼리가 잘동작하기 위해선, 먼저 스키마 명으로된 유저를 생성해야한다.

*/
-- sysdba 계정
-- 유저 생성
create user grant_test_user IDENTIFIED by class5;
-- 계정 락 해제
ALTER USER grant_test_user ACCOUNT UNLOCK;

-- hr계정
grant all on emp to grant_test_user WITH GRANT OPTION;
revoke all on emp from grant_test_user;


------------------------------------------------------
--TCL

-- commit,rollback;
commit;

desc emp;
select * from emp order by empno;

-- empno sequence 생성
create sequence emp_seq
increment by 1
start with 7935
MAXVALUE 9999999999999999999999999999
MINVALUE 1
cycle;

insert into emp 
values(emp_seq.nextval,'save_Sang','IT_PROG',null,sysdate,2000,null,null);

savepoint save1;

insert into emp 
values(emp_seq.nextval,'save_Bang','IT_PROG',null,sysdate+1,5000,null,null);

savepoint save2;
commit;

select * from emp;

rollback to save1;
rollback to save2;
rollback;

delete from emp where ename like 'save%';

commit;




