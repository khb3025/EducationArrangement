-- 테이블 생성

-- CREATE XXX IF NOT EXISTS 명령 : XXX가 존재하지 않는다면 만들어라.
CREATE TABLE IF NOT EXISTS testDB (
	id int unsigned not null auto_increment comment '학번', -- unsigned -값은 취급하지 않겠다., auto_increment 자동증가 , comment 주석check
    name varchar(31) not null comment '학생명',
    createdate timestamp not null default current_timestamp comment '등록일시', -- 행이 생길때의 시간  
	graduatedt varchar(10) default null comment '졸업일',
    auth tinyint(1) unsigned not null default '9' comment '0:sys, 1:super,9:xxx',
    primary key(id),
    unique key unique_stu_id_name(id, name)  -- unique key이름[제약조건 명]이 unique_stu_id_name
)engine=InnoDB auto_increment=45 default charset=utf8; -- auto_increment를 45부터 시작시킨다.
-- tip: DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP [업데이트시 항상 최근 TIMESTAMP시간대로 설정]


-- https://dev.mysql.com/doc/refman/5.6/en/integer-types.html에서 mysql 자료형 확인
-- Numeric Type: https://dev.mysql.com/doc/refman/5.6/en/numeric-types.html
-- Date & Time: https://dev.mysql.com/doc/refman/5.6/en/date-and-time-type-overview.html
-- String Type: https://dev.mysql.com/doc/refman/5.6/en/string-type-overview.html
use mysql;
use khbTestDB;
show variables like '%time_zone%';
show processlist;


-- 실습
CREATE TABLE TEST(
	id tinyint unsigned not null auto_increment,
    name char(5) not null,
    primary key(id)
);

desc Test;
desc Test2;
insert into Test(name) values('김일수');

show create table test;

CREATE TABLE `test3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ttt` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
