-- 03_WHERE.sql

/*
    # SELECT �÷��� FROM ���̺�� WHERE ������;
    - SELECT�� �ڿ� WHERE���� �߰��Ͽ� �ش� ������ �����ϴ� �ุ ��ȸ�� �� �ִ�
    - ����Ŭ�� �� �����ڿ� �� �����ڸ� Ȱ���� �������� ���� �� �ִ�
    
    # �� ������
    - =                    : ������ true
    - >, <, <=, >=  : ��
    - !=                  : �ٸ��� true
    
    # �� ������
    - AND, OR, NOT
*/

-- ���� Ÿ�� ��
SELECT * FROM employees WHERE salary >= 10000;

-- ���� Ÿ�� ��
SELECT * FROM employees WHERE job_id = 'SA_MAN';
SELECT * FROM  employees WHERE job_id = 'IT_PROG';
SELECT * FROM employees WHERE last_name > 'R'; -- ���� R���� ū ��� (Ra~�� R���� ũ�� ������ ����)
SELECT * FROM employees WHERE last_name < 'E'; -- ���� E���� ���� ���

-- ��¥ Ÿ�� ��
SELECT * FROM employees WHERE hire_Date < '2005/05/05'; -- ������ڰ� 2005�� 5�� 5�� ����
SELECT * FROM employees WHERE hire_Date > '2005/05/05'; -- ������ڰ� 2005�� 5�� 5�� ����

-- AND, OR, NOT
SELECT * FROM employees WHERE job_id = 'SH_CLERK' AND salary >= 3500; 
SELECT * FROM employees WHERE (job_id = 'SH_CLERK' OR job_id = 'IT_PROG') AND salary > 4000; 

SELECT * FROM employees WHERE hire_date < '2005/01/01' AND NOT job_id = 'ST_MAN'; -- 2005�� 1�� 1�� ������ ���� ��� �� ST_MAN�� �ƴ� ���
SELECT * FROM employees WHERE hire_date < '2005/01/01' AND  job_id != 'ST_MAN'; -- 2005�� 1�� 1�� ������ ���� ��� �� ST_MAN�� �ƴ� ��� (NOT ��� != ���)


-- ���� 1 : ������ 2000���� 3000������ ������� �̸�, ����, ��å�� ��ȸ�غ�����
SELECT first_name, salary, job_id FROM employees WHERE salary >= 2000 AND salary <= 3000;

-- ���� 2 : 30, 60, 90�� �μ��� ���� ������� �̸�, ��ȭ��ȣ, �μ���ȣ�� ��ȸ�غ����� 
SELECT first_name, phone_number, department_id FROM employees WHERE department_id = 30 OR department_id = 60 OR department_id = 90;


-- null�� ũ�� �񱳰� �Ұ����ϱ� ������ �Ϲ� �����ڸ� ����ϸ� �ȵȴ�
SELECT * FROM employees WHERE commission_pct != null;

-- null���� is�� ���� ���ؾ� �Ѵ�
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;
SELECT * FROM employees WHERE NOT commission_pct IS NULL;

-- �÷��� BETWEEN A AND B : �ش� �÷� ���� A�� B������ ��� true
SELECT * FROM employees WHERE salary BETWEEN 2000 AND 3000;
SELECT * FROM employees WHERE hire_date BETWEEN '2005/01/01' AND '2005/12/31';
SELECT * FROM employees WHERE first_name BETWEEN 'D' AND 'J';


-- �÷��� IN (A, B, C, ...) : () ���� ���뿡 ���� ������ true
SELECT first_name, department_id FROM employees WHERE department_id IN (30, 60, 90);
SELECT first_name, job_id FROM employees WHERE job_id IN ('FI_ACCOUNT', 'SH_CLERK');

-- SQL������ �������� ���� �� %���� ��� MOD(a, b) �Լ��� ����ؾ� �Ѵ�.
SELECT employee_id, first_name, last_name FROM employees WHERE mod(employee_id, 2) = 0; -- ¦�� ��°�� ��ȸ 
SELECT  employee_id, first_name, last_name FROM employees WHERE mod(employee_id, 2) = 1; -- Ȧ�� ��°�� ��ȸ 


/*
    # LIKE�� ���ϵ�ī��(%, _)�� ��ȸ�ϱ�
    - �������� �Ϻκ��� ��ġ�ϴ� ������ ��ȸ�� �� �ִ�
    - % : ���� ���� ���� �ƹ� ���ڳ� �͵� �Ǵ� �ڸ�
    - _ : �ϳ��� �ƹ� ���ڰ� �;��ϴ� �ڸ�
*/
SELECT employee_id, first_name, last_name FROM employees WHERE first_name LIKE 'K%'; -- K�� �����ϴ� ��� �̸� ���
SELECT employee_id, first_name, last_name FROM employees WHERE first_name LIKE '%y'; -- y�� ������ ��� �̸� ���
SELECT employee_id, first_name, last_name FROM employees WHERE first_name LIKE '%v%'; -- �̸� �߰��� v�� ���ų� �� �ڿ� v�� ���� ��� �̸� ���
SELECT employee_id, first_name, last_name FROM employees WHERE first_name LIKE '%d%'; -- �̸� �߰��� d�� ���ų� �� �ڿ� d�� ���� ��� �̸� ���

SELECT employee_id, first_name, last_name FROM employees WHERE first_name LIKE '%t_'; -- �ڿ��� �ι�° ���ڰ� t�� ��� �̸� ���
SELECT employee_id, first_name, last_name FROM employees WHERE first_name LIKE '_a%'; -- �տ��� �ι�° ���ڰ� a�� ��� �̸� ���


-- ���� 1 : first_name�� �ڿ��� ����° ���ڰ� a�� ��� ������� Ǯ������ ��ȸ
SELECT  first_name || ' ' || last_name AS full_name FROM employees WHERE first_name LIKE '%a__';

-- ���� 2 : first_name�� e�� �� �� �̻� ���Ե� ������� ��� Ǯ������ ��ȸ
SELECT  first_name || ' ' || last_name AS full_name FROM employees WHERE first_name LIKE '%e%e%';

-- ���� 3 : first_name�� �ټ� �����̸鼭 r�� ������ ������� Ǯ������ ��ȸ
SELECT  first_name || ' ' || last_name AS full_name FROM employees WHERE first_name LIKE '____r'; 

-- ���� 4 : 8���� �Ի��� ������� �̸���, ��ȭ��ȣ, ������� ��ȸ
SELECT email, phone_number, hire_date FROM employees WHERE hire_date LIKE '%/08/%' ;


-- lower(col), upper(col) : ���޵� ���� �ҹ���(�빮��)�� �����Ѵ�
SELECT lower(first_name || ' ' || last_name) FROM employees;
SELECT upper(first_name || ' ' || last_name) FROM employees;

-- ������ ���� �ٲ��� ������ �̸��� �ҹ���(��°����� �̸��� ù������ �빮�� ����) aa�� 2�� ����
SELECT first_name, job_id FROM employees WHERE lower(first_name) LIKE '%a%a%';



