-- 12_������ �߰�, ����, ����.sql

/*
    # ���̺� ������ �߰�
    
    INSERT INTO ���̺�� (�÷���, ...) VALUES(��, ...);

*/

-- fuits ���̺� �ٽ� �����?
DESC fruits; 

-- �⺻���� �߰�
INSERT INTO fruits(name, sweet, price, country_id) VALUES('grape', 10.3, 3800, 'KR');
SELECT * FROM fruits;


-- �÷��� ������ �ٲ� ���� �ִ� 9���� ������ �ٲ�� �Ѵ�)
INSERT INTO fruits(price, name, sweet, country_id) VALUES (800, 'Gyul', 5.5, 'EN');
SELECT * FROM fruits;

-- �÷��� �ݵ�� ��� ���� �ʿ�� ���� (������ ���� null�� �ȴ�)
INSERT INTO fruits(price, name) VALUES (1500, 'apple');
SELECT * FROM fruits;

-- �÷��� �ƿ� ���� �ʴ� �͵� �����ϴ� (VALUES���� ��� �÷��� ��� ���� ������� ����� �Ѵ�)
INSERT INTO fruits VALUES ('Pine Apple', 9.99, 8800, 'US');
SELECT * FROM fruits;

-- ���� ������ ���� INSERT �ϱ� (�÷� ������ �����ؾ� ���簡 �����ϴ�)
INSERT INTO fruits (SELECT * FROM fruits);
INSERT INTO fruits (SELECT * FROM employees); -- �÷� ������ �ٸ��� ���簡 �Ұ����ϴ�
SELECT * FROM fruits;

-- INNER JOIN ~ USING ~ : ���� ���ǿ� ���Ǵ� �� �÷��� �̸��� ���ٸ� USING�� ����� �����ϰ� ������ �� �ִ�.
SELECT * FROM fruits INNER JOIN countries USING (country_id);


/*
    # ���̺� ������ �����ϱ�
    - UPDATE ���̺�� SET �÷� = ��, ... WHERE ����;
*/

-- �⺻���� ������ ����
UPDATE fruits SET name = 'Grape' WHERE name = 'grape';
SELECT * FROM fruits;

-- ������ ���� �ʰ� �����͸� �����ϸ� ��� ���� �����ϰ� �ȴ� (�� ���� ���� �ʵ��� �����ؾ� ��)
UPDATE fruits SET country_id = 'CA';
SELECT * FROM fruits;


-- ���� 1 : �絵�� 10 �̸��� ����� �������� ������� �����ϱ�
UPDATE fruits SET country_id  = 'BR' WHERE sweet < 10.00;
SELECT * FROM fruits;

-- ����� ����
UPDATE fruits SET country_id = 'BR' WHERE sweet < 10;


-- ���� 2 : ���� ������ 400�� ������Ű�� (800�� �� 1200��)
UPDATE fruits SET price = price + 400 WHERE name = 'Gyul';
SELECT * FROM fruits;

-- ����� ����
UPDATE fruits SET price = price + 400 WHERE name = 'Gyul';




/*
    # ���̺� ������ �����ϱ� (���̺� ����X ������ ����O)
    - DELETE FROM ���̺�� WHERE ����;
*/

-- ������ �����ϴ� ���� ��� �����Ѵ�
DELETE FROM fruits WHERE lower(name) LIKE '%apple%';
SELECT * FROM fruits;

-- ������ ���� ������ ��� ���� �����ǹǷ� �����ؾ� �Ѵ�
-- DELETE FROM fruits;
SELECT * FROM fruits;


-- ���� 1 : ������ ���� �����ߴ� 1:N ���̺��� �����غ���
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

-- ���� 2 : ���̺� �����͸� ������ �߰��غ���
-- DELETE FROM cafeParts WHERE PART_ID LIKE 40;

DESC cafeEmployees;
SELECT * FROM cafeEmployees;

INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(100, '������', '010.1234.5678', 10, 5000000, '22/11/11', null);
INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(101, '�ڼ���', '010.1234.5678', 10, 450000, '22/11/20', 100);
INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(102, '���翵', '010.1234.5678', 20, 4500000, '22/11/20', 100);
INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(103, '�߻��', '010.1234.5678', 30, 4500000, '22/11/20', 100);
INSERT INTO cafeEmployees(employee_id, name, phone_number, part_id, salary, hire_date, manager_id) VALUES(104, '������', '010.1234.5678', 40, 4500000, '22/11/20', 100);

DESC cafeParts;
SELECT * FROM cafeParts;
INSERT INTO cafeParts(part_id, part_name, part_contact, manager_id) VALUES(10, 'Beverage', '031.000.0101', 101);
INSERT INTO cafeParts(part_id, part_name, part_contact, manager_id) VALUES(20, 'Bakery', '031.000.0102', 102);
INSERT INTO cafeParts(part_id, part_name, part_contact, manager_id) VALUES(30, 'Sandwich', '031.000.0103', 103);
INSERT INTO cafeParts(part_id, part_name, part_contact, manager_id) VALUES(40, 'Confectionery', '031.000.0104', 104);

DESC cafeMenues;
SELECT * FROM cafeMenues;
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(10, '�Ƹ޸�ī��', 'M', 4000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(10, 'ī���', 'M', 4500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(10, '�ٴҶ��', 'M', 4500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(10, 'ļ��Ḷ���ƶ�', 'M', 5000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '�����ũ������ũ', '����', 6000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '�����ũ������ũ', '1ȣ', 25000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '�����ũ������ũ', '2ȣ', 35000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '�ӹ�������ÿ', 'null', 3000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(20, '�����', 'null', 3500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(30, 'ġŲ ������ġ', 'null', 5500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(30, '���� ������ġ', 'null', 6000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(30, 'ġ�� ���̱� ������ġ', 'null', 4500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(30, '��� ũ��ġ�� ���̱�', 'null', 3500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(40, '����Ĩ ��Ű', '1��', 2000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(40, '���� ��Ű', '1��', 2000);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(40, '��ũƼ ��Ű', '1��', 2500);
INSERT INTO cafeMenues(part_id, menu_name, menu_size, price) VALUES(40, '�ӷ���Ű', '1��', 3000);

DESC cafeIngredientsOrder;
SELECT * FROM cafeIngredientsOrder;
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(101, 'ŷ�� �ɳ� ��Ÿ���� AA', '1kg', 10, 63000, 630000, '22/11/11', '�׶�λ�', '070-3454-3454', 'info@terarosa.com' );
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(101, '1883 �ٴҶ�÷�', '1000ml', 3, 13000, 39000, '22/11/11', 'Ŀ��â��', '070-4565-4565', 'info@coffeestore.com' );
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(102, '�а���', '20kg', 5, 20000, 100000, '22/11/11', '��������', '02-5740-1114', 'cjmaile.co.kr' );
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(102, '����', '10kg', 3, 10000, 30000, '22/11/11', '��������', '02-5740-1114', 'cjmaile.co.kr' );
INSERT INTO cafeIngredientsOrder(manager_id, ingredients_name, standard_size, quantity, unit_price, total_price, ordering_date, ordering_organization, ordering_contact, ordering_email) VALUES(103, '�丶��', '5kg', 1, 15000, 16000, '22/11/11', '���ϳ���', '02-5675-5675', 'fruitsland.co.kr' );


DESC cafeMachine;
SELECT * FROM cafeMachine;
INSERT INTO cafeMachine(manager_id, machine_name, machine_price, durable_years, purchasing_organization, purchasing_manager, purchasing_contact) VALUES(101, '�󸶸����� KB90', 33000000, 5, 'Ŀ��õ��', '��ƹ���', '02.443.3343');
INSERT INTO cafeMachine VALUES(102, '��ũ���� 3�� dho2-23', 7260000, 5, '�ﶯ����', '�̾ƹ���', '02.4623.6443');
INSERT INTO cafeMachine VALUES(102, '��Ƽ�ùа�����ױ�', 1480000, 5, '��������', '�־ƹ���', '02.7623.3643');

-- ���� 3 : �� ���̺� JOIN�Ͽ� ���ϴ� �����͸� ��ȸ�غ���