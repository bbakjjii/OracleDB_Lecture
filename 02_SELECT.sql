-- 02_SELECT.sql

/*
    # SELECT �÷��� FROM  ���̺��;
    - ���ϴ� ���̺��� ���ϴ� �÷��� ��ȸ�� �� �ִ� ������
    - �÷��� �ڸ��� *(��ǥ)�� ���� ���� ��� �÷��� �ǹ��Ѵ�
    - ���� �÷��� ��ȸ�� ���� ,(�޸�)�� ����� �����Ѵ�
    - �÷���� ���̺���� ��ҹ��ڸ� �������� �ʴ´�
    - �������� ��ҹ��ڸ� �������� �ʴ´�
    - �����ʹ� ��ҹ��ڸ� �����Ѵ�

    # HR ������ �ִ� ������ ���̺��
    - EMPLOYEES : ��� ���� ���̺�
    - DEPARTMENTS : �μ� ���� ���̺�
    - JOBS : ���� ���� ���̺�
    - LOCATIONS :  ���� ���� ���̺�
    - COUNTRIES : ���� ���� ���̺�
*/

SELECT phone_number  FROM employees; -- employees ���̺��� phone_number�� ����
SELECT employee_id, first_name, phone_number FROM employees;


-- ���� 1 : �����ϴ� ��� �μ��� �μ�ID�� �μ����� ��ȸ�غ�����
-- �ٸ� �÷��� �����ٸ� *(��ǥ)�� ����� �Ѵ�. *�� ��� �÷��� �����ִ� ���̱� ������
-- �÷��� ���̺���� �� ��� �Ʒ�ó�� �鿩���⸦ ���ش�.
SELECT 
    department_id, department_name 
FROM 
    departments;

-- ���� 2 : ��� ����� ���/�̸�/����/�����/�μ���ȣ�� ��ȸ�غ�����
SELECT 
    employee_id, 
    first_name, 
    salary, 
    hire_date, 
    department_id 
FROM employees;


/*
    # DESC ���̺��
    - �ش� ���̺��� ��� �÷� ������ �� �� �ִ� 
    - ���̺� �������� ���ø��� ������ �ƴ϶� ��ũ��Ʈ �������� �����ش�
    
     # NUMBER(n), NUMBER(n,m)
    - ���� �����͸� ������ �� �ִ� �÷� Ÿ��
    - ���ڰ� �ϳ��� ���������� ������ ���̸� ��Ÿ����
    - ���ڰ� �� �� ���������� ��ü�� ���̿� �Ҽ��� �ڸ����� ��Ÿ����    
        ex) NUMBER(8) �� ���� 8�ڸ����� ���� ������ �÷�
             NUMBER(8, 3) �� ���� �κ��� 5�ڸ�, �Ҽ� �κ��� 3�ڸ� ���� ������ �÷�
              
    # VARCHAR2(n)
    - ���� ���� ���� �����͸� ������ �� �ִ� �÷� Ÿ��
    - ����Ǵ� �������� ũ�⿡ ���� �˸��� ������ ����Ѵ�.
    - ���� ���� ������ ȿ�������� ���
    
    # CHAR(n)
    - ���� ���� ���� �����͸� ������ �� �ִ� �÷� Ÿ��
    - ������ ũ�⿡ ������ �ʰ� �׻� ������ ������ �����Ѵ�
    - �ش� �÷��� ���ݿ� ���� ���� ���� ���� ������ ���� �ִ�
        ex) COUNTRIES ���̺��� ���� �ڵ�(COUNTRY_ID) �÷� ��CHAR(2) �� KR, EU, US ��
        
    # DATE
    - ��¥ �� �ð� �����͸� ������ �� �ִ� �÷� Ÿ��
        ex) EMPLOYEES�� �������(HIRE_DATE)  �÷� �� DATE �� 03/07/17, 05/09/21 ��
     
     
*/
DESC departments;
DESC employees;
DESC countries;
DESC locations;
DESC jobs;

DESC emp_details_view;
SELECT * FROM emp_details_view;

-- DB���� ��� ���̺��� �����ش�
select * from all_tables;

-- �÷� ��ȸ�� AS�� �̿��� �÷����� ���ϴ� �̸����� �����Ͽ� ��ȸ�� �� �ִ� (���� AS �����̸�)
SELECT first_name AS �̸�, salary AS �޿� FROM employees;

-- ��ȸ ����� ��� �����ڸ� Ȱ���� �� �ִ�
SELECT
    first_name AS �̸�, 
    salary AS ����, 
    salary * 2 AS �δ�ġ, 
    salary * 5 �ټ���ġ 
FROM employees;

-- �÷����� ���굵 �����ϴ� (commission_pct�� Ȱ���� ���ʽ� �޿� ���)
-- �ڵ� �� ���� : ��� ���� �� ���콺 ��Ŭ��(��� ���� �� �ϸ� ��ü ���� �ڵ� �ٸ��� ��) �� [����] Ŭ�� �Ǵ� Ctrl + F7
SELECT
    first_name,
    salary,
    commission_pct,
    salary * commission_pct AS ���ʽ�,
    salary + nvl(salary * commission_pct, 0 ) As "���ʽ� + �޿�"   -- �ֵ���ǥ("")�� ���̸� escape ������ �ִ�.
    -- nvl() �Լ� : ���⿡ �ִ� ���� null �� �� ��� '0'�� ���ڴ�. 
FROM
    employees;
    
    /*
    # nvl(column, value)
    - ��꿡 ����ϴ� �÷��� null���� �ִ� ��� null��� ����� ���� �����ϴ� �Լ� 
    - �������� �����Ϳ� null���� �����ϸ� ����� ������ null�� �ȴ�
    */
    
-- ���� 1 : ��� ������� '���/��ü�̸�/��å/����/���ʽ� ����� ����'�� ��ȸ�غ�����
SELECT
    employee_id,
    first_name || ' ' || last_name AS full_name,
    job_id,
    salary * 12 AS ����,
    salary *  ( nvl (commission_pct, 0)  + 1) * 12 AS "���ʽ� ����� ����"
FROM
    employees;
-- �÷��� ���� ������ : ||
-- ����(����) : ' '

-- SELECT DISTINCT : �� �����͸� �� ������ ����Ѵ� (�ߺ� ����)
SELECT DISTINCT department_id FROM employees; -- �����ϴ� �μ����� �ѹ��� ���
SELECT DISTINCT job_id FROM employees; -- �����ϴ� ��å�� �ѹ����� ���
SELECT DISTINCT first_name FROM employees; -- ��ġ�� �̸��� �ѹ����� ���
