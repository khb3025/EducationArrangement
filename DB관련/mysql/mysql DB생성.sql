-- 데이터 베이스 생성
create database khbTestDB;
create schema khbTestDB;
create database dbname default character set utf8 collate utf8_general_ci;
-- 데이터베이스 charsetting 변경
alter database dbname default character set utf8 collate utf8_general_ci;
-- 생성되어 있는 데이터베이스 확인
show databases;
show schemas; -- 동일

-- 데이터베이스 삭제
drop database khbTestDB;

-- 유저 삭제
drop user 'khbTest'@'localhost';
drop user 'khbTest'@'%';

drop table aaa;

-- 사용 DB 변경
use khbTestDB;
use mysql; -- root 계정(관리자 권한 계정)

-- 접속 DB의 테이블 확인.
show tables; -- 관리자 계정으로 검색시 mysql에 등록된 User의 정보가 담겨있는 user 테이블을 확인할수 있음.

-- mysql 관리자 계정에서 호스트와 유저 정보 확인 [host -> % 원격클라이언트 접근 가능 , localhost 지역클라이언트만 접근가능]
-- host는 보안을 위하여 특정 ip범위의 ip만 접근 가능하도록 설정하는데 사용된다.(특정ip등록)
select host, user from user; 

-- 계정 생성 create user 유저명@['%' or 'localhost'] identified by 'password';
create user khbTest@'%' identified by 'khbTest';
create user khbTest@'localhost' identified by 'khbTest';

-- 권한부여(root 계정으로 진행해야함.)
grant all privileges on *.* to 'khbTest'@'%'; -- 모든 스키마에 대하여 모든 권한을 주는 명령어 [위험(관리자 한테만 줘야 함)]
grant all privileges on khbtestDB.* to 'khbTest'@'%'; -- khbtestDB유저에게 khbtestDB데이터베이스의 모든 권한 부여

-- 권한 삭제
revoke all on *.* from 'khbTestDB'@'%'; -- 에러 아님.[버그]

flush privileges; -- 부여한 권한들을 저장(권한에 대한 commit)


