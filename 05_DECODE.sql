-- 05_DECODE

/*
    # DECODE
    - decode(column, case1, value1, case2, value2, ..., default)
    - 맨 마지막 default는 기본값 역할을 함
    - switch-case와 유사함
    - 코드 → display name
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
     연습문제 : 직책에 따라 급여를 인상하여 출력해보세요
     
        IT_PROG : 5% 인상
        FI_ACCOUNT : 3% 인상
        모든 CLERK : 2% 인상
        
        이름/직책/원래급여/인상된급여를 출력
        원래의 급여는 before_salary라는 이름으로 출력
        인상된 급여는 after_salary라는 이름으로 출력

    */
    
    SELECT * FROM employees;
    SELECT DISTINCT job_id FROM employees WHERE job_id LIKE '%CLERK';
    
    SELECT first_name, job_id, salary AS befor_salary,
   decode(job_id, -- 직책에 따른 급여인상이기 때문에 salary가 아닌 job_id가 들어가야 한다.
    'IT_PROG', salary * 1.05, 
    'FI_ACCOUNT', salary  * 1.03, 
    'PU_CLERK', salary * 1.02,
    'SH_CLERK', salary * 1.02,
    'ST_CLERK', salary * 1.02,
    salary)  AS  after_salary
    FROM employees;
    
-- 강사님 정답
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
 job_id NOT LIKE '%_CLERK' -- 클럭들을 제외한 모든 사원들 
 UNION -- 합집합
 SELECT
    first_name,
    job_id,
    salary AS before_salary,
    salary * 1.02 AS after_salary -- 나머지 클럭들은 일괄적으로 1.02를 곱한다.
FROM
    employees
WHERE
    job_id LIKE '%_CLERK';
    
    
    
    
    /*
        # CASE-END문
        
        - DECODE는 정확하게 해당 컬럼값과 일치하는 값만 사용할 수 있지만
         CASE 문법은 조건을 사용할 수 있다
         
        # WHEN-THEN문
        - WHEN (column) THEN (value)
        - 컬럼의 값이 ~ 일 때, value가 ~ 이다.
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
    