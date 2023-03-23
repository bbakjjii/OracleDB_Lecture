-- 14_테이블 수정하기. sql

------------------------- 에러 --------------------------------

/*
    # 테이블에 새 컬럼 추가하기
    - ATER TABLE 테이블명 ADD (컬럼명 컬럼타입 [제약조건], ...);
    - 새 컬럼을 추가할 때는 기존 행들의 추가 컬럼 값이 NULL이 된다
    - DEFAULT를 설정해 놓으면 새롤운 컬럼의 값을 DEFAULT로 하여 추가한다
*/
ALTER TABLE fruits ADD (
    grade VARCHAR2(2)
        CONSTRAINT fruit_grade_chk CHECK (regexp_like(grade, '[ABCDF]\+?')) -- grade를 정규표현식으로 검사를 하겠다. (오류 있음-강사님이 자세히 안함)
);

INSERT INTO fruits VALUES('apple', 13.33, 1300,'99', 'A+');
INSERT INTO fruits VALUES('apple', 13.33, 1300,'99', 'A-');
INSERT INTO fruits VALUES('banana', 12.22, 1200,'98', 'A');
-- DELETE FROM fruits WHERE country_id LIKE '%9%';


-- ★ 연습 1 : fruits 테이블의 country_id에 올바른 외래키 제약조건을 설정해보세요
--         (countries 테이블을 복사한 countries2 테이블로 진행할 것) 
-- 강사님 정답
CREATE TABLE countries2 AS (SELECT * FROM countries);

-- 기본키 설정 : PK 또는 UK여야 외래키의 부모키 역할을 할 수 있다.
ALTER TABLE countries2 ADD CONSTRAINT C2_id_pk PRIMARY KEY (country_id); -- 기본키 제약 이름(?)

SELECT * FROM user_constraints WHERE table_name = 'COUNTRIES2'; -- 제약조건(CONSTRAINT_TYPE)이 C2_ID_PK에 들어온 걸 볼 수 있음

-- 기존 country_id에 부모 컬럼에 존재하지 않는 국가 코드가 있기 때문에 없애버린다.
-- country_id가 '99, 98'이라는 country_id가 없기 때문에 참조가 안되므로 update 해야 함
UPDATE fruits SET country_id = null;

-- 외래키 제약조건 추가
-- COUNTRY_ID에 제약조건 설정
ALTER TABLE fruits ADD CONSTRAINT fruit_c2_fk FOREIGN KEY (country_id)
    REFERENCES countries2 (country_id); -- 에러 발생, country_id가 '99, 98'이라는 country_id가 없기 때문에 참조가 안된다. 
    
DESC fruits;
SELECT * FROM fruits;
SELECT * FROM user_constraints WHERE table_name = 'countries2'; -- 에러 확인

-- 연습 1 : fruits 테이블의 country_id에 올바른 외래키 제약조건을 설정해보세요 --



/*
    # 테이블 컬럼 삭제하기
    - ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
*/

ALTER TABLE fruits DROP COLUMN grade;


/*
    # 테이블 컬럼 이름 변경하기
    - ALTER TABLE 테이블명 RENAME COLUMN 현재이름 TO 바꿀이름;
    - 제약 조건에 사용된 컬럼명도 함께 바뀐다
*/

ALTER TABLE fruits RENAME COLUMN grade TO fruit_grade;
ALTER TABLE fruits RENAME COLUMN fruit_grade TO apple_grade;

SELECT * FROM fruits;
SELECT * FROM user_constraints WHERE table_name = 'FRUITS';


/*
    # 테이블의 제약조건 이름 변경하기
    - ALTER TABLE 테이블명 RENAME CONSTRAINT 제약조건명 TO 바꿀이름;
*/
ALTER TABLE fruits RENAME CONSTRAINT fruit_grade_chk TO fruits_apple_grade_chk;

------------------------- 에러 --------------------------------
/*
    # 테이블 이름 변경하기
    - RENAME 테이블명 TO 바꿀이름;
*/
RENAME coffees5 TO coffeesFive;
SELECT * FROM user_tables;


/*
    # 컬럼 수정하기
    - ALTER TABLE 테이블명 MODIFY (컬럼명 컬럼타입 [제약조건], ...);
    - 이미 존재하는 컬럼의 여러 가지 정보들을 수정할 때 사용
    - 컬럼 크기를 수정할 수도 있다
    - 새로운 제약 조건을 설정할 수도 있다 (삭제는 DROP CONSTRAINT)
    - NOT NULL, CHECK, DEFAULT는 이것을 통해 추가해야 한다
*/

SELECT * FROM coffeesFive;
SELECT * FROM user_constraints WHERE table_name = 'COFFEESFIVE';
DESC coffeesfive;

ALTER TABLE coffeesFive MODIFY (
    coffee_id NUMBER(10),
    CONSTRAINT c5_id_pk PRIMARY KEY (coffee_id)
); -- 이미 COFFEE_ID가 PRIMARY KEY라는 것을 알려줬기 때문에 PRIMARY KEY 뒤에 컬러명을 굳이 안 써줘도 된다


