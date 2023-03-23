-- 10_���� ����

/*
    # ���� ����
    - �ϳ��� SELECT�� ���ο� ���Ե� �� �ϳ��� SELECT��
    - ���� ������ �����ϰ� �ִ� ������ ���� ������� �Ѵ�
    - ���� ����� ���� ���� �� ���� ������ ���� �� ���� ������ �з��Ѵ�
    
    # ���� �� ���� ����
    - ���� ������ ����� �ϳ��� ���� ���� ����
    - ���� ������ ���ϴ� �Ϲ� �����ڸ� ����� �� �ִ�(=, >, <, ...)
    
    # ���� �� ���� ����
    - ���� ������ ����� 2�� �̻��� ���� ����
    - ���� �� �����ڿ� �Բ� ����ؾ� �Ѵ� (IN, ANY, SOME, ALL, EXISTS, ...)
*/


-- ���� �� ���� ����
-- ex) 150���� ����� �޿�(10000) ���� �޿��� ���� ����� �����´�.

SELECT salary FROM employees WHERE employee_id = 150;

SELECT
    *
FROM
    employees
WHERE
    salary >= (SELECT salary FROM employees WHERE employee_id = 150); ----- ???????????????????????




-- ���� �� ���� ����
-- IN : ���� �� ���� ������ ��� �� ��ġ�ϴ� ���� �ϳ��� ������ true
-- ex) ��å���� SA_REP�� ����� last_name�� �ϳ��� ��ġ�� true

SELECT last_name FROM employees WHERE job_id = 'SA_REP';

SELECT
    *
FROM
    employees
WHERE
    last_name IN (SELECT last_name FROM employees WHERE job_id = 'SA_REP');
    



-- ANY, SOME : ���� �� ���� ������ ���� ���� �� �ϳ� �̻��� ������Ű�� true
-- ex) IT_PROG�� �� ���� �� ���� ������� ���� ���� ������� ��ȸ (4200 �̻��� ���� ��Ű�� true)

SELECT salary FROM employees WHERE job_id = 'IT_PROG';

SELECT 
    *
FROM
    employees
WHERE
    salary > ANY(SELECT salary FROM employees WHERE job_id = 'IT_PROG'); 




-- ALL : ���� �� ���� ������ ��ȸ�� ��� ����� �������Ѿ� true
--  ex) IT_PROG�� �� ���� �� ���� ������� ���� ���� ������� ��ȸ

SELECT salary FROM employees WHERE job_id = 'IT_PROG';

SELECT 
    *
FROM
    employees
WHERE
    salary > ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG'); 



-- EXIST : ���� ������ ����� �����ϸ� true

SELECT * FROM locations; -- location_id�� 23�� ����
SELECT * FROM departments;

-- ex) departments�� manager_id�� �����ϴ� ���ø� ���� ���� ��
SELECT city FROM locations l WHERE -- location�� 23�� ����(for���̶� ���)
EXISTS (SELECT manager_id FROM departments d WHERE l.location_id = d.location_id); -- manager_id�� �����ϴ� ���� �� ��


-- �� ���� 1 : job_title�� Manager�� ���ԵǴ� ��� ������� ��ȭ��ȣ�� ��ȸ -- ����
-- ����� ����

SELECT job_id, job_title FROM jobs WHERE job_title LIKE '%Manager%';

SELECT * FROM employees WHERE job_id IN
(SELECT job_id FROM jobs WHERE job_title LIKE '%Manager%');


-- �� ���� 2 : �Ҽӵ� ����� �������� �ʴ� �μ��� ��� ������ ��ȸ -- ����
-- ����� ����
SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL; -- ������� ���� �ִ� �μ���ȣ�� �� ����

SELECT * FROM departments WHERE department_id NOT IN
(SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL); -- ������� ���� �ִ� �μ���ȣ�� �� ����






-- �߰� ����
-- 1.employees�� ������ �������� ���ϴ� ��� (��ġ�ϴ� ���� ����,  null�̴�, ...)
-- 2. departmnets�� ������ �������� ���ϴ� ���
-- (+)�� �� ���� ���� ����ʹٴ� �ǹ�
SELECT * FROM employees RIGHT OUTER JOIN departments USING (department_id);