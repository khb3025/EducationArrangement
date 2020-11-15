-- 루프노드 -> 잎사귀노드 검색 쿼리
select emp.*,LEVEL
from employees emp
start with manager_id is null
connect by manager_id = prior employee_id;

select emp.*,LEVEL
from employees emp
start with manager_id is null
connect by manager_id = prior employee_id;

-- 잎사귀 노드 검색 쿼리
select *
from (select Max(level) lvl
      from employees emp
      start with emp.manager_id is null
      connect by emp.manager_id = prior emp.employee_id) maxvalTable, 
     (select emp.* , Level lvl
      from employees emp
      start with emp.manager_id is null
      connect by emp.manager_id = prior emp.employee_id) employees2
where maxvaltable.lvl = employees2.lvl;



-- 직원id가 107번인 말단직원의 bottom-up 계층형 쿼리를 검색하는 sql문을 작성하시오.
select emp.* , LEVEL
	from employees emp
	start with employee_id = 107	
	connect by employee_id = prior manager_id;
    
-- manager_id 가 103 번인 직원들의 BOTTOM-up 계층형 쿼리를 검색하는 sql문을 작성하시오.[직속 상관의 id가 103인 직원들의 bottom-up 계층형 쿼리]
select emp.* , LEVEL
	from employees emp
	start with manager_id = 103	
	connect by employee_id = prior manager_id;
    

-- 계층형 쿼리와 관련된 수도컬럼
--connect_by_isleaf, connect_by_root,sys_connect_by_path, level,connect_by_iscycle
--connect by 절의 추가옵션 nocycle 순환구조가 전개되기 전까지만 전계 [nocycle 은connect_by_iscycle과 함께 사용된다.]
select emp.* ,level lvl, connect_by_isleaf leaf, connect_by_root(employee_id) , SYS_CONNECT_BY_PATH(employee_id, '/'), connect_by_iscycle iscycle 
from employees emp
start with manager_id is null
connect by NOCYCLE manager_id = prior employee_id;







-- 계층형 쿼리를 이용한 랜덤값 발생

select rownum 
from dual
connect by level<=2000;

select rownum , floor(SYS.dbms_random.value(100,1000))
from dual
connect by level<=2000;