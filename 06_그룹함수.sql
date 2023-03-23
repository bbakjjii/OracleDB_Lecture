-- 06_�׷��Լ�

/*

    # �׷� �Լ�
    
    - ���̺��� ����� Ư�� �÷� �������� �׷�ȭ�Ͽ� ����ϴ� �Լ���
    - �׷��� ������ �Ǵ� �÷��� GROUP BY���� ���� ������ �� �ִ�
    - �ش� �׷��� ����, ����, ��� ���� ���� �� �ִ�
    - �׷� �Լ��� ����� �Ϲ� �÷��� �Բ� ����� �� ����
*/


-- sum(column) : �ش� �÷��� ������ ���ϴ� �׷� �Լ� 
SELECT sum(salary) FROM employees;
SELECT job_id, sum(salary) FROM employees GROUP BY job_id; -- ��å�� ���� ����

SELECT
    decode(department_id,
        100, 'Sales',
        30, 'Purchasing',
        20, 'Marketing',
        'Not yet') AS department_name,
        SUM(salary)
    FROM
        employees
    GROUP BY
        department_id; -- �μ��� ���� ����
    

-- avg(column) : �ش� �÷��� ����� ���ϴ� �׷� �Լ�
SELECT avg(salary) FROM employees;
SELECT avg(salary) FROM employees GROUP BY phone_number; -- ��ȭ��ȣ�� �� �ٸ��� ������ �׷�ȭ �ȵ�

-- SELECT first_name, avg(salary) FROM employees GROUP BY job_id; -- ��å�� ��� ����, �׷� �Լ��� ����� �Ϲ� �÷��� �Բ� ����� �� ���� ������ ������ �̸��� ���� �� ����.
SELECT job_id, avg(salary) FROM employees GROUP BY job_id; -- ��å�� ��� ����
SELECT department_id, avg(salary) FROM employees GROUP BY department_id; -- �μ��� ��� ����


-- count(column) : �ش� �÷��� ������ ���ϴ� �׷� �Լ�
SELECT count(commission_pct) FROM employees; -- Ŀ�̼��� �޴� ����� �� �ο���
SELECT job_id, count(commission_pct) FROM employees GROUP BY job_id; -- ��å�� Ŀ�̼� �޴� ��� �ο���

-- max(column) : �ش� �÷��� ���� �� ���� ū ���� ����
SELECT max(hire_Date) FROM employees; -- ���� �ֱٿ� ���� ������ ��볯¥
SELECT job_id, max(hire_Date) FROM employees GROUP BY job_id; -- ���� �ֱٿ� ���� ��å�� ������ ��볯¥
SELECT department_id, max(hire_Date) FROM employees GROUP BY department_id; -- ���� �ֱٿ� ���� �μ��� ������ ��볯¥


-- min(column) : �ش� �÷��� ���� �� ���� ���� ���� ����
SELECT min(hire_Date) FROM employees; -- ���� �������� ���� ������ ��볯¥


-- �������� : �� ��å���� ���� �ֱٿ� ����� �Ի��� ��¥�� ���� ������ �Ի��� ��¥�� ����غ�����
SELECT job_id, max(hire_date), min(hire_date) FROM employees GROUP BY job_id;

-- �������� : �� ��å���� ��� ������ ���غ����� (���� ���� ����)
SELECT job_id, avg(salary * 12) AS ���� FROM employees GROUP BY job_id;


/*
    - �׷� �Լ��� ����� ���� ������ �����ϰ� ���� ��� WHERE���� �ƴ� HAVING���� ����ؾ� �Ѵ�
    - WHERE������ �׷� �Լ��� ������ �ʴ´�
*/
SELECT avg(salary), job_id FROM employees GROUP BY job_id WHERE avg(salary) > 10000; -- ����O
SELECT avg(salary), job_id FROM employees WHERE avg(salary) > 10000 GROUP BY job_id; -- ����O
SELECT avg(salary), job_id FROM employees GROUP BY job_id HAVING avg(salary) > 10000; -- ����X

-- WHERE���� GROUP BY�� ���̱� ���� ���� ����ȴ�
-- ex) ������ 5000�̸��� ������� ��å�� ����� 4000�̻��� ��츸 ���
SELECT avg(salary), job_id FROM employees WHERE salary < 5000 GROUP BY job_id HAVING avg(salary) >= 4000;

-- ex) ��å���� ������ 5000�̸��� ������� 10�� �̻��� ��츸 ���
SELECT count(salary), job_id FROM employees WHERE salary < 5000 GROUP BY job_id HAVING count(job_id) > 10;