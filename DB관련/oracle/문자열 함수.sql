-- ascii(문자)
select ascii('A') from dual;

-- char(아스키코드)
select char(65) from dual;

-- substr('문자열', 시작위치, 자를 개수)
select substr('abcdefg',2,3)from dual; -- bcd

--concat(exp1,exp2) 문자열 결합
select concat('abc','cba')from dual;

select concat('i am a boy', 'and i ''m genious')
	from dual;
    
--initcap(문자열) 영문 단어의 앞글자 대문자 변환
select initcap('i am a boy')from dual;

select initcap('i am a boy and i''m genious')
	from dual;
-- upper(문자열) 영문의 모든 문자 대문자 변환
select upper('abcdefghi') from dual;

-- lower(문자열) 영문의 모든 문자 소문자 변환
select lower('ABCDEFG') from dual;

-- 문자열의 길이 반환
select length('abcdefg') from dual; --7
select length('핳핳 하')
from dual;

select lengthb('핳핳 하')
	from dual;
---------------------
l--trim과 rtrim 의 두번 째 인자값으로 들어가는 문자열을 구성하는 문자들을 ltrim의 경우 왼쪽에서 제거 해나가며 rtrim의 경우는 오른쪽에서 제거해나간다.
---------------------
-- ltrim(문자열,제거 문자열) 왼쪽 끝에 존재하는 제거할 문자열을 제거
select ltrim('aabbccdd','ad')from dual; -- aabbcc
select ltrim('aabbccdd','acb')from dual; -- dd

-- rtrim(문자열, 제거 문자열) 오른쪽 끝에 존재하는 제거할 문자열을 제거
select rtrim('aabbccdd','db') from dual; --aabbcc
select rtrim('aabbccdd','dcb') from dual; -- aa
select rtrim('aabbccdd','cbd')
from dual;
------------------------------------------------------------
select trim('  aabbccddbbaa  ')
from dual;

select trim(both 'a' from 'abbccddbba')
from dual;

select 	trim(leading 'a' from 'aabbccdd'),
		trim(trailing 'd' from 'aabbccdd'),
		trim(both 'a' from 'aabbccddaa')
from dual;


-- replace()
select replace('i am a boy','boy', 'girl')
from dual;

-- translate()
select translate('i am a boy','ab','cd')
from dual;

-- instr
select instr('aabbccddaaccddbbaaeeff', 'aa', 5, 2)
from dual;

select instr('aabbccddaaccddbbaaeeff', 'aa', 5,1)
from dual;

select instr('aabbccddaaccddbbaaeeff', 'aa', 5)
from dual;

select instr('aabbccddaaccddbbaaeeff', 'aa')
from dual;


------------------------------------------------------------------------

