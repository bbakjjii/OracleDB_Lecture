-- 11_���̺� ����.sql

/*
    # CRUD
    - ��κ��� ���α׷��� ������ �ִ� �⺻���� ������ ó���� �ٿ� ǥ���� ��
    - Create    (���̺� ���� ����) : ����(save)�ؾ� ������ ������ �� 
    - Read      (���̺� ���� �б�)
    - Update   (���̺� ������ ����) 
    - Delete    (���̺� ������ ����)
    
    # DML (Data Manipulate Language, ������ ���۾�)
    - INSERT : ������ �߰� ���� (DBd�� Create)
    - SELECT : ������ �б� ���� (DB�� Read)
    - UPDATE : ������ ���� ���� (DB�� Update)
    - DELETE : ������ ���� ���� (DB�� Delete)
    
    # DDL (Data Definition Language, ������ ���Ǿ�)
    - ���̺�, ������, ��, �ε���, DB���� �� DB ������Ʈ�� �����ϴ� ��ɾ�
    - CREATE : DB ������Ʈ ����
    - ALTER    : DB ������Ʈ ���� (ALTER USER... )
    - DROP     : DB ������Ʈ ���� (������)
    - TRUNCATE : DB ������Ʈ ���� ����
    
    # DCL (Data Control Language, ������ �����)
    - DB ������ ������ �ο��ϰų� �����ϴ� ��ɾ�
    - GRANT    : ���� �ο�
    - REVOKE : ���� ȸ��
*/


/*
    # ���̺� �����ϱ�
    
    CREATE TABLE ���̺�� (�÷���1 �÷�Ÿ��1, �÷���2 �÷�Ÿ��2, ...);
*/

CREATE TABLE fruits (
    name VARCHAR2 (30), -- 30����
    sweet NUMBER(4, 2), -- ���� 4�ڸ�, �Ҽ��� 2��
    price NUMBER (7), -- 100���ڸ�
    country_id CHAR(2), -- ������ȣ 2����
    grade VARCHAR2(2)
);
DESC fruits;

-- Data Dictionary  : tabó�� DB�� �˾Ƽ� �����ϴ� �����Ϳ� ���� ������ (Meta Data)
SELECT * FROM tab; -- fruits ���̺��� ���Ե�
SELECT * FROM all_users; -- ��� ����ڵ��� ������


-- ���̺� ���� : DROP TABLE ���̺��;
DROP TABLE fruits;

-- DROP TABLE�� ������ ���̺��� �����뿡 ����ִ�
SHOW recyclebin; -- ������
SELECT * FROM recyclebin; -- �������� ������

-- �����뿡 �ִ� �����ߴ� ���̺� �����ϱ�
FLASHBACK TABLE fruits TO BEFORE DROP;
SELECT * FROM tab;

-- ������ ����
PURGE recyclebin;


-- ���� ���̺��� �����Ͽ� �� ���̺� �����ϱ�
CREATE TABLE employees2 AS (SELECT * FROM employees);
DESC employees2;
SELECT * FROM employees2;

INSERT INTO fruits(name, sweet, price, country_id) VALUES('grape', 10.3, 3800, 'KR');


-- ���� ���̺��� ������ �����Ͽ� �� ���̺� �����ϱ� (�ùٸ��� ��ȸ)
DROP TABLE employees3;
CREATE TABLE employees3 AS (SELECT * FROM employees WHERE first_name LIKE '%a%a'); 
-- 1 = 0�̶�� ������ ������ų �� �ִ� ���� ���� ������ �ƹ��͵� ������ �ʴ´�. ������ ���� ���̺��� ������ ����Ǿ� ������ �����ʹ� ������� �ʴ´�.
DESC employees3;
SELECT * FROM employees3;

-- ���� ���̺��� ������ �����Ͽ� �� ���̺� �����ϱ� (�Ϻη� ���� �������� ��ȸ)
DROP TABLE employees3;
CREATE TABLE employees3 AS (SELECT * FROM employees WHERE 1 = 0); 
-- 1 = 0�̶�� ������ ������ų �� �ִ� ���� ���� ������ �ƹ��͵� ������ �ʴ´�. ������ ���� ���̺��� ������ ����Ǿ� ������ �����ʹ� ������� �ʴ´�.
DESC employees3;
SELECT * FROM employees3;

-- ���� : locations�� �Ȱ��� ���¸� ���� ���̺� locations_dummby�� �����ϴ� �������� �ۼ��ϼ���. (��, locations�� �����ʹ� �������� �ʴ´�)
CREATE TABLE locations_dummy AS (SELECT * FROM locations WHERE 1 = 0);
SELECT * FROM locations_dummy;
SELECT * FROM locations;


commit;

DESC fruits;