create user khbTestDB@'localhost' identified by 'khbTestDB'; /* 원격으로 접근 불가 계정 생성*/
create user khbTestDB@'%' identified by 'khbTestDB'; /* 원격으로 접근 허용 계정 생성*/
-- mysql의 권한 부여 문장 *.* => 모든권한 부여 -- 
grant all privileges on *.* to khbTestDB@'%';
-- ------------------------ --

-- mysql 사용자 계정 확인 방법 --
use mysql; 
select user,host from user;
-- ------------------------ --

-- 계정삭제 --
drop user newuser@'%';
-- ------------------------ --


