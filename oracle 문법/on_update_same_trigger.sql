drop table emp;
drop table dept;

create table dept(
    deptno VARCHAR2(4) primary key,
    deptname VARCHAR2(20)
);

create table emp(
    empno number(10),
    ename varchar(20),
    sal number(10,2) default 0,
    deptno varchar2(4) not null,
    createdate date DEFAULT sysdate,
    empsex varchar2(3) DEFAULT '남',
    CONSTRAINT emppk PRIMARY key(empno),
    CONSTRAINT empfk foreign key(deptno) REFERENCES dept(deptno)
    on delete cascade,
    constraint sex_attri_domain check(empsex in ('남','여') and empsex is not null)
);

----------------------------------
create table dept(
    deptno VARCHAR2(4),
    deptname VARCHAR2(20)
);

create table emp(
    empno number(10),
    ename varchar(20),
    sal number(10,2) default 0,
    deptno varchar2(4) not null,
    createdate date DEFAULT sysdate,
    empsex varchar2(3) DEFAULT '남',
    constraint sex_attri_domain check(empsex in ('남','여') and empsex is not null)
);

alter table emp add (deptname varchar(20));
alter table dept add constraint deptpk primary key(deptname);
alter table emp add constraint other_foreign foreign key(deptname) REFERENCES dept(deptname);

----------------------------------

drop trigger emp_foreign_update;

create or replace trigger emp_foreign_update 
before update on emp 
referencing old as old new as new
for each row 
begin
    update dept
    set deptno = :new.deptno
    where deptno = :old.deptno;
end;
/

select * from emp;
select * from dept;

delete from dept where deptname='김창수';
insert into dept
values('0001','전자부');

insert into emp
values(1,'김창수',2400000,'0001',sysdate,'남');

update emp
set deptno='0003'
where deptno = '0001';


create sequence empno_seq
increment by 1
start with 1
minvalue 1
maxvalue 100
nocycle
cache 1;

select *from dept;

