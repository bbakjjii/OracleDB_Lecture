-- 12_데이터 추가, 수정, 삭제.sql

/*
    # 테이블에 데이터 추가
    
    INSERT INTO 테이블명 (컬럼명, ...) VALUES(값, ...);

*/

-- fuits 테이블 다시 만들기?
DESC fruits; 

-- 기본적인 추가
INSERT INTO fruits(name, sweet, price, country_id) VALUES('grape', 10.3, 3800, 'KR');
SELECT * FROM fruits;


-- 컬럼의 순서를 바꿀 수도 있다 9값의 순서도 바꿔야 한다)
INSERT INTO fruits(price, name, sweet, country_id) VALUES (800, 'Gyul', 5.5, 'EN');
SELECT * FROM fruits;

-- 컬럼을 반드시 모두 적을 필요는 없다 (생략한 값은 null이 된다)
INSERT INTO fruits(price, name) VALUES (1500, 'apple');
SELECT * FROM fruits;

-- 컬럼을 아예 적지 않는 것도 가능하다 (VALUES에는 모든 컬럼의 모든 값을 순서대로 적어야 한다)
INSERT INTO fruits VALUES ('Pine Apple', 9.99, 8800, 'US');
SELECT * FROM fruits;

-- 서브 쿼리를 통해 INSERT 하기 (컬럼 구조가 동일해야 복사가 가능하다)
INSERT INTO fruits (SELECT * FROM fruits);
INSERT INTO fruits (SELECT * FROM employees); -- 컬럼 구조가 다르면 복사가 불가능하다
SELECT * FROM fruits;

-- INNER JOIN ~ USING ~ : 조인 조건에 사용되는 두 컬럼의 이름이 같다면 USING을 사용해 간편하게 조인할 수 있다.
SELECT * FROM fruits INNER JOIN countries USING (country_id);


/*
    # 테이블 데이터 수정하기
    - UPDATE 테이블명 SET 컬럼 = 값, ... WHERE 조건;
*/

-- 기본적인 데이터 수정
UPDATE fruits SET name = 'Grape' WHERE name = 'grape';
SELECT * FROM fruits;

-- 조건을 적지 않고 데이터를 수정하면 모든 행을 수정하게 된다 (※ 절대 하지 않돋록 주의해야 함)
UPDATE fruits SET country_id = 'CA';
SELECT * FROM fruits;


-- 연습 1 : 당도가 10 미만인 행들의 원산지를 브라질로 변경하기
UPDATE fruits SET country_id  = 'BR' WHERE sweet < 10.00;
SELECT * FROM fruits;

-- 강사님 정답
UPDATE fruits SET country_id = 'BR' WHERE sweet < 10;


-- 연습 2 : 귤의 가격을 400원 증가시키기 (800원 → 1200원)
UPDATE fruits SET price = price + 400 WHERE name = 'Gyul';
SELECT * FROM fruits;

-- 강사님 정답
UPDATE fruits SET price = price + 400 WHERE name = 'Gyul';




/*
    # 테이블 데이터 삭제하기 (테이블 삭제X 데이터 삭제O)
    - DELETE FROM 테이블명 WHERE 조건;
*/

-- 조건을 만족하는 행을 모두 삭제한다
DELETE FROM fruits WHERE lower(name) LIKE '%apple%';
SELECT * FROM fruits;

-- 조건을 적지 않으면 모든 행이 삭제되므로 주의해야 한다
-- DELETE FROM fruits;
SELECT * FROM fruits;


-- 연습 1 : 예전에 직접 설계했던 1:N 테이블을 생성해보기
desc employees;
desc departments;

CREATE TABLE cafeEmployees (
    employee_id NUMBER(6),
    name VARCHAR2(20), 
    phone_number VARCHAR2(20),
    part_id NUMBER(4),  
    salary NUMBER (7),
    hire_date  DATE,
    manager_id NUMBER(6) 
);

CREATE TABLE cafeParts (
    part_id NUMBER(4),
    part_name VARCHAR2(30),
    part_contact VARCHAR2(20),
    manager_id NUMBER(6)
);

CREATE TABLE cafeMenues (
    part_id NUMBER(4),
    menu_name VARCHAR2(30),
    menu_size VARCHAR2(30),
    price NUMBER(7)  
);

CREATE TABLE cafeIngredientsOrder (
    manager_id NUMBER(6),
    Ingredients_name VARCHAR2(30),
    standard_size VARCHAR2(30),
    quantity NUMBER(4),
    unit_price NUMBER(7),
    total_price NUMBER(8),
    ordering_date DATE,
    ordering_organization VARCHAR2(30),
    ordering_contact VARCHAR2(20),
    ordering_email VARCHAR2(50)
);


CREATE TABLE cafeMachine (
    manager_id NUMBER(6),
    machine_name VARCHAR2(30),
    machine_price NUMBER(8),
    durable_years NUMBER(2),
    purchasing_organization VARCHAR2(30),
    purchasing_manager VARCHAR2(20),
    purchasing_contact VARCHAR2(20)
);

SELECT * FROM cafeEmployees;
SELECT * FROM cafeParts;
SELECT * FROM cafeMenues;
SELECT * FROM cafeIngredientsOrder;
SELECT * FROM cafeMachine;

-- 연습 2 : 테이블에 데이터를 적당히 추가해보기
-- DELETE FROM cafeParts WHERE PART_ID LIKE 40;

DESC cafeEmployees;
SELECT * FROM cafeEmployees;

INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(100, '박지영', '010.1234.5678', 10, 5000000, '22/11/11', null);
INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(101, '박세원', '010.1234.5678', 10, 450000, '22/11/20', 100);
INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(102, '장재영', '010.1234.5678', 20, 4500000, '22/11/20', 100);
INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(103, '추상우', '010.1234.5678', 30, 4500000, '22/11/20', 100);
INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(104, '최유나', '010.1234.5678', 40, 4500000, '22/11/20', 100);

DESC cafeParts;
SELECT * FROM cafeParts;
INSERT INTO cafeParts(part_id, part_name, part_contact, manager_id) VALUES(10, 'Beverage', '031.000.0101', 101);
INSERT INTO cafeParts(part_id, part_name, part_contact, manager_id) VALUES(20, 'Bakery', '031.000.0102', 102);
INSERT INTO cafeParts(part_id, part_name, part_contact, manager_id) VALUES(30, 'Sandwich', '031.000.0103', 103);
INSERT INTO cafeParts(part_id, part_name, part_contact, manager_id) VALUES(40, 'Confectionery', '031.000.0104', 104);

DESC cafeMenues;
SELECT * FROM cafeMenues;
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(10, '아메리카노', 'M', 4000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(10, '카페라떼', 'M', 4500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(10, '바닐라라떼', 'M', 4500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(10, '캬라멜마끼아또', 'M', 5000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '딸기생크림케이크', '조각', 6000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '딸기생크림케이크', '1호', 25000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '딸기생크림케이크', '2호', 35000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '앙버터프레첼', 'null', 3000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '몽블랑', 'null', 3500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(30, '치킨 샌드위치', 'null', 5500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(30, '비프 샌드위치', 'null', 6000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(30, '치즈 베이글 샌드위치', 'null', 4500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(30, '모닝 크림치즈 베이글', 'null', 3500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(40, '초코칩 쿠키', '1개', 2000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(40, '녹차 쿠키', '1개', 2000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(40, '밀크티 쿠키', '1개', 2500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(40, '머랭쿠키', '1통', 3000);

DESC cafeIngredientsOrder;
SELECT * FROM cafeIngredientsOrder;
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(101, '킹콩 케냐 가타구아 AA', '1kg', 10, 63000, 630000, '22/11/11', '테라로사', '070-3454-3454', 'info@terarosa.com' );
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(101, '1883 바닐라시럽', '1000ml', 3, 13000, 39000, '22/11/11', '커피창고', '070-4565-4565', 'info@coffeestore.com' );
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(102, '밀가루', '20kg', 5, 20000, 100000, '22/11/11', '제일제당', '02-5740-1114', 'cjmaile.co.kr' );
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(102, '설탕', '10kg', 3, 10000, 30000, '22/11/11', '제일제당', '02-5740-1114', 'cjmaile.co.kr' );
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(103, '토마토', '5kg', 1, 15000, 16000, '22/11/11', '과일나라', '02-5675-5675', 'fruitsland.co.kr' );


DESC cafeMachine;
SELECT * FROM cafeMachine;
INSERT INTO cafeMachine(manager_id, machine_name, machine_price, durable_years, purchasing_organization, purchasing_manager, purchasing_contact) VALUES(101, '라마르조코 KB90', 33000000, 5, '커피천국', '김아무개', '02.443.3343');
INSERT INTO cafeMachine VALUES(102, '데크오븐 3단 dho2-23', 7260000, 5, '삼땡전자', '이아무개', '02.4623.6443');
INSERT INTO cafeMachine VALUES(102, '버티컬밀가루반죽기', 1480000, 5, '엘땡전자', '최아무개', '02.7623.3643');

-- 연습 3 : 두 테이블에 JOIN하여 원하는 데이터를 조회해보기