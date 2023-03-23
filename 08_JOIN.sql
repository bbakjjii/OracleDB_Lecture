-- 08_JOIN.sql �� �ϱ� ��

/*
    # �⺻Ű (Primary Key, PK)
    - �� ���̺��� �ϳ��� ���� �����ϰ� ������ �� �ִ� �÷�
        ex) ��ȭ��ȣ, �ֹε�Ϲ�ȣ, �̸���, �����ȣ ��
    - �� ���̺� �⺻Ű�� �ϳ��ۿ� ������ �� ����
    - �⺻Ű�� ������ �÷����� �ߺ����� ���� �� ���� (UNIQUE)
    - �⺻Ű�� ������ �÷����� NULL���� ���� �� ���� (NOT NULL)
    
    
    # �ĺ�Ű (Candidate Key)
    - �⺻Ű�� �� �ڰ��� ���߾����� �⺻Ű�� ���������� ���� �÷�
    
    # �ܷ�Ű (Foreign Key, FK)
    - �ٸ� ���̺����� �⺻Ű(�Ǵ� �ĺ�Ű)���� �ش� ���̺����� �ߺ��Ǵ� ���� �÷�
        ex) employees�� department_id�� �ܷ�Ű
             departments�� department_id�� �⺻Ű
    - � ���̺��� �⺻Ű(�Ǵ� �ĺ�Ű)�� �ش� ���̺��� �ܷ�Ű�� �����Ǹ� �� ���̺����� 1:N ���谡 �����Ǿ��ٰ� �� �� �ִ�
        ex) �μ� 1 : ��� N(�ܷ�Ű�� ��� �ִ� ��)
        
    # ��ü �� ������ ����
    - 1:1 ���� : ���� ���̺� �ȿ� ������ ��
    - 1:N ���� : �μ� - ���, �귣�� - ü����, �Խñ� - ���, ȸ�� - �Խñ�  
    - N:N ���� : �ڻ� - ����(��������), ����(���� ����) - ����(���� ����)
    
    # ���̺� ���� JOIN
    - �⺻Ű�� �ܷ�Ű�� ���谡 �����Ǿ� �ִ� ��� ���̺��� ������ �����Ͽ� ��ȸ�ϴ� ��
    - CROSS JOIN
    - EQUI JOIN
    - SELF JOIN
    - ���
*/

SELECT * FROM employees;
SELECT * FROM departments;

/*
    # CROSS JOIN
    - ���ο� ���Ǵ� ���̺���� �����͸� �����Ͽ� ���� �� �ִ� ��� ��츦 ����ϴ� JOIN
    - �׳� ��� ���� ������� �����ϴ� �������� ����
*/
SELECT * FROM employees; -- 107 rows
SELECT * FROM departments; -- 27 rows
SELECT * FROM employees, departments; -- 10���� �μ��� ��� ����� ���Ѵ�. (��� ��츦 �Ѵ�) -- 107 * 27 = 2889 rows

-- CROSS JOIN : �ǹ̾��� ��� ���� : 10�� �μ��� ��� ��� �ٿ�����, 20�� �μ��� ��� ��� �ٿ�����... ���� ���� ����..
SELECT
    employee_id,
    first_name,
    employees.department_id, -- ���̺��.�÷� : �� ���̺� �̸��� ��ġ�� �÷��� �ִ� ��� ����. ��� ���̺��� ������ Ȯ���ϰ� ��������� �Ѵ�.
    departments.department_id, -- ���̺��.�÷� : �� ���̺� �̸��� ��ġ�� �÷��� �ִ� ��� ����. ��� ���̺��� ������ Ȯ���ϰ� ��������� �Ѵ�.
    department_name
FROM
    employees,
    departments;
    
    
    /*
        # EQUI JOIN (���� ����)
        
        - �� ���̺��� ���� ������ ���� ���� �÷�(�ַ� �⺻Ű�� �ܷ�Ű)�� �̿��Ͽ� CROSS JOIN���κ��� �ǹ��ִ� �����͸� �ɷ����� JOIN
        - �� ���̺��� ���� �̸��� ���� �÷��� �ִ� ��� ���̺���� �̿��� ��������� �Ѵ�.
    */
    
SELECT
    employee_id,
    first_name,
    job_id,
    employees.department_id,
    departments.department_id,
    department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;
    
SELECT * FROM employees; -- employee_id, first_name, last_name, email, phone_number, hire_id, job_id, salary, commission_pct, manager_id, department_id
SELECT * FROM departments; -- department_id, department_name, manager_id, location_id
SELECT * FROM jobs; -- job_id, job_title, min_salary, max_salary
SELECT * FROM locations; -- location_id, street_address, postal_code, city, state_province, country_id
SELECT * FROM countries; -- country_id, country_name, region_id


-- ���� 1 : ��� ������� ���/�̸�/�μ����� ��ȸ�غ�����
-- SELECT * FROM employees; -- employee_id, first_name, last_name, email, phone_number, hire_id, job_id, salary, commission_pct, [manager_id], [department_id]
-- SELECT * FROM departments; -- [department_id], department_name, [manager_id], location_id
SELECT
    employee_id, 
    first_name,
    departments.department_name
FROM
    employees,
    departments
WHERE employees.department_id = departments.department_id;

-- ����� ����
SELECT 
    employee_id, 
    first_name,
    department_name
FROM
    employees, departments
WHERE
    employees.department_id = departments.department_id
ORDER BY
    employee_id;


-- ���� 2 : job_id�� IT_PROG�� ������� �̸�/��å/�μ����� ��ȸ�غ�����
-- SELECT * FROM employees; -- employee_id, first_name, last_name, email, phone_number, hire_id, job_id, salary, commission_pct, [manager_id], [department_id]
-- SELECT * FROM departments; -- [department_id], department_name, [manager_id], location_id
SELECT
    first_name,
    job_id,
    departments.department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id AND job_id = 'IT_PROG';

-- ����� ����
SELECT
    first_name, 
    job_id, 
    department_name
FROM
    employees emp, -- emp : ���� ���� ����
    departments dept -- dept : ���� ���� ����
WHERE
    emp.department_id = dept.department_id
    AND job_id = 'IT_PROG';
    
    
-- ���� 3 : Ŀ�̼��� �޴� ������� ���/�̸�/�Ҽӵ��ø� ��ȸ�غ�����
-- SELECT * FROM employees; -- employee_id, first_name, last_name, email, phone_number, hire_id, job_id, salary, commission_pct, manager_id, department_id
-- SELECT * FROM departments; -- department_id, department_name, manager_id, location_id
-- SELECT * FROM locations; -- location_id, street_address, postal_code, city, state_province, country_id
SELECT
    employee_id,
    first_name,
    locations.city
FROM
    employees,
    departments,
    locations
WHERE
    employees.department_id = departments.department_id AND departments.location_id = locations.location_id
    AND commission_pct IS NOT null;
    
-- ����� ����
SELECT
    employee_id,
    first_name,
    city
FROM
    employees emp, departments dept, locations loc
WHERE
    commission_pct IS NOT NULL
    AND emp.department_id = dept.department_id
    AND dept.location_id = loc.location_id;


-- ���� 4 : Seattle���� �ٹ��ϴ� ������� �̸�/��å��(job_title)/�޿�/�Ҽӵ��ø� ��ȸ�غ�����
-- SELECT * FROM employees; -- employee_id, first_name, last_name, email, phone_number, hire_id,[ job_id], salary, commission_pct, manager_id, [department_id]
-- SELECT * FROM jobs; -- [job_id], job_title, min_salary, max_salary
-- SELECT * FROM departments; -- [department_id], department_name, manager_id, [location_id]
-- SELECT * FROM locations; -- [location_id], street_address, postal_code, city, state_province, country_id
SELECT
    first_name,
    job_title,
    salary,
    city
FROM 
    employees,
    departments,
    jobs,
    locations
WHERE 
    employees.job_id = jobs.job_id 
    AND employees.department_id = departments.department_id
    AND departments.location_id = locations.location_id
    AND  locations.city = 'Seattle';

-- ����� ����
SELECT
    first_name, job_title, salary, city
FROM
    employees e, jobs j, departments d, locations l
WHERE
    e.job_id = j.job_id
    AND e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND city = 'Seattle';
    
    
-- �� EMP_DETAILS_VIEW ���� 0��
-- EMP_DETAILS_VIEW : ���̺��� �ƴ϶� �̸� ������ �� �س��� ��
SELECT * FROM emp_details_view;
SELECT * FROM user_views;




/*
    # SELF JOIN
    
    - �ϳ��� ���̺����� �ڱ� �ڽŰ� JOIN�Ͽ� ���ϴ� �����͸� ���� ���
    - �ش� ���̺��� �⺻Ű�� �ٸ� �÷����� �ܷ�Ű�� ����ϴ� ���
        ex) employees�� manager_id,  ȸ������ ���̺��� ��õ��
*/

-- �ڽ��� ���� ����� manager ID
SELECT
    e1.employee_id,
    e1. first_name AS "�����",
    e1.manager_id AS "�Ŵ��� ID",
    e2.employee_id AS "�Ŵ��� ���� ID",
    e2.first_name || ' ' || e2.last_name AS "�Ŵ��� �̸�"
FROM
    employees e1, employees e2 -- �ڱ� �ڽ��� ���̺��� 2���� ����� SELF JOIN ��  --  e1 : ����, e2 : �Ŵ�����
WHERE
    e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id; 

 -- �� �ٽ� ���� �غ��� ��       
-- ���� 1 : �Ŵ����� first_name�� e�� ���ԵǴ� ��� ������� "���/�̸�/��å��/�Ŵ����̸�"�� ��ȸ
SELECT
    e1.employee_id,
    e1.first_name,
    job_title,
    e2.first_name
FROM
    employees e1, employees e2, jobs
WHERE
    e1.manager_id = e2.employee_id
    AND e1.job_id = jobs.job_id
    AND e2.first_name LIKE '%e%'
ORDER BY
    e1.employee_id;
    
    -- ����� ����
SELECT
    emp.employee_id,
    emp.first_name,
    job_title,
    mgr.first_name AS manager_name
FROM
    employees emp,
    employees mgr,
    jobs j
WHERE
    emp.manager_id = mgr.employee_id
    AND emp.job_id = j.job_id
    AND lower(mgr.first_name) LIKE '%e%'
ORDER BY
    emp.employee_id;


-- �� �ٽ� ���� �غ��� ��
-- ���� 2 : first_name�� Curtis�� ����� ������ �μ��� ������� ���� ������ �̿��Ͽ� ��� ��ȸ 
SELECT
    e2.employee_id,
    e2.first_name,
    e2.last_name,
    d.department_name
FROM
    employees e1, employees e2, departments d -- e1: first_name = Curtis, e2 : ������ ������
WHERE
    e1.department_id = e2.department_id
    AND e2.department_id = d.department_id
    AND e1.first_name = 'Curtis'
ORDER BY
    e2.employee_id;
    
    -- ����� ����
SELECT 
    e2.* -- e2�� ��� �� ��ȸ
FROM
    employees e1, 
    employees e2
WHERE
    e1.first_name = 'Curtis'
    AND e1.department_id = e2.department_id
    AND e2.first_name <> 'Curtis' -- <> : Curtis ���� ��� ������ ��ȸ��
ORDER BY
    e2.employee_id; -- e1.employee_id : Curtis�� ��ȸ��
    
    
/*
    # ��������
    
(1) 1:N ����� ������ �� �ִ� ���� ��ʵ��� �����غ�����.
ī�� - �������, ��ü�޴�, ����, ���

(2) 1:N ����� ������ �� ��ü�� ���̺� ���·� �����غ����� (���̺��, �÷���, �� �÷� Ÿ��..)

<< ������� >>
[�⺻Ű] �����ȣ  (NOT NULL NUMBER)
                �̸�          (VARCHAR2)
                ����ó      (VARCHAR2)
[�ܷ�Ű] ��Ʈ��        (VARCHAR2) 
                ����           (NOT NULL VARCHAR2)
                �޿�           (NUMBER)
                �������   (NOT NULL DATE)
[�ܷ�Ű] �����ڹ�ȣ (NUMBER)  


<< ��ü �޴� >>
[�ܷ�Ű] ��Ʈ��           (NUMBER)  -- ī�װ��� �����°� ����
[�⺻Ű] �޴���           (VARCHAR2)
               �뷮                
               ����                (NUMBER)


<< ����� �� �Ҹ�ǰ ���� >>
[�ܷ�Ű] �����ڹ�ȣ  (NUMBER)
                �����̵�
[�⺻Ű] ����           (VARCHAR2) -- ��� �̸��� ��ġ�� ��찡 ������ ��� ���̵�� �⺻Ű �ϴ°� ����
                ������          (NOT NULL CHAR)
                �԰�
                ����               (NUMBER)
                ���簡��       (NUMBER)
                �Ѿ�               (NUMBER)
 [�ܷ�Ű]  ������(�����ȣ) 
                ���ֳ�¥       (NOT NULL DATE)
                ����ó��        (VARCHAR2)
                ���� ����ó   (VARCHAR2)
                ���� �̸���   (NOT NULL VARCHAR2) 


<< ��� >>
[�ܷ�Ű] �����ڹ�ȣ (NUMBER)
[�⺻Ű] ����         (VARCHAR2)
                ����            (NUMBER)
                ��������    (NOT NULL DATE)
                ���뿬��    (NUMBER)
                ����ó        (VARCHAR2)
                A/S ����� (VARCHAR2)
                A/S ����ó (VARCHAR2)
                
<< �μ� >>
[�⺻Ű] �μ���
                �����ڹ�ȣ

(3) � �÷��� �⺻Ű�� �ܷ�Ű ������ ���� �����غ�����

*/




/*
    # OUTER JOIN
    - JOIN ������ �������� ���� �������� ���ϴ� ���� Ȯ���� �� �ִ� JOIN
    - (+)�� ���� �ʿ� null�� �߰��ؼ� �������� ���ߴ� ����� Ȯ���� �� �ִ�
    
*/

SELECT count(*) FROM employees;
SELECT count(department_id) FROM employees;
SELECT count(manager_id) FROM employees;

-- Kimberely�� �Ҵ�� �μ��� ��� �μ�ID�� Ȱ���� JOIN ������ �������� ���Ͽ� �������� ���Ѵ�
SELECT 
    first_name, 
    email,
    e.department_id,
    d.department_id,
    department_name,
    location_id
FROM
    employees e,
    departments d
WHERE
    e.department_id(+) = d.department_id;
-- e.department(+) : employee �ʿ� null���� ���� �� : �Ҽӵ� ����� ���� �μ��� ��ȸ
-- d.department(+) : departments�ʿ� null���� ���� �� : �Ҽӵ� �μ��� ���� ����� ��ȸ

SELECT * FROM employees WHERE department_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NULL;


-- �� ���� 1 : ��� ������� "�̸�/����/�Ŵ����̸�"�� ��ȸ�ϵ� �Ŵ����� ���� ����� �Բ� ��ȸ�غ����� -- ����
-- ����� ����
SELECT
    emp.first_name,
    emp.salary,
    mgr.first_name AS manager_name
FROM
    employees emp,
    employees mgr
WHERE
    emp.manager_id = mgr.employee_id(+);

-- ���� 2 : "�μ���ȣ/�μ���/�ּ�/����"�� ��ȸ�ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�غ�����
SELECT 
    department_id, 
    department_name, 
    street_address, 
    city
FROM
    departments d,
    locations l
WHERE
    d.location_id(+) = l.location_id
ORDER BY
    d.department_id;
    
-- ����� ����
SELECT
    department_id,
    department_name,
    street_address,
    city
FROM 
    departments dept,
    locations loc
WHERE
    dept.location_id(+) = loc.location_id
ORDER BY
    department_id;

-- �ڿ��� 3 : �Ҽӵ� ����� ���� �μ��� ��ȸ�غ����� -- ����
-- ����� ����
SELECT
    employee_id,
    dept.*
FROM
    departments dept,
    employees emp
WHERE
    dept.department_id = emp.department_id(+)
    AND employee_id IS NULL;