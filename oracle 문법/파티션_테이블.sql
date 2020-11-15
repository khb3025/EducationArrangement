
create tablespace test_tbs1
datafile 'C:\Users\KIMHB\Desktop\tablespace\test_tbs1.dbf' --파일경로
size 10M --초기 데이터 파일 크기 설정
autoextend on next 10M -- 초기 크기 공간을 모두 사용하는 경우 자동으로 파일의 크기가 커지는 기능
maxsize 100M -- 데이터파일이 최대로 커질 수 있는 크기 지정 기본값 = unlimited
default storage( -- 초기 tablespace의 저장소를 사용자가 커스터마이징시 사용. 
    INITIAL    10K
    NEXT       10K
    MINEXTENTS 2
    MAXEXTENTS 50
    PCTINCREASE 50
);


create tablespace test_tbs2
datafile 'C:\Users\KIMHB\Desktop\tablespace\test_tbs2.dbf' --파일경로
size 10M --초기 데이터 파일 크기 설정
autoextend on next 10M -- 초기 크기 공간을 모두 사용하는 경우 자동으로 파일의 크기가 커지는 기능
maxsize 100M; -- 데이터파일이 최대로 커질 수 있는 크기 지정 기본값 = unlimited

create tablespace test_tbs3
datafile 'C:\Users\KIMHB\Desktop\tablespace\test_tbs3.dbf' --파일경로
size 10M --초기 데이터 파일 크기 설정
autoextend on next 10M -- 초기 크기 공간을 모두 사용하는 경우 자동으로 파일의 크기가 커지는 기능
maxsize 100M; -- 데이터파일이 최대로 커질 수 있는 크기 지정 기본값 = unlimited


--https://javaiyagi.tistory.com/11



create table my_part(
	my_no NUMBER,
	my_year INT NOT NULL,
	my_month INT NOT NULL,
	my_day INT NOT NULL,
	my_value  VARCHAR2(30)
)partition by range(my_year, my_month, my_day)
(
	partition my_q1 values less than(2016,07,01) tablespace test_tbs1,
	partition my_q2 values less than(2017,01,01) tablespace test_tbs2,
	partition my_q3 values less than(2017,07,01) tablespace test_tbs3
); -- .dbf 파일로 생성된 각 테이블 스페이스에 테이블의 파티션을 나누어 저장할 수 있다.
-- 테이블 파티셔닝의 경우 각 파티션을 서로다른 테이블 스페이스 공간에 저장하여 관리할 수 있다.

create table my_part2(
    my_no NUMBER,
	my_year INT NOT NULL,
	my_month INT NOT NULL,
	my_day INT NOT NULL,
	my_value  VARCHAR2(30)
)TABLESPACE test_tbs1;
-- 일반적으로 테이블 생성시 오라클 내부에서 테이블 스페이스라는 공간을 묵시적으로 생성하여 저장한다.
-- 즉 하나의 테이블 스페이스 공간에 여러 테이블을 저장하나, 테이블 파티셔닝의 기법을 이용하면 여러 스페이스 공간에 하나의 테이블을 부분적으로 저장하여 관리할 수 있다.


