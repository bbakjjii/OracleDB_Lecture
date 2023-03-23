-- 18_유용한 함수들.sql


/* # 숫자 타입 함수들 */

-- abs(n) : 절대값
SELECT -7 FROM dual;
SELECT abs(-7) FROM dual;

-- floor(n) : 내림
SELECT 3.9 FROM dual;
SELECT floor(3.555) FROM dual;

-- ceil(n) : 올림
SELECT 3.146295 FROM dual;
SELECT ceil(3.146295) FROM dual;

-- round(n) : 반올림
SELECT round(3.444) FROM dual;
SELECT round(3.555) FROM dual;

-- mod(n, m) : 나머지 연산
SELECT mod(99, 10) FROM dual;

-- trunc(value, n) : 해당 값의 n자리 이하를 잘라낸다
SELECT trunc(1234567.1234567, 3) FROM dual;
SELECT trunc(1234567.1234567, 5) FROM dual;
SELECT trunc(1234567.1234567, -2) FROM dual;
SELECT trunc(1234567.1234567, -5) FROM dual;




/* 문자 타입 함수들 */
-- to_char(data) : 전달한 데이터를 문자 타입으로 변환 (숫자, 날짜 모두)
SELECT to_char(12345)FROM dual;
DESC dual;

-- sysdate : 현재 날짜 및 시간
SELECT sysdate FROM dual; -- 현재시간(날짜형식)
-- 날짜 타입은 문자 타입으로 변환 시키면서 형식을 지정할 수 있다. (나머지 형식은 구글링)
SELECT to_char(sysdate,'YYYY/MM/DD HH:MI:SS') FROM dual;

-- 숫자 타입을 문자로 변환할 때 사용할 수 있는 형식
--  9 : 해당 자리에 숫자가 들어온다. (0을 채우지 않는다)
--  0 : 해당 자리에 숫자가 들어온다. (0을 채운다)
--  L : 해당 국가의 화폐 기호를 의미한다
SELECT to_char(5000000, '999,999,999L') FROM dual;
SELECT to_char(5000000, '000,000,000L') FROM dual;
SELECT to_char(5000000, '999,999,999') FROM dual;
SELECT to_char(5000000, '999,999,999$') FROM dual;

-- lpad(원본, 전체길이, 채울문자) : 왼쪽에 원하는 문자를 채운다
SELECT lpad('apple', 10, '#') FROM dual;
SELECT lpad('apple', 20, '#') FROM dual;

-- rpad(원본, 전체길이, 채울문자) : 오른쪽에 원하는 문자를 채운다
SELECT rpad('apple', 20, '#') FROM dual;
SELECT lpad(first_name, 20, '#') FROM employees;

-- 채울 문자는 여러개를 넣을 수도 있다
SELECT rpad('apple', 20, ' abc') FROM dual;
SELECT lpad(phone_number, 16, 'Tel:') FROM employees;

SELECT rpad('920430-2',14 , '*') FROM dual; -- 주민번호 뒷자리 가리기! 내가 혼자 해봄!

-- ltrim(원본, 제거대상문자) : 왼쪽의 문자를 제거
-- rtrim(원본, 제거대상문자) : 오른쪽의 문자를 제거
SELECT ltrim('#######apple', '#') FROM dual;
SELECT rtrim('apple######', '#') FROM dual;
SELECT rtrim('apple!@##@###@@@#@!!#', '!@#') FROM dual;

-- trim() : 바끝쪽 공백 제거 (양쪽 모드)
SELECT '   ABC TEST   ' FROM dual;
SELECT trim('   ABC TEST   ') FROM dual;

-- 바깥쪽의 다른 문자를 제거하고 싶은 경우
SELECT trim('#' from '####ABC TEST####') FROM dual;

-- substr(문자, 시작위치, 길이(개수)) : 3번째 값은 마지막 인덱스가 아니라 자르는 문자의 개수를 의미
SELECT substr('Hello,world!', 3, 5) FROM dual;
SELECT substr('Hello,world!', 3, 8) FROM dual;
SELECT substr('Hello,world!', 3) FROM dual; -- 마지막 값을 안 넣으면 끝까지 자름
SELECT substr('Hello,world!', -1) FROM dual; -- 마이너스 값을 넣으면 뒤에서부터 센 위치를 의미
SELECT substr('Hello,world!', -3) FROM dual;
SELECT substr('Hello,world!', -5, 2) FROM dual;

-- 인덱스를 1부터 세므로 주의
SELECT substr('아메리카노', 1, 3) FROM dual;
SELECT substr('아메리카노', -3, 2) FROM dual;

-- length(str) : 길이
SELECT length('아메리카노') FROM dual;
SELECT lengthb('아메리카노') FROM dual; -- byte 길이(한글은 3byte를 차지함)

-- upper(str), lower(str) : 대문자, 소문자
-- initcap(str) : 첫 글자만 대문자
SELECT email FROM employees;
SELECT initcap(email) FROM employees; 
SELECT lower(email) FROM employees; 

-- replace(str, old, new) : 문자 교체
SELECT replace('minsu@naver.com', 'naver', 'google') FROM dual;

-- to_number(data) : 데이터를 숫자 타입으로 변환
SELECT to_number('12341234') FROM dual;
DESC dual;

-- 형식이 있는 문자열을 숫자로 변환
SELECT to_number('$5,000,000', '999,999,999$') FROM dual;
SELECT to_number('5,000,000￦', '999,999,999L') FROM dual;


/* 날짜 타입 함수들 */

-- to_date(data) : 데이터를 날짜 타입으로 변환
SELECT to_date('2022-11-24') FROM dual; -- 기본적인 형식
SELECT to_date('2022--11--24', 'YYYY--MM--DD') FROM dual; -- 형식 지정도 가능하다
SELECT to_Date('2022.11.24') FROM dual;
SELECT to_Date('2022...11...24', 'YYYY...MM..DD') FROM dual; -- 오류

-- trunc(date type) : 날짜를 잘라내는 것이 가능하다
-- 2022/11/24 기준
SELECT trunc(sysdate, 'day') FROM dual; -- 주 단위로 자름(22/11/20) 
SELECT trunc(sysdate, 'month') FROM dual; -- 월 단위로 자름(22/11/01)
SELECT trunc(sysdate, 'year') FROM dual; -- 년 단위로 자름(22/01/01)