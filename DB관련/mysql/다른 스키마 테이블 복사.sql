create table mycopydb.cu_academyinfo_link like cuinfo.cu_academyinfo_link;
insert into mycopydb.cu_academyinfo_link
select * from cuinfo.cu_academyinfo_link;

select * from cu_academyinfo_link;