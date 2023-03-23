-- 16_����ȭ.sql
/*
    # ����ȭ (Normalization)
    - �ʿ��� �����͵��� �����ͺ��̽��� ������ ������ ��ȯ�ϴ� ����
    - ����ȭ�� ���� ���� �����͵��� �̻������� ����Ų��
    
    
    # �� 1������ (1NF, Normarlization Form)
    - �� �÷��� �ϳ��� ���� ������ �Ѵ�
    - �ϳ��� �÷� �����͵��� ���� Ÿ���� ������ �Ѵ� (������ ���Ἲ)
    - �� �÷��� �����ϰ� ������ �� �־�� �Ѵ�
    - �÷��� ������ �������� �Ѵ�
    
    # 1NF�� ������Ű�� ���� ����
    Ŀ�� ���̺�
        
    Ŀ���̸�    / Ŀ�ǰ��� / Ŀ��ũ�� / Ŀ�ǿµ�
    ------------------------------------------------------
    �Ƹ޸�ī��   8000        T,G,V              H,I
        
     # 1NF�� ������Ų ���� (ver.1)
     Ŀ�� ���� ���̺�
     --------------------------------
     �Ƹ޸�ī��   8000
     ī���       7000
     
     Ŀ�Ǻ� �� ������ ���̺�
     --------------------------------
     �Ƹ޸�ī��  Tall
     �Ƹ޸�ī��  Grande
     �Ƹ޸�ī��  Venti
     ī���      Tall
     ī���      Venti
     
     Ŀ�Ǻ� ���� �µ� ���̺�
     --------------------------------
     �Ƹ޸�ī�� Hot
     �Ƹ޸�ī�� Ice
     
     
     # 1NF�� ������Ų ���� (ver.2)
     Ŀ���̸�    / Ŀ�ǰ��� / Tall / Grande / Venti / Hot / Ice
        ---------------------------------------------------------------------
        �Ƹ޸�ī��   8000      O         O           O           O       O
        ī���       7000      O         O           X           O       O
        
        
    # �� 2������ ������ ���������� �ñ��ϴٸ� ���ͳ� �˻��� ���� �ذ��սô�
        (������ ���������� �ذ� �˴ϴ�)
  
    # 1:N ���� �ذ� ���
    - �� ��ü���� 1:N ������ ��� �ܷ�Ű�� ���� ���� ������ ���ָ� �ȴ�
    - 1:N ����� ������ �����ͺ��̽������� ���� �ٶ����� ������ �� �� �ִ�
        
    # N:N ���� �ذ� ���
    1. N:N ������ ��ü ���̿� ���̺��� �ϳ� �߰��� �� ���� 1:N ����� ���� �� �ִ�
    - ������ ���� ������ ������ �� �ִ� (������ �ߺ��� �ּ�ȭ)
    - ��ȸ �� ������ ���� �߻��ϱ� ������ ��ȸ�� ������ ����� �ִ�
    
    ex) ��ȭ��
          * ��ȭ ����
         movie_id(PK) | movie_name | director | grade
         
         * ȸ�� ��ȭ ���� ����
        member_id(FK) | movie_id(FK)
    
         * ��ȭ ������ ���� (ȸ��)
        member_id(PK) | member_name | age | join_date |  �ô� ��ȭ(FK)
        
    2. �� ���� ���̺��� �ϳ��� ��ģ��
    - ������ ���� ������ �����ϰ� �ȴ� (�ߺ� �����Ͱ� �þ��)
    - ��� ��ȸ �ӵ��� �ſ� ������
    
     id(PK) | movie_name | ... | member_id | member_name | ...
*/


/*
    �� �ٴ�� ������ �� ��ƼƼ�� �����غ��� 1�� ������� ���̺��� �����Ͽ� �����غ�����
    ������
    
    ������
    zookeeper_id | zkp_name | field_id | department_name
    1001                         ������          1         �뵿��
    1002                         ������          2         �뵿��
    1003                        �̱���           3         �뵿��
    1004                        ���ҹ�           4        �ҵ���
    1005                        ���缮           5         �������
    1006                        �ϵ���           6         ����Ƹ���
    
    
    ������
    zookeepr_id | animal_id
    1001                10
    1002                11
    1003                30
    1004                40
    1005                50
    1006                60
    
    
     ����
    animal_id | ani_species | ani_name | ani_age | ani_classification | field_id
    10                 �ڳ���                  �ڼ���              5                   ������                    1
    11                 �ڳ���                  �ڵ���              4                   ������                    1
    20                 ȣ����                  ȣġ                   2                   ������                    2
    30                 �⸰                      ������              8                   ������                    3
    40                 �䳢                      ���ʹ�              1                     ������                   4
    50                 �޶ѱ�                 �޵λ�               2                     �����                 5
    60                 ����                   ����                10                     ������                 6 
    70                �ݴް�����           �۰�                3����             ������                     7
    
    
   �츮 ���
  field_id(FK) | zookeeper_id(FK)
    
    �츮
    field_id | field_name |
    1                �뵿����A                            
    2                �뵿����B
    3               �뵿����C
    4               �ҵ�����
    5               �������
    6              ����Ƹ���
    7              �����
    
    �츮 �Ҽ�
    field_id | animal_id  
    1                   10
    1                   11
    2                   20
    3                   30
    4                   40
    5                   50
    6                   60 
*/


CREATE TABLE zookeepers (
     zookeeper_id NUMBER(4)
        CONSTRAINT zookeeper_id_pk PRIMARY KEY
        CONSTRAINT zookeeper_id_nn NOT NULL,
     zkp_name VARCHAR2 (10),
     field_id NUMBER(3)
        CONSTRAINT fieldz_id_nn NOT NULL,
     department_name VARCHAR2 (30)
);


CREATE TABLE manageAnimals (
    zookeeper_id NUMBER(4)
         CONSTRAINT zkp_id_fk REFERENCES zookeepers (zookeeper_id),
      animal_id NUMBER(4)
        CONSTRAINT animal_id_fk REFERENCES animals (animal_id)
);
SELECT * FROM manageAnimals;


CREATE TABLE animals (
     animal_id NUMBER(4)
        CONSTRAINT animal_id_nn NOT NULL
        CONSTRAINT animal_id_pk PRIMARY KEY,
     ani_species VARCHAR2 (50),
     ani_name   VARCHAR2 (10) DEFAULT 'null',
     ani_age CHAR(10)
        CONSTRAINT ani_age_nn NOT NULL,
     ani_classification VARCHAR2 (10)
         CONSTRAINT ani_classification_nn NOT NULL,
    field_id NUMBER(3)
        CONSTRAINT fielda_id_nn NOT NULL
);
        
CREATE TABLE animalsFields (
    field_id NUMBER(3)
        CONSTRAINT field_id_nn NOT NULL
        CONSTRAINT field_id_pk PRIMARY KEY,
     field_name VARCHAR2 (30) DEFAULT 'null'
);


INSERT INTO zookeepers( zookeeper_id, zkp_name, field_id, department_name) VALUES(1001, '������', 1, '�뵿��');
INSERT INTO zookeepers VALUES(1002, '������', 2, '�뵿��');
INSERT INTO zookeepers VALUES(1003, '�̱���', 3, '�뵿��');
INSERT INTO zookeepers VALUES(1004, '���ҹ�', 4, '�ҵ���');
INSERT INTO zookeepers VALUES(1005, '���缮', 5, '�������');
INSERT INTO zookeepers VALUES(1006, '�ϵ���', 6, '����Ƹ���');
INSERT INTO zookeepers VALUES(1007, '������', 4, '�ҵ���');

INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1001,10);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1001,11);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1002,20);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1003,20);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1007,70);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1007,71);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1007,72);


INSERT INTO animals( animal_id, ani_species, ani_name, ani_age, ani_classification, field_id) VALUES(10, '�ڳ���', '�ڼ���', '5��', '������', 1);
INSERT INTO animals VALUES(11, '�ڳ���', '�ڵ���', '4��', '������', 1);
INSERT INTO animals VALUES(20, 'ȣ����', 'ȣġ', '4��', '������', 1);
INSERT INTO animals VALUES(30, '�⸰', '������', '8��', '������', 2);
INSERT INTO animals VALUES(30, '�⸰', '������', '8��', '������', 2);
INSERT INTO animals VALUES(40, '�䳢', '���ʹ�', '1��', '������', 4);
INSERT INTO animals VALUES(50, '�޶ѱ�', '�޵λ�', '2��', '�����', 5);
INSERT INTO animals VALUES(51, '�޶ѱ�', '�޸�', '2��', '�����', 5);
INSERT INTO animals VALUES(60, '����', '����', '10��', '������', 6);
INSERT INTO animals VALUES(61, '����', '�Ϸη�', '8��', '������', 6);
INSERT INTO animals VALUES(70, '�ݴް�����', '�۰�', '3����', '������', 7);
INSERT INTO animals VALUES(71, '�ݴް�����', '����', '2����', '������', 7);
INSERT INTO animals VALUES(72, '�ݴް�����', '����', '2����', '������', 7);


INSERT INTO animalsFields(field_id, field_name) VALUES (1, '�뵿����A');
INSERT INTO animalsFields(field_id, field_name) VALUES (2, '�뵿����B');
INSERT INTO animalsFields(field_id, field_name) VALUES (3, '�뵿����C');
INSERT INTO animalsFields(field_id, field_name) VALUES (4, '�ҵ�����');
INSERT INTO animalsFields(field_id, field_name) VALUES (5, '�������');
INSERT INTO animalsFields(field_id, field_name) VALUES (6, '����Ƹ���');
INSERT INTO animalsFields(field_id, field_name) VALUES (7, '�����');


SELECT * FROM zookeepers;
SELECT * FROM animals;
SELECT * FROM animalsFields;


-- ������ + ��絿�� + ����
SELECT
    z.zookeeper_id,
    z.zkp_name,
    a.ani_name
FROM
    zookeepers z,
    animals a
WHERE
   z.animal_id = a.animal_id;
   
   
-- ���� + ��籸��
SELECT
    f.field_name,
    a.ani_name
FROM
    animals a,
    animalsfields f
WHERE
    a.field_id = f.field_id;
    

SELECT
    zkp_name,
    animal_id,
    ani_name
FROM
    manageAnimals
    INNER JOIN zookeepers USING (zookeeper_id)
    INNER JOIN animals USING (animal_id);