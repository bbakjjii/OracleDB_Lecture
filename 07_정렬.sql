-- 07_����.sql

/*
    # ORER BY
    
    - ���ϴ� �÷� �������� �����Ͽ� ��ȸ�ϴ� ����
    - ORDER BY �÷��� [ASC|DESC]
    - ASC : �������� (Ascending)
    - DESC : �������� (Descending)
*/

-- DESC : ��������
SELECT * FROM employees ORDER BY hire_date DESC; -- ���� �ֱٿ� ���� ��� > ���� �������� ���� ��� ������ ���ĵ�
SELECT * FROM employees ORDER BY salary DESC; -- ���� ������ ���� ��� > ������� ������ ���ĵ�

-- ASC : ��������, ���� ����
SELECT * FROM employees ORDER BY salary ASC; -- ������ ���� ���� ��� > ���� ��� ������ ����
SELECT * FROM employees ORDER BY salary; -- ������ ���� ���� ��� > ���� ��� ������ ����

-- null�� �������� �������� ���� ���� �����Ѵ� (null�� ���� ũ��)
SELECT * FROM employees ORDER BY commission_pct DESC; -- null > ���� ��� > ���� ��� ����

-- null �������� �������� ���� ���߿� �����Ѵ�
SELECT * FROM employees ORDER BY commission_pct ASC; -- ���� ��� > ���� ��� > null ����

-- ���� ������ ������ ������ ���� �ִ�
-- ex) ��å �������� �������� �����ϵ� ���� ��å�� ��� �����ȣ ���� �������� ����
SELECT employee_id, first_name, salary, job_id FROM employees ORDER BY job_id, employee_id;

-- ex) ��å �������� �������� �����ϵ� ���� ��å�� ��� �����ȣ �������� �������� ����(ASC�� ���� ����)
SELECT employee_id, first_name, salary, job_id FROM employees ORDER BY job_id DESC, employee_id ASC;


-- ���� 1 : �̸��� i�� ���ԵǾ� �ִ� ������� �� ���� �޴� ������� ��ȸ (�̸��� i�� �����ϴ� ����� ����)
SELECT * FROM employees WHERE first_name LIKE 'I%' OR first_name LIKE '%i%' ORDER BY salary DESC;
SELECT first_name FROM employees WHERE first_name LIKE '%i%' OR first_name LIKE 'I%' ORDER BY salary DESC; -- ����� ��� 1.
SELECT first_name FROM employees WHERE lower(first_name) LIKE '%i%' ORDER BY salary DESC; -- ����� ��� 2.


-- ���� 2 : ��� ������� last_name �������� �������� ����, ���� last_name�� ��� first_name���� �������� ����
SELECT * FROM employees ORDER BY last_name ASC, first_name ASC; 
SELECT last_name, first_name FROM employees ORDER BY last_name ASC, first_name ASC; -- ����� ���

-- ex) ������ 3000���ϸ鼭, �ο��� 10�� �̻��� ��å
SELECT job_id, count(salary) FROM employees WHERE salary <= 3000 GROUP BY job_id HAVING count(salary) >= 10;

