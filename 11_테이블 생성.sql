-- 11_테이블 생성.sql

/*
    # CRUD
    - 대부분의 프로그램이 가지고 있는 기본적인 데이터 처리를 줄여 표현한 것
    - Create    (세이브 파일 생성) : 저장(save)해야 파일이 생성된 것 
    - Read      (세이브 파일 읽기)
    - Update   (세이브 파일을 수정) 
    - Delete    (세이브 파일을 삭제)
    
    # DML (Data Manipulate Language, 데이터 조작어)
    - INSERT : 데이터 추가 쿼리 (DBd의 Create)
    - SELECT : 데이터 읽기 쿼리 (DB의 Read)
    - UPDATE : 데이터 수정 쿼리 (DB의 Update)
    - DELETE : 데이터 삭제 쿼리 (DB의 Delete)
    
    # DDL (Data Definition Language, 데이터 정의어)
    - 테이블, 시퀀스, 뷰, 인덱스, DB계정 등 DB 오브젝트를 종의하는 명령어
    - CREATE : DB 오브젝트 생성
    - ALTER    : DB 오브젝트 수정 (ALTER USER... )
    - DROP     : DB 오브젝트 삭제 (휴지통)
    - TRUNCATE : DB 오브젝트 완전 삭제
    
    # DCL (Data Control Language, 데이터 제어어)
    - DB 유저의 권한을 부여하거나 박탕하는 명령어
    - GRANT    : 권한 부여
    - REVOKE : 권한 회수
*/


/*
    # 테이블 생성하기
    
    CREATE TABLE 테이블명 (컬럼명1 컬럼타입1, 컬럼명2 컬럼타입2, ...);
*/

CREATE TABLE fruits (
    name VARCHAR2 (30), -- 30글자
    sweet NUMBER(4, 2), -- 정수 4자리, 소수점 2개
    price NUMBER (7), -- 100만자리
    country_id CHAR(2), -- 지역번호 2글자
    grade VARCHAR2(2)
);
DESC fruits;

-- Data Dictionary  : tab처럼 DB가 알아서 관리하는 데이터에 대한 데이터 (Meta Data)
SELECT * FROM tab; -- fruits 테이블이 포함됨
SELECT * FROM all_users; -- 모든 사용자들을 보여줌


-- 테이블 삭제 : DROP TABLE 테이블명;
DROP TABLE fruits;

-- DROP TABLE로 삭제한 테이블은 휴지통에 담겨있다
SHOW recyclebin; -- 휴지통
SELECT * FROM recyclebin; -- 휴지통을 보여줌

-- 휴지통에 있던 삭제했던 테이블 복구하기
FLASHBACK TABLE fruits TO BEFORE DROP;
SELECT * FROM tab;

-- 휴지통 비우기
PURGE recyclebin;


-- 기존 테이블을 복사하여 새 테이블 생성하기
CREATE TABLE employees2 AS (SELECT * FROM employees);
DESC employees2;
SELECT * FROM employees2;

INSERT INTO fruits(name, sweet, price, country_id) VALUES('grape', 10.3, 3800, 'KR');


-- 기존 테이블의 구조만 복사하여 새 테이블 생성하기 (올바르게 조회)
DROP TABLE employees3;
CREATE TABLE employees3 AS (SELECT * FROM employees WHERE first_name LIKE '%a%a'); 
-- 1 = 0이라는 조건을 만족시킬 수 있는 행은 없기 때문에 아무것도 나오지 않는다. 하지만 기존 테이블의 구조는 복사되어 있으나 데이터는 복사되지 않는다.
DESC employees3;
SELECT * FROM employees3;

-- 기존 테이블의 구조만 복사하여 새 테이블 생성하기 (일부러 거짓 조건으로 조회)
DROP TABLE employees3;
CREATE TABLE employees3 AS (SELECT * FROM employees WHERE 1 = 0); 
-- 1 = 0이라는 조건을 만족시킬 수 있는 행은 없기 때문에 아무것도 나오지 않는다. 하지만 기존 테이블의 구조는 복사되어 있으나 데이터는 복사되지 않는다.
DESC employees3;
SELECT * FROM employees3;

-- 문제 : locations와 똑같은 형태를 지닌 테이블 locations_dummby를 생성하는 쿼리문을 작성하세요. (단, locations의 데이터는 복사하지 않는다)
CREATE TABLE locations_dummy AS (SELECT * FROM locations WHERE 1 = 0);
SELECT * FROM locations_dummy;
SELECT * FROM locations;


commit;

DESC fruits;