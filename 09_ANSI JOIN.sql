-- 09_ANSI JOIN

/*
    # ANSI JOIN
    - ANSI (American National Standard Institute) : �̱� ���� ǥ�� ��ü
    - ANSI���� ������ JOIN ǥ�� ����
    - �ٸ� �����ͺ��̽������� ����� �� �ִ� ����
*/

-- ANSI CROSS JOIN : ��� ���� JOIN
SELECT * FROM employees CROSS JOIN departments;


-- ANSI INNER JOIN : ������ �����ϴ� �ุ �����ϴ� JOIN
-- INNER JOIN ~ ON ~
SELECT
    *
FROM
    employees e
    INNER JOIN departments d ON e.department_id = d.department_id;


-- INNER JOIN ~ USING ~ : ���� ���ǿ� ���Ǵ� �� �÷��� �̸��� ���ٸ� USING�� ����� �����ϰ� ������ �� �ִ�.
SELECT
    *
FROM
    employees e
    INNER JOIN departments d USING (department_id);

SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
         employees emp
    INNER JOIN employees mgr ON emp.manager_id = mgr.employee_id; -- �÷��� �̸��� ���� �����Ƿ� USING ��� �Ұ�



-- ANSI JOIN�� ����� Ǯ ��
-- ����1 : ��� ������� ���/�̸�/�μ����� ��ȸ
-- ����2 : job_id�� IT_PROG�� ������� �̸�/��å/�μ����� ��ȸ�غ�����
-- ����3 : Ŀ�̼��� �޴� ������� ���/�̸�/�Ҽӵ��ø� ��ȸ�غ�����


-- �ڿ��� 1 : ANSI JOIN�� ����� Ǯ �� - ��� ������� ���/�̸�/�μ����� ��ȸ�غ����� -- ����
SELECT
    employee_id,
    first_name || ' ' || last_name AS name,
    d.department_name
FROM
    employees e
    INNER JOIN departments d ON e.department_id = d.department_id;

-- ����� ����
SELECT
    employee_id,
    first_name || ' ' || last_name AS name,
    department_name
FROM
    employees
    INNER JOIN departments USING(department_id)
ORDER BY
    employee_id ASC;


-- �ڿ��� 2 : ANSI JOIN�� ����� Ǯ �� - job_id�� IT_PROG�� ������� �̸�/��å/�μ����� ��ȸ�غ����� -- ����
SELECT
    first_name || ' ' || last_name AS name,
    job_id,
    department_name
FROM
    employees e
    INNER JOIN departments d ON e.department_id = d.department_id
WHERE e.job_id LIKE 'IT_PROG';

-- ����� ����
-- �� JOIN ���ǰ� ���ϴ� ������ �����Ͽ� �� �� �ִٴ� ������ �ִ�.
SELECT
    first_name,
    job_title,
    department_name
FROM
    employees
    INNER JOIN jobs USING (job_id)
    INNER JOIN departments USING (department_id)
WHERE
    job_id = 'IT_PROG';
    
    
-- �� ���� : emplyees, departments, location�� Ȱ���Ͽ� ��å�� IT_PROG�� ������� �̸�(first_name), �μ���(department_name), ���ø�(city)�� ��ȸ�ϴ� �������� �ۼ��ϼ���
SELECT
    first_name,
    department_name,
    city
FROM
    employees
    INNER JOIN departments USING (department_id)
    INNER JOIN locations USING (location_id)
WHERE
    job_id = 'IT_PROG';
    
SELECT * FROM employees; -- job_id : IT_PROG / department_id
SELECT * FROM departments; -- department_name / department_id, location_id 
SELECT * FROM locations; -- city / location_id

SELECT * FROM employees WHERE JOB_ID = 'IT_PROG';



-- �ڿ��� 3 : Ŀ�̼��� �޴� ������� ���/�̸�/�Ҽӵ��ø� ��ȸ�غ����� -- ����
SELECT
    employee_id,
    first_name || ' ' || last_name AS name,
    city
FROM
    employees emp,
    departments dept
    INNER JOIN  locations loc USING (location_id)
WHERE
    emp.commission_pct IS NOT NULL;
    
-- ����� ����
SELECT
    employee_id,
    first_name,
    city
FROM
    employees
    INNER JOIN departments USING (department_id)
    INNER JOIN locations USING (location_id)
WHERE
    employees.commission_pct IS NOT NULL;



/*
    # ANSI OUTER JOIN : ������ �������� ���ϴ� �൵ �����ϴ� JOIN
    
    1. LEFT OUTER JOIN : ������ ���̺� (+)�� �߰��ϴ� ȿ��
    
    2. RIGHT OUTER JOIN : ���� ���̺� (+)�� �߰��ϴ� ȿ��
    
    3. FULL OUTER  JOIN : ���� ��ο� (+)�� �߰��ϴ� ȿ��
*/

SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
    employees emp
    LEFT OUTER JOIN employees mgr ON emp.manager_id = mgr.employee_id;
    
    
-- ANSI OUTER JOIN�� ����� Ǯ ��
-- ����1 : ��� ������� "�̸�/����/�Ŵ����̸�"�� ��ȸ�ϵ� �Ŵ����� ���� ����� �Բ� ��ȸ�غ�����
-- ����2 : "�μ���ȣ/�μ���/�ּ�/����"�� ��ȸ�ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�غ�����
-- ����3 : �Ҽӵ� ����� ���� �μ��� ��ȸ�غ�����
    
    
-- ���� 1  : ANSI OUTER JOIN�� ����� Ǯ�� - ��� ������� "�̸�/����/�Ŵ����̸�"�� ��ȸ�ϵ� �Ŵ����� ���� ����� �Բ� ��ȸ�غ�����
SELECT
    emp. first_name AS employee_name,
    emp.salary,
    mgr. first_name AS manager_name
FROM
    employees emp
    LEFT OUTER JOIN employees mgr ON emp.manager_id = mgr.employee_id;
    
-- ����� ����
SELECT
    e.first_name,
    e.salary,
    m.first_name AS manager_name
FROM
    employees e
    LEFT OUTER JOIN employees m ON e.manager_id = m.employee_id;
    

-- ���� 2 : ANSI OUTER JOIN�� ����� Ǯ�� - "�μ���ȣ/�μ���/�ּ�/����"�� ��ȸ�ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�غ�����
SELECT
    department_id,
    department_name,
    street_address,
    city
FROM
    departments d 
    RIGHT OUTER JOIN locations l ON d.location_id = l.location_id
ORDER BY
    department_id ASC;
    
-- ����� ����
SELECT
    department_id,
    department_name,
    street_address,
    city
FROM
    departments 
    RIGHT OUTER JOIN locations USING (location_id)
ORDER BY
    department_id ASC;


-- ���� 3 : ANSI OUTER JOIN�� ����� Ǯ�� - �Ҽӵ� ����� ���� �μ��� ��ȸ�غ�����
SELECT
    employee_id,
    d.*
FROM
    departments d 
    LEFT OUTER JOIN employees e ON d.department_id = e.department_id
WHERE
    e.employee_id IS NULL;
    
-- ����� ����
SELECT
    department_id,
    department_name
FROM
    employees
    RIGHT OUTER JOIN DEPARTMENTS USING (department_id)
WHERE
    employee_id IS NULL;    