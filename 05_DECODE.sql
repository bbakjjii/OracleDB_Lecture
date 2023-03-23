-- 05_DECODE

/*
    # DECODE
    - decode(column, case1, value1, case2, value2, ..., default)
    - �� ������ default�� �⺻�� ������ ��
    - switch-case�� ������
    - �ڵ� �� display name
*/

SELECT * FROM employees;
SELECT * FROM departments;

SELECT
    first_name,
    job_id,
    department_id,
    decode(department_id, 
    10, 'Administraiton', 
    20, 'Marketing',
    30, 'Purchasing',
    90, 'Excutive',
    60, 'IT',
    80, 'Sales',
    'Not yet implemented') AS department_name
FROM
    employees
ORDER BY
    department_id;
    
    
    /*
     �������� : ��å�� ���� �޿��� �λ��Ͽ� ����غ�����
     
        IT_PROG : 5% �λ�
        FI_ACCOUNT : 3% �λ�
        ��� CLERK : 2% �λ�
        
        �̸�/��å/�����޿�/�λ�ȱ޿��� ���
        ������ �޿��� before_salary��� �̸����� ���
        �λ�� �޿��� after_salary��� �̸����� ���

    */
    
    SELECT * FROM employees;
    SELECT DISTINCT job_id FROM employees WHERE job_id LIKE '%CLERK';
    
    SELECT first_name, job_id, salary AS befor_salary,
   decode(job_id, -- ��å�� ���� �޿��λ��̱� ������ salary�� �ƴ� job_id�� ���� �Ѵ�.
    'IT_PROG', salary * 1.05, 
    'FI_ACCOUNT', salary  * 1.03, 
    'PU_CLERK', salary * 1.02,
    'SH_CLERK', salary * 1.02,
    'ST_CLERK', salary * 1.02,
    salary)  AS  after_salary
    FROM employees;
    
-- ����� ����
SELECT
    first_name,
    job_id,
    salary AS befor_salary ,
    decode(job_id,
    'IT_PROG', salary * 1.05,
    'FI_ACCOUNT', salary * 1.03,
    salary) AS after_salary
FROM
    employees
WHERE
 job_id NOT LIKE '%_CLERK' -- Ŭ������ ������ ��� ����� 
 UNION -- ������
 SELECT
    first_name,
    job_id,
    salary AS before_salary,
    salary * 1.02 AS after_salary -- ������ Ŭ������ �ϰ������� 1.02�� ���Ѵ�.
FROM
    employees
WHERE
    job_id LIKE '%_CLERK';
    
    
    
    
    /*
        # CASE-END��
        
        - DECODE�� ��Ȯ�ϰ� �ش� �÷����� ��ġ�ϴ� ���� ����� �� ������
         CASE ������ ������ ����� �� �ִ�
         
        # WHEN-THEN��
        - WHEN (column) THEN (value)
        - �÷��� ���� ~ �� ��, value�� ~ �̴�.
    */
SELECT
    first_name || ' ' || last_name AS "full_name",
    job_id,
    salary       AS before_salary,
    CASE
        WHEN job_id = 'IT_PROG'    THEN
            salary * 1.05
        WHEN job_id = 'FI_ACCOUNT' THEN
            salary * 1.03
        WHEN job_id LIKE '%_CLERK' THEN
            salary * 1.02
        ELSE
            salary
    END          AS after_salary
FROM
    employees;
    