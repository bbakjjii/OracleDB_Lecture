-- 13_��������.sql

/*
    # ���Ἲ
    - ������ ���� ����
    - �����͸� �ùٸ��� ����, �����ϱ� ���ؼ��� �پ��� ������ ���Ἲ�� �������Ѿ� �Ѵ�
    - �����ͺ��̽��� ���� ������ ���� ���� ���Ἲ���� �����Ѵ�
    
    # ������ ���Ἲ
    - �����Ͱ� ��Ȯ��, �ϰ���, ��ȿ���� �����ϴ� ��
    
    # ��ü ���Ἲ
    - ���̺��� �����ʹ� �ݵ�� �ϳ��� ��ü�� ������ �� �־�� �Ѵ�
    - ��ü ���Ἲ�� ��Ű�� ���� ������������ �⺻Ű(PK)�� ����Ѵ�
    
    # ���� ���Ἲ
    - ���� ���迡 �ִ� �����ʹ� ��ȿ�� �����͸� �����ؾ� �Ѵ�
    - ���� ���Ἲ�� ��Ű�� ���� ������������ �ܷ�Ű(FK)�� ����Ѵ�
    
    # ������ ���Ἲ
    - �ϳ��� ������(�÷�)�� �����ϴ� ��ü���� ��� ���� Ÿ���̾�� �Ѵ�
    - �÷� Ÿ�� �� CHECK ���� ������ ���� ������ ���Ἲ�� ������ �� �ִ�
    
    # DB�� ���� ���ǵ�
    - NOT NULL : �ش� �����ο� NULL�� ������� ����
    - UNIQUE KEY : �ش� �����ο� �ߺ��Ǵ� ���� ������� ���� (NULL�� ���O)
    - PRIMARY KEY : �ش� �������� �⺻Ű�� ����(NOT NULL + UNIQUE) (NULL�� ���X)
    - FOREIGN KEY : �ش� �������� �ܷ�Ű�� ����
    - CHECK : ���ϴ� ������ ������ ��ü�� �߰� ����
*/

/*
    # ������ ��ųʸ� (Data Dictionary)
    - �����Ϳ� ���� ������ (��Ÿ ������)
    - ���� DB�� ��Ȳ�� ���� DB�� �˾Ƽ� �����ϴ� ������
    - ����ڴ� ������ ��ųʸ��� ���� ������ �� ����
    
    # ������ ��ųʸ� �� (Data Dictionary View)
    - ������ ��ųʸ��� ����ڰ� Ȯ���� �� �ֵ��� �����ϴ� ��(View)
    �� View - DB ������Ʈ �� �ϳ��� ���̺�ó�� ��ȸ�� �����ϳ� ������ ������� �� �� ���� ��
    - �տ� user_�� ������ �ش� ������ ������ ��ųʸ��� Ȯ���� �� �ִ�
    - �տ� all_�� ������ ��� ������ ������ ��ųʸ��� Ȯ���� �� �ִ�
*/

show user;

-- ���̺� ������ ��ųʸ� ��
SELECT * FROM user_tables; -- hr �������� �ִ� ���̺�
SELECT * FROM all_tables; -- �����ϴ� ��� ���̺�

-- �������� ������ ��ųʸ� ��
SELECT * FROM user_constraints; -- hr �������� �ִ� ��������
SELECT * FROM all_constraints; -- �����ϴ� ��� ��������


-- employees���̺��� �������Ǹ� ����
SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES'; 
/*
    # Constraint_type
    - P : Primary Key - �⺻Ű
    - R : References (Foreign Key) - �ܷ�Ű
    - C : Check, Not Null - üũ, not null
    - U : Unique  - �ߺ��Ǵ� ���� ���� �ȵȴ�.
*/


/*
    1. ���̺� ������ ���ÿ� �������� �߰��ϱ�
    - �÷��� �÷�Ÿ�� �������� (�������� �̸��� �ڵ������Ǿ� �ľ��� �������) �� �ƹ��� �� ���� ���
    - �÷��� �÷�Ÿ�� CONSTRAINT �������Ǹ� ��������
*/
CREATE TABLE coffees(
    coffee_id NUMBER(10)          
        CONSTRAINT coffee_id_pk PRIMARY KEY, 
    coffee_name VARCHAR2(50)    
        CONSTRAINT coffee_name_nn NOT NULL,
    coffee_price NUMBER(5)         
        CONSTRAINT coffee_price_nn NULL,
    coffee_size VARCHAR2(6)     
        CONSTRAINT coffee_size_chk CHECK(coffee_size IN ('Tall', 'Grande', 'Venti')) -- Tall, Grande, Venti 3�� �߿� ������ ���ԵǾ� �־�� �Ѵ�. null���� ����
        CONSTRAINT coffee_size_nn NOT NULL
);

SELECT * FROM coffees;
DESC coffees

SELECT * FROM user_constraints WHERE table_name = 'COFFEES';

INSERT INTO coffees VALUES (1, 'Americano', 5000, 'Tall');
INSERT INTO coffees VALUES (2, 'Americano', 6000, 'Grande');
-- INSERT INTO coffees VALUES (3, 'Americano', 7000, null); -- null �Ұ����ϴ�
INSERT INTO coffees VALUES (3, 'Americano', 7000, 'Venti');
--DELETE FROM coffees WHERE coffee_size = 'Venti';


-- ���̺��� �����ϴ� ��� �������ǵ鵵 �Բ� �������
DROP TABLE coffees; -- Ŀ�����̺� �����
PURGE recyclebin; -- ������ ����


/*
    2. ���̺� ���� �Ŀ� �������� �߰��ϱ�
    - ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������� (��� �÷�);
    - NOT NULL, CHECK, DEFAULT�� ADD�� �ƴ� MODIFY�� �÷� ��ü�� �����ؾ� �Ѵ�
*/

CREATE TABLE coffees2 (
    coffee_id NUMBER(10),          
    coffee_name VARCHAR2(50),    
    coffee_price NUMBER(5),         
    coffee_size VARCHAR2(6)     
);

-- �� �������� �̸��� �ߺ��ؼ� ����� �� ����
ALTER TABLE coffees2 ADD CONSTRAINT coffee2_id_pk PRIMARY KEY (coffee_id); -- coffee_id�� �⺻Ű�� �ϰ� ���������� �߰��ϰڴ�. 
ALTER TABLE coffees2 ADD CONSTRAINT coffee2_price_uk UNIQUE (coffee_price); -- coffee_price ������ ���� �޶�� �Ѵ�.

-- NOT NULL, CHECK, DEFAULT (CREATE TABLE�� ������ ����)
 -- ���̺� ��ü�� �÷��� ���� ����ٴ� �������� �����.
ALTER TABLE coffees2 MODIFY (
    coffee_name VARCHAR2 (66) DEFAULT 'Caffe Espresso' -- ���ڱ��� 50��66���� ����
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
    3. ���̺� ���� ������� �������� �߰��ϱ�
    - �÷��� ���� ������ �� ���̺� ���������� �ļ��ϴ� ���
    - DEFAULT�� NOT NULL�� ���̺� �������� ������ �� ���� (������ �÷����� �ۼ��ؾ� ��)
*/
CREATE TABLE coffees3 (
    cid NUMBER(3),
    cname VARCHAR2(30),
    cprice NUMBER(5)
        CONSTRAINT c3_price_nn NOT NULL,
    ccode CHAR(2), -- country_code
    CONSTRAINT c3_id_pk PRIMARY KEY (cid),
    CONSTRAINT c3_name_uk UNIQUE (cname),
    CONSTRAINT c3_code_chk CHECK (ccode LIKE '%K%') -- K�� ���� ������ �Է°����ϴ�
);

-- DROP TABLE coffee3;

SELECT * FROM user_constraints WHERE table_name = 'COFFEES3';


/*
    # �ܷ�Ű �����ϱ�
    - �ܷ�Ű ���������� ������ �� � ���̺��� � �÷��� ������ �������� ��Ȯ�ϰ� �����ؾ� �Ѵ�
    - �ܷ�Ű�� �����Ϸ��� �θ� �÷��� PK �Ǵ� UNIQUE ���������� �����Ǿ� �־�� �Ѵ�
    - �ܷ�Ű ���� ������ �ɸ� �÷��� �����ϴ� �÷��� �����ϴ� �� �Ǵ� null�� �߰��� �� �ִ�
*/

SELECT * FROM locations;
DESC locations;


-- 1�� ������� �ܷ�Ű ���� : ���̺� ������ ���ÿ� �������� �߰��ϱ�
SELECT * FROM user_constraints;

CREATE TABLE coffees4 (
    coffee_id NUMBER(10)
        CONSTRAINT c4_id_pk PRIMARY KEY,
    coffee_name VARCHAR2(30),
    coffee_price NUMBER(15),
    location_id NUMBER(4)  -- locations ���̺��� �����ͼ� ���� ����
         -- REFERNECES �θ����̺� (�θ��÷�)
        CONSTRAINT c4_loc_fk REFERENCES locations (location_id) -- ��� �����Ұ���? �� locations�� locations_id�� �����ϰڽ��ϴ�.
       
);

-- INSERT INTO coffees4 VALUES(1, 'Americano', 1500, 1234); -- 1234�� location_id�� ��� �����޼��� �߻�
INSERT INTO coffees4 VALUES(1, 'Americano', 1500, 1600);
INSERT INTO coffees4 VALUES(2, 'Americano', 1500, 1700);

SELECT * FROM coffees4 INNER JOIN locations USING (location_id);


-- 2�� ������� �ܷ�Ű �߰��ϱ� : ���̺� ���� �Ŀ� �������� �߰��ϱ�(table�� �������� alter�ϴ� ���)
CREATE TABLE coffees5 (
    coffee_id NUMBER(10),
    coffee_name VARCHAR2(30),
    coffee_price NUMBER(15),
    location_id NUMBER(4)
);

desc coffees5;


-- ADD CONSTRAINT �������Ǹ� FOREIGN KEY (�ڽ�Ű�÷�) REFERENCES �θ����̺� (�θ�Ű�÷�)
ALTER TABLE coffees5 ADD CONSTRAINT c5_loc_fk 
    FOREIGN KEY (location_id) REFERENCES locations(location_id); -- location_id�� �ܷ�Ű�̰�, locations ���̺��� locations_id. 
    
SELECT * FROM coffees5;
    
-- 3�� ������� �ܷ�Ű �߰��ϱ� : ���̺� ���� ������� �������� �߰��ϱ�
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
    # �ܷ�Ű ���� ��å
    - �ܷ�Ű�� �����ϰ� �ִ� �θ� ���ڵ尡 �����Ǵ� ��쿡 ���� ��å ����
        ex) coffe�� location_id�� �� ���� �ߴµ�, locations���� location_id�� �����ϸ� coffee�� location_id�� ��� �ؾ� �ϴ°�?
        
    (1) ON DELETE CASCADE
    - �θ� ���ڵ尡 �����Ǹ� �ڽ� ���ڵ�鵵 �Բ� ����
    
    (2) ON DELETE SET NULL
    - �θ� ���ڵ尡 �����Ǹ� �ڽ� ���ڵ���� ���� NULL�� ����
    
    (3) RESTRICT (�⺻��)
    - �θ� ���ڵ带 �����Ϸ��� �� �� �ڽ� ���ڵ尡 �����ϸ� ������ ���´�
    - �ܷ�Ű ���� ���� ������ ���� ��å�� �������� ������ �⺻������ RESTRICT�� �ȴ�
*/

-- locations2 ���� (locations ���̺� ����)
CREATE TABLE locations2 AS (SELECT * FROM locations);

-- coffee6�� ���� ���� Ȯ��
SELECT * FROM user_constraints WHERE table_name = 'COFFEES6'; 

-- Coffee6�� locations2�� �ܷ�Ű�� �����ϱ� ���� ���� �������� ����
-- �� �������� �����ϱ� : ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�
--  ALTER TABLE coffees6 DROP CONSTRAINT c6_loc_fk;
ALTER TABLE coffees6 DROP CONSTRAINT c6_loc2_fk;


-- locations2 ���̺��� ������ �� �Բ� ������� ���� �⺻Ű ���� ������ ����
ALTER TABLE locations2 ADD CONSTRAINT loc2_id_pk PRIMARY KEY (location_id);

-- Coffee6�� locations2�� �ܷ�Ű�� ����
ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2 (location_id); -- RESTRICT
       
ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2 (location_id) ON DELETE CASCADE; -- CASCADE (�Բ� ����)
    
 ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2 (location_id) ON DELETE SET NULL -- NULL�� ����
    
SELECT * FROM locations2;    
SELECT * FROM coffees6;

-- �ڽ� ���ڵ尡 ���� �θ� ���ڵ带 �������� ������ ���� (locations2�� location_id 1000���� ����)
DELETE FROM locations2 WHERE location_id = 1000;

-- �ڽ� ���ڵ尡 �ִ� �θ� ���ڵ��� ��� ���� ��å�� ������ ����
DELETE FROM locations2 WHERE location_id = 1300;
DELETE FROM locations2 WHERE location_id = 3200; -- ���� �߻� : child record found

INSERT INTO coffees6 VALUES (1, 'Americano', 123, 1300);
INSERT INTO coffees6 VALUES (1, 'Caffe Latte', 222, 2000);
INSERT INTO coffees6 VALUES (1, 'Caffe Mocha', 333, 2900);
INSERT INTO coffees6 VALUES (1, 'Americano', 300, 3100);
INSERT INTO coffees6 VALUES (1, 'Green Tea', 400, 3200);

DESC coffees6;