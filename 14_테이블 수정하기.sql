-- 14_���̺� �����ϱ�. sql

------------------------- ���� --------------------------------

/*
    # ���̺� �� �÷� �߰��ϱ�
    - ATER TABLE ���̺�� ADD (�÷��� �÷�Ÿ�� [��������], ...);
    - �� �÷��� �߰��� ���� ���� ����� �߰� �÷� ���� NULL�� �ȴ�
    - DEFAULT�� ������ ������ ���ѿ� �÷��� ���� DEFAULT�� �Ͽ� �߰��Ѵ�
*/
ALTER TABLE fruits ADD (
    grade VARCHAR2(2)
        CONSTRAINT fruit_grade_chk CHECK (regexp_like(grade, '[ABCDF]\+?')) -- grade�� ����ǥ�������� �˻縦 �ϰڴ�. (���� ����-������� �ڼ��� ����)
);

INSERT INTO fruits VALUES('apple', 13.33, 1300,'99', 'A+');
INSERT INTO fruits VALUES('apple', 13.33, 1300,'99', 'A-');
INSERT INTO fruits VALUES('banana', 12.22, 1200,'98', 'A');
-- DELETE FROM fruits WHERE country_id LIKE '%9%';


-- �� ���� 1 : fruits ���̺��� country_id�� �ùٸ� �ܷ�Ű ���������� �����غ�����
--         (countries ���̺��� ������ countries2 ���̺�� ������ ��) 
-- ����� ����
CREATE TABLE countries2 AS (SELECT * FROM countries);

-- �⺻Ű ���� : PK �Ǵ� UK���� �ܷ�Ű�� �θ�Ű ������ �� �� �ִ�.
ALTER TABLE countries2 ADD CONSTRAINT C2_id_pk PRIMARY KEY (country_id); -- �⺻Ű ���� �̸�(?)

SELECT * FROM user_constraints WHERE table_name = 'COUNTRIES2'; -- ��������(CONSTRAINT_TYPE)�� C2_ID_PK�� ���� �� �� �� ����

-- ���� country_id�� �θ� �÷��� �������� �ʴ� ���� �ڵ尡 �ֱ� ������ ���ֹ�����.
-- country_id�� '99, 98'�̶�� country_id�� ���� ������ ������ �ȵǹǷ� update �ؾ� ��
UPDATE fruits SET country_id = null;

-- �ܷ�Ű �������� �߰�
-- COUNTRY_ID�� �������� ����
ALTER TABLE fruits ADD CONSTRAINT fruit_c2_fk FOREIGN KEY (country_id)
    REFERENCES countries2 (country_id); -- ���� �߻�, country_id�� '99, 98'�̶�� country_id�� ���� ������ ������ �ȵȴ�. 
    
DESC fruits;
SELECT * FROM fruits;
SELECT * FROM user_constraints WHERE table_name = 'countries2'; -- ���� Ȯ��

-- ���� 1 : fruits ���̺��� country_id�� �ùٸ� �ܷ�Ű ���������� �����غ����� --



/*
    # ���̺� �÷� �����ϱ�
    - ALTER TABLE ���̺�� DROP COLUMN �÷���;
*/

ALTER TABLE fruits DROP COLUMN grade;


/*
    # ���̺� �÷� �̸� �����ϱ�
    - ALTER TABLE ���̺�� RENAME COLUMN �����̸� TO �ٲ��̸�;
    - ���� ���ǿ� ���� �÷��� �Բ� �ٲ��
*/

ALTER TABLE fruits RENAME COLUMN grade TO fruit_grade;
ALTER TABLE fruits RENAME COLUMN fruit_grade TO apple_grade;

SELECT * FROM fruits;
SELECT * FROM user_constraints WHERE table_name = 'FRUITS';


/*
    # ���̺��� �������� �̸� �����ϱ�
    - ALTER TABLE ���̺�� RENAME CONSTRAINT �������Ǹ� TO �ٲ��̸�;
*/
ALTER TABLE fruits RENAME CONSTRAINT fruit_grade_chk TO fruits_apple_grade_chk;

------------------------- ���� --------------------------------
/*
    # ���̺� �̸� �����ϱ�
    - RENAME ���̺�� TO �ٲ��̸�;
*/
RENAME coffees5 TO coffeesFive;
SELECT * FROM user_tables;


/*
    # �÷� �����ϱ�
    - ALTER TABLE ���̺�� MODIFY (�÷��� �÷�Ÿ�� [��������], ...);
    - �̹� �����ϴ� �÷��� ���� ���� �������� ������ �� ���
    - �÷� ũ�⸦ ������ ���� �ִ�
    - ���ο� ���� ������ ������ ���� �ִ� (������ DROP CONSTRAINT)
    - NOT NULL, CHECK, DEFAULT�� �̰��� ���� �߰��ؾ� �Ѵ�
*/

SELECT * FROM coffeesFive;
SELECT * FROM user_constraints WHERE table_name = 'COFFEESFIVE';
DESC coffeesfive;

ALTER TABLE coffeesFive MODIFY (
    coffee_id NUMBER(10),
    CONSTRAINT c5_id_pk PRIMARY KEY (coffee_id)
); -- �̹� COFFEE_ID�� PRIMARY KEY��� ���� �˷���� ������ PRIMARY KEY �ڿ� �÷����� ���� �� ���൵ �ȴ�


