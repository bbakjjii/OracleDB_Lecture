-- 09_ANSI JOIN

/*
    # ANSI JOIN
    - ANSI (American National Standard Institute) : 미국 국제 표준 단체
    - ANSI에서 지정한 JOIN 표준 문법
    - 다른 데이터베이스에서도 사용할 수 있는 문법
*/

-- ANSI CROSS JOIN : 모든 행을 JOIN
SELECT * FROM employees CROSS JOIN departments;


-- ANSI INNER JOIN : 조건을 충족하는 행만 등장하는 JOIN
-- INNER JOIN ~ ON ~
SELECT
    *
FROM
    employees e
    INNER JOIN departments d ON e.department_id = d.department_id;


-- INNER JOIN ~ USING ~ : 조인 조건에 사용되는 두 컬럼의 이름이 같다면 USING을 사용해 간편하게 조인할 수 있다.
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
    INNER JOIN employees mgr ON emp.manager_id = mgr.employee_id; -- 컬럼의 이름이 같지 않으므로 USING 사용 불가



-- ANSI JOIN을 사용해 풀 것
-- 연습1 : 모든 사원들의 사번/이름/부서명을 조회
-- 연습2 : job_id가 IT_PROG인 사원들의 이름/직책/부서명을 조회해보세요
-- 연습3 : 커미션을 받는 사원들의 사번/이름/소속도시를 조회해보세요


-- ★연습 1 : ANSI JOIN을 사용해 풀 것 - 모든 사원들의 사번/이름/부서명을 조회해보세요 -- 오답
SELECT
    employee_id,
    first_name || ' ' || last_name AS name,
    d.department_name
FROM
    employees e
    INNER JOIN departments d ON e.department_id = d.department_id;

-- 강사님 정답
SELECT
    employee_id,
    first_name || ' ' || last_name AS name,
    department_name
FROM
    employees
    INNER JOIN departments USING(department_id)
ORDER BY
    employee_id ASC;


-- ★연습 2 : ANSI JOIN을 사용해 풀 것 - job_id가 IT_PROG인 사원들의 이름/직책/부서명을 조회해보세요 -- 오답
SELECT
    first_name || ' ' || last_name AS name,
    job_id,
    department_name
FROM
    employees e
    INNER JOIN departments d ON e.department_id = d.department_id
WHERE e.job_id LIKE 'IT_PROG';

-- 강사님 정답
-- ※ JOIN 조건과 원하는 조건을 구분하여 볼 수 있다는 장점이 있다.
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
    
    
-- ★ 문제 : emplyees, departments, location을 활용하여 직책이 IT_PROG인 사원들의 이름(first_name), 부서명(department_name), 도시명(city)을 조회하는 쿼리문을 작성하세요
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



-- ★연습 3 : 커미션을 받는 사원들의 사번/이름/소속도시를 조회해보세요 -- 오답
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
    
-- 강사님 정답
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
    # ANSI OUTER JOIN : 조건을 충족하지 못하는 행도 등장하는 JOIN
    
    1. LEFT OUTER JOIN : 오른쪽 테이블에 (+)를 추가하는 효과
    
    2. RIGHT OUTER JOIN : 왼쪽 테이블에 (+)를 추가하는 효과
    
    3. FULL OUTER  JOIN : 양쪽 모두에 (+)를 추가하는 효과
*/

SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
    employees emp
    LEFT OUTER JOIN employees mgr ON emp.manager_id = mgr.employee_id;
    
    
-- ANSI OUTER JOIN을 사용해 풀 것
-- 연습1 : 모든 사원들의 "이름/월급/매니저이름"을 조회하되 매니저가 없는 사원도 함께 조회해보세요
-- 연습2 : "부서번호/부서명/주소/도시"를 조회하되 소속된 부서가 없는 도시도 함께 조회해보세요
-- 연습3 : 소속된 사원이 없는 부서만 조회해보세요
    
    
-- 연습 1  : ANSI OUTER JOIN을 사용해 풀기 - 모든 사원들의 "이름/월급/매니저이름"을 조회하되 매니저가 없는 사원도 함께 조회해보세요
SELECT
    emp. first_name AS employee_name,
    emp.salary,
    mgr. first_name AS manager_name
FROM
    employees emp
    LEFT OUTER JOIN employees mgr ON emp.manager_id = mgr.employee_id;
    
-- 강사님 정답
SELECT
    e.first_name,
    e.salary,
    m.first_name AS manager_name
FROM
    employees e
    LEFT OUTER JOIN employees m ON e.manager_id = m.employee_id;
    

-- 연습 2 : ANSI OUTER JOIN을 사용해 풀기 - "부서번호/부서명/주소/도시"를 조회하되 소속된 부서가 없는 도시도 함께 조회해보세요
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
    
-- 강사님 정답
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


-- 연습 3 : ANSI OUTER JOIN을 사용해 풀기 - 소속된 사원이 없는 부서만 조회해보세요
SELECT
    employee_id,
    d.*
FROM
    departments d 
    LEFT OUTER JOIN employees e ON d.department_id = e.department_id
WHERE
    e.employee_id IS NULL;
    
-- 강사님 정답
SELECT
    department_id,
    department_name
FROM
    employees
    RIGHT OUTER JOIN DEPARTMENTS USING (department_id)
WHERE
    employee_id IS NULL;    