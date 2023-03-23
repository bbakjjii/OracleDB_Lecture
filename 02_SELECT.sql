-- 02_SELECT.sql

/*
    # SELECT 컬럼명 FROM  테이블명;
    - 원하는 테이블의 원하는 컬럼을 조회할 수 있는 쿼리문
    - 컬럼명 자리에 *(별표)를 쓰는 것은 모든 컬럼을 의미한다
    - 여러 컬럼을 조회할 때는 ,(콤마)를 사용해 구분한다
    - 컬럼명과 테이블명은 대소문자를 구분하지 않는다
    - 쿼리문도 대소문자를 구분하지 않는다
    - 데이터는 대소문자를 구분한다

    # HR 계정에 있는 연습용 테이블들
    - EMPLOYEES : 사원 정보 테이블
    - DEPARTMENTS : 부서 정보 테이블
    - JOBS : 직급 정보 테이블
    - LOCATIONS :  지역 정보 테이블
    - COUNTRIES : 나라 정보 테이블
*/

SELECT phone_number  FROM employees; -- employees 테이블의 phone_number만 보기
SELECT employee_id, first_name, phone_number FROM employees;


-- 연습 1 : 존재하는 모든 부서의 부서ID와 부서명을 조회해보세요
-- 다른 컬럼을 적었다면 *(별표)는 빼줘야 한다. *는 모든 컬럼을 보여주는 것이기 때문에
-- 컬럼과 테이블명이 길 경우 아래처럼 들여쓰기를 해준다.
SELECT 
    department_id, department_name 
FROM 
    departments;

-- 연습 2 : 모든 사원의 사번/이름/월급/고용일/부서번호를 조회해보세요
SELECT 
    employee_id, 
    first_name, 
    salary, 
    hire_date, 
    department_id 
FROM employees;


/*
    # DESC 테이블명
    - 해당 테이블의 모든 컬럼 정보를 볼 수 있다 
    - 테이블 형식으로 나올만한 내용이 아니라 스크립트 형식으로 보여준다
    
     # NUMBER(n), NUMBER(n,m)
    - 숫자 데이터를 저장할 수 있는 컬럼 타입
    - 숫자가 하나만 적혀있으면 정수의 길이를 나타낸다
    - 숫자가 두 개 적혀있으면 전체의 길이와 소수점 자릿수를 나타낸다    
        ex) NUMBER(8) → 정수 8자리까지 저장 가능한 컬럼
             NUMBER(8, 3) → 정수 부분은 5자리, 소수 부분은 3자리 저장 가능한 컬럼
              
    # VARCHAR2(n)
    - 가변 길이 문자 데이터를 저장할 수 있는 컬럼 타입
    - 저장되는 데이터의 크기에 맞춰 알맞은 공간을 사용한다.
    - 물리 저장 공간을 효율적으로 사용
    
    # CHAR(n)
    - 고정 길이 문자 데이터를 저장할 수 있는 컬럼 타입
    - 데이터 크기에 맞추지 않고 항상 일정한 공간을 차지한다
    - 해당 컬럼의 성격에 따라 저장 공간 낭비가 심해질 수도 있다
        ex) COUNTRIES 테이블의 국가 코드(COUNTRY_ID) 컬럼 →CHAR(2) → KR, EU, US 등
        
    # DATE
    - 날짜 및 시간 데이터를 저장할 수 있는 컬럼 타입
        ex) EMPLOYEES의 고용일자(HIRE_DATE)  컬럼 → DATE → 03/07/17, 05/09/21 등
     
     
*/
DESC departments;
DESC employees;
DESC countries;
DESC locations;
DESC jobs;

DESC emp_details_view;
SELECT * FROM emp_details_view;

-- DB내의 모든 테이블을 보여준다
select * from all_tables;

-- 컬럼 조회시 AS를 이용해 컬럼명을 원하는 이름으로 수정하여 조회할 수 있다 (원본 AS 변경이름)
SELECT first_name AS 이름, salary AS 급여 FROM employees;

-- 조회 결과에 산술 연산자를 활용할 수 있다
SELECT
    first_name AS 이름, 
    salary AS 월급, 
    salary * 2 AS 두달치, 
    salary * 5 다섯달치 
FROM employees;

-- 컬럼간의 연산도 가능하다 (commission_pct를 활용한 보너스 급여 계산)
-- 자동 줄 맞춤 : 블록 지정 후 마우스 우클릭(블록 설정 안 하면 전체 내용 자동 줄맞춤 됨) → [형식] 클릭 또는 Ctrl + F7
SELECT
    first_name,
    salary,
    commission_pct,
    salary * commission_pct AS 보너스,
    salary + nvl(salary * commission_pct, 0 ) As "보너스 + 급여"   -- 쌍따옴표("")를 붙이면 escape 느낌이 있다.
    -- nvl() 함수 : 여기에 있는 값에 null 일 때 대신 '0'을 쓰겠다. 
FROM
    employees;
    
    /*
    # nvl(column, value)
    - 계산에 사용하는 컬럼에 null값이 있는 경우 null대신 사용할 값을 지정하는 함수 
    - 정상적인 데이터와 null값을 연산하면 결과는 무조건 null이 된다
    */
    
-- 연습 1 : 모든 사원들의 '사번/전체이름/직책/연봉/보너스 적용된 연봉'을 조회해보세요
SELECT
    employee_id,
    first_name || ' ' || last_name AS full_name,
    job_id,
    salary * 12 AS 연봉,
    salary *  ( nvl (commission_pct, 0)  + 1) * 12 AS "보너스 적용된 연봉"
FROM
    employees;
-- 컬럼간 연결 연산자 : ||
-- 띄어쓰기(공백) : ' '

-- SELECT DISTINCT : 각 데이터를 한 번씩만 출력한다 (중복 제거)
SELECT DISTINCT department_id FROM employees; -- 존재하는 부서번를 한번씩 출력
SELECT DISTINCT job_id FROM employees; -- 존재하는 직책을 한번씩만 출력
SELECT DISTINCT first_name FROM employees; -- 겹치는 이름을 한번씩만 출력
