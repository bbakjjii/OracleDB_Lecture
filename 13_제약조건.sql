-- 13_제약조건.sql

/*
    # 무결성
    - 결함이 없는 성질
    - 데이터를 올바르게 유지, 관리하기 위해서는 다양한 종류의 무결성을 충족시켜야 한다
    - 데이터베이스는 제약 조건을 통해 여러 무결성들을 보장한다
    
    # 데이터 무결성
    - 데이터가 정확성, 일관성, 유효성을 유지하는 것
    
    # 개체 무결성
    - 테이블의 데이터는 반드시 하나의 개체를 선택할 수 있어야 한다
    - 개체 무결성을 지키기 위해 제약조건으로 기본키(PK)를 사용한다
    
    # 참조 무결성
    - 참조 관계에 있는 데이터는 유효한 데이터를 참조해야 한다
    - 참조 무결성을 지키기 위해 제약조건으로 외래키(FK)를 사용한다
    
    # 도메인 무결성
    - 하나의 도메인(컬럼)을 구성하는 개체들은 모두 같은 타입이어야 한다
    - 컬럼 타입 및 CHECK 제약 조건을 통해 도메인 무결성을 유지할 수 있다
    
    # DB의 제약 조건들
    - NOT NULL : 해당 도메인에 NULL을 허용하지 않음
    - UNIQUE KEY : 해당 도메인에 중복되는 값을 허용하지 않음 (NULL값 허용O)
    - PRIMARY KEY : 해당 도메인을 기본키로 설정(NOT NULL + UNIQUE) (NULL값 허용X)
    - FOREIGN KEY : 해당 도메인을 외래키로 설정
    - CHECK : 원하는 조건을 만족한 개체만 추가 가능
*/

/*
    # 데이터 딕셔너리 (Data Dictionary)
    - 데이터에 대한 데이터 (메타 데이터)
    - 현재 DB의 상황에 대한 DB가 알아서 관리하는 데이터
    - 사용자는 데이터 딕셔너리를 직접 수정할 수 없다
    
    # 데이터 딕셔너리 뷰 (Data Dictionary View)
    - 데이터 딕셔너리를 사용자가 확인할 수 있도록 제공하는 뷰(View)
    ※ View - DB 오브젝트 중 하나로 테이블처럼 조회는 가능하나 수정은 마음대로 할 수 없는 것
    - 앞에 user_가 붙으면 해당 계정의 데이터 딕셔너리를 확인할 수 있다
    - 앞에 all_이 붙으면 모든 계정의 데이터 딕셔너리를 확인할 수 있다
*/

show user;

-- 테이블 데이터 딕셔너리 뷰
SELECT * FROM user_tables; -- hr 계정에만 있는 테이블
SELECT * FROM all_tables; -- 존재하는 모든 테이블

-- 제약조건 데이터 딕셔너리 뷰
SELECT * FROM user_constraints; -- hr 계정에만 있는 제약조건
SELECT * FROM all_constraints; -- 존재하는 모든 제약조건


-- employees테이블의 제약조건만 보기
SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES'; 
/*
    # Constraint_type
    - P : Primary Key - 기본키
    - R : References (Foreign Key) - 외래키
    - C : Check, Not Null - 체크, not null
    - U : Unique  - 중복되는 값이 들어가면 안된다.
*/


/*
    1. 테이블 생성과 동시에 제약조건 추가하기
    - 컬럼명 컬럼타입 제약조건 (제약조건 이름이 자동생성되어 파악이 힘들어짐) ⇒ 아무도 안 쓰는 방법
    - 컬럼명 컬럼타입 CONSTRAINT 제약조건명 제약조건
*/
CREATE TABLE coffees(
    coffee_id NUMBER(10)          
        CONSTRAINT coffee_id_pk PRIMARY KEY, 
    coffee_name VARCHAR2(50)    
        CONSTRAINT coffee_name_nn NOT NULL,
    coffee_price NUMBER(5)         
        CONSTRAINT coffee_price_nn NULL,
    coffee_size VARCHAR2(6)     
        CONSTRAINT coffee_size_chk CHECK(coffee_size IN ('Tall', 'Grande', 'Venti')) -- Tall, Grande, Venti 3개 중에 무조건 포함되어 있어야 한다. null값은 허용됨
        CONSTRAINT coffee_size_nn NOT NULL
);

SELECT * FROM coffees;
DESC coffees

SELECT * FROM user_constraints WHERE table_name = 'COFFEES';

INSERT INTO coffees VALUES (1, 'Americano', 5000, 'Tall');
INSERT INTO coffees VALUES (2, 'Americano', 6000, 'Grande');
-- INSERT INTO coffees VALUES (3, 'Americano', 7000, null); -- null 불가능하다
INSERT INTO coffees VALUES (3, 'Americano', 7000, 'Venti');
--DELETE FROM coffees WHERE coffee_size = 'Venti';


-- 테이블을 삭제하는 경우 제약조건들도 함께 사라진다
DROP TABLE coffees; -- 커피테이블 지우기
PURGE recyclebin; -- 휴지통 비우기


/*
    2. 테이블 생성 후에 제약조건 추가하기
    - ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건 (대상 컬럼);
    - NOT NULL, CHECK, DEFAULT는 ADD가 아닌 MODIFY로 컬럼 자체를 수정해야 한다
*/

CREATE TABLE coffees2 (
    coffee_id NUMBER(10),          
    coffee_name VARCHAR2(50),    
    coffee_price NUMBER(5),         
    coffee_size VARCHAR2(6)     
);

-- ※ 제약조건 이름은 중복해서 사용할 수 없다
ALTER TABLE coffees2 ADD CONSTRAINT coffee2_id_pk PRIMARY KEY (coffee_id); -- coffee_id를 기본키로 하고 제약조건을 추가하겠다. 
ALTER TABLE coffees2 ADD CONSTRAINT coffee2_price_uk UNIQUE (coffee_price); -- coffee_price 가격이 전부 달라야 한다.

-- NOT NULL, CHECK, DEFAULT (CREATE TABLE과 문법이 같다)
 -- 테이블 자체와 컬럼을 새로 만든다는 느낌으로 만든다.
ALTER TABLE coffees2 MODIFY (
    coffee_name VARCHAR2 (66) DEFAULT 'Caffe Espresso' -- 글자길이 50→66으로 변경
        CONSTRAINT coffee2_name_nn NOT NULL
);

ALTER TABLE coffees2 MODIFY (
    coffee_size VARCHAR2 (10)
        CONSTRAINT coffee2_size_chk
            CHECK(lower(coffee_size) IN ('tall', 'grande', 'venti'))
        CONSTRAINT coffee2_size_nn NOT NULL
);

INSERT INTO coffees2 VALUES(1, 'Americano', 3000, 'ABC');
INSERT INTO coffees2 (coffee_id, coffee_price, coffee_size)  VALUES (2, 2000, 'Abc');

UPDATE coffees2 SET coffee_size = 'grande';

DESC coffees2;
SELECT * FROM coffees2;
SELECT * FROM user_constraints WHERE table_name = 'COFFEES2';


/*
    3. 테이블 레벨 방식으로 제약조건 추가하기
    - 컬럼을 먼저 선언한 후 테이블 제약조건을 후술하는 방식
    - DEFAULT와 NOT NULL은 테이블 레벨에서 정의할 수 없다 (무조건 컬럼에서 작성해야 함)
*/
CREATE TABLE coffees3 (
    cid NUMBER(3),
    cname VARCHAR2(30),
    cprice NUMBER(5)
        CONSTRAINT c3_price_nn NOT NULL,
    ccode CHAR(2), -- country_code
    CONSTRAINT c3_id_pk PRIMARY KEY (cid),
    CONSTRAINT c3_name_uk UNIQUE (cname),
    CONSTRAINT c3_code_chk CHECK (ccode LIKE '%K%') -- K가 들어가는 국가만 입력가능하다
);

-- DROP TABLE coffee3;

SELECT * FROM user_constraints WHERE table_name = 'COFFEES3';


/*
    # 외래키 설정하기
    - 외래키 제약조건은 설정할 때 어떤 테이블의 어떤 컬럼을 참조할 것인지를 명확하게 지정해야 한다
    - 외래키가 참조하려는 부모 컬럼은 PK 또는 UNIQUE 제약조건이 설정되어 있어야 한다
    - 외래키 제약 조건이 걸린 컬럼은 참조하는 컬럼에 존재하는 값 또는 null만 추가할 수 있다
*/

SELECT * FROM locations;
DESC locations;


-- 1번 방식으로 외래키 설정 : 테이블 생성과 동시에 제약조건 추가하기
SELECT * FROM user_constraints;

CREATE TABLE coffees4 (
    coffee_id NUMBER(10)
        CONSTRAINT c4_id_pk PRIMARY KEY,
    coffee_name VARCHAR2(30),
    coffee_price NUMBER(15),
    location_id NUMBER(4)  -- locations 테이블을 가져와서 지점 설정
         -- REFERNECES 부모테이블 (부모컬럼)
        CONSTRAINT c4_loc_fk REFERENCES locations (location_id) -- 어디를 참조할건지? → locations의 locations_id를 참조하겠습니다.
       
);

-- INSERT INTO coffees4 VALUES(1, 'Americano', 1500, 1234); -- 1234는 location_id에 없어서 에러메서지 발생
INSERT INTO coffees4 VALUES(1, 'Americano', 1500, 1600);
INSERT INTO coffees4 VALUES(2, 'Americano', 1500, 1700);

SELECT * FROM coffees4 INNER JOIN locations USING (location_id);


-- 2번 방식으로 외래키 추가하기 : 테이블 생성 후에 제약조건 추가하기(table만 만들어놓고 alter하는 방식)
CREATE TABLE coffees5 (
    coffee_id NUMBER(10),
    coffee_name VARCHAR2(30),
    coffee_price NUMBER(15),
    location_id NUMBER(4)
);

desc coffees5;


-- ADD CONSTRAINT 제약조건명 FOREIGN KEY (자식키컬럼) REFERENCES 부모테이블 (부모키컬럼)
ALTER TABLE coffees5 ADD CONSTRAINT c5_loc_fk 
    FOREIGN KEY (location_id) REFERENCES locations(location_id); -- location_id가 외래키이고, locations 테이블의 locations_id. 
    
SELECT * FROM coffees5;
    
-- 3번 방식으로 외래키 추가하기 : 테이블 레벨 방식으로 제약조건 추가하기
CREATE TABLE coffees6 (
    coffee_id NUMBER(10),
    coffee_name VARCHAR2(30),
    coffee_price NUMBER(15),
    location_id NUMBER(4),
    CONSTRAINT c6_loc_fk FOREIGN KEY (location_id)
        REFERENCES locations(location_id)
);
SELECT * FROM coffees6;

DROP TABLE coffees6;
DROP TABLE locations2;


/*
    # 외래키 삭제 정책
    - 외래키가 참조하고 있던 부모 레코드가 삭제되는 경우에 대한 정책 설정
        ex) coffe에 location_id를 다 설정 했는데, locations에서 location_id를 삭제하면 coffee의 location_id는 어떻게 해야 하는가?
        
    (1) ON DELETE CASCADE
    - 부모 레코드가 삭제되면 자식 레코드들도 함께 삭제
    
    (2) ON DELETE SET NULL
    - 부모 레코드가 삭제되면 자식 레코드들의 값을 NULL로 변경
    
    (3) RESTRICT (기본값)
    - 부모 레코드를 삭제하려고 할 때 자식 레코드가 존재하면 삭제를 막는다
    - 외래키 제약 조건 생성시 삭제 정책을 지정하지 않으면 기본적으로 RESTRICT가 된다
*/

-- locations2 생성 (locations 테이블 복사)
CREATE TABLE locations2 AS (SELECT * FROM locations);

-- coffee6의 제약 조건 확인
SELECT * FROM user_constraints WHERE table_name = 'COFFEES6'; 

-- Coffee6과 locations2를 외래키로 설정하기 위해 기존 제약조건 삭제
-- ※ 제약조건 삭제하기 : ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명
--  ALTER TABLE coffees6 DROP CONSTRAINT c6_loc_fk;
ALTER TABLE coffees6 DROP CONSTRAINT c6_loc2_fk;


-- locations2 테이블을 복사할 때 함께 복사되지 않은 기본키 제약 조건을 설정
ALTER TABLE locations2 ADD CONSTRAINT loc2_id_pk PRIMARY KEY (location_id);

-- Coffee6과 locations2를 외래키로 설정
ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2 (location_id); -- RESTRICT
       
ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2 (location_id) ON DELETE CASCADE; -- CASCADE (함께 삭제)
    
 ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2 (location_id) ON DELETE SET NULL -- NULL로 변경
    
SELECT * FROM locations2;    
SELECT * FROM coffees6;

-- 자식 레코드가 없는 부모 레코드를 삭제에는 제한이 없음 (locations2의 location_id 1000번을 삭제)
DELETE FROM locations2 WHERE location_id = 1000;

-- 자식 레코드가 있는 부모 레코드의 경우 삭제 정책의 영향을 받음
DELETE FROM locations2 WHERE location_id = 1300;
DELETE FROM locations2 WHERE location_id = 3200; -- 오류 발생 : child record found

INSERT INTO coffees6 VALUES (1, 'Americano', 123, 1300);
INSERT INTO coffees6 VALUES (1, 'Caffe Latte', 222, 2000);
INSERT INTO coffees6 VALUES (1, 'Caffe Mocha', 333, 2900);
INSERT INTO coffees6 VALUES (1, 'Americano', 300, 3100);
INSERT INTO coffees6 VALUES (1, 'Green Tea', 400, 3200);

DESC coffees6;