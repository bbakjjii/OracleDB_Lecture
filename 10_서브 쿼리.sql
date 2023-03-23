-- 10_서브 쿼리

/*
    # 서브 쿼리
    - 하나의 SELECT문 내부에 포함된 또 하나의 SELECT문
    - 서브 쿼리를 포함하고 있는 쿼리를 메인 쿼리라고 한다
    - 실행 결과에 따라 단일 행 서브 쿼리와 다중 행 서브 쿼리로 분류한다
    
    # 단일 행 서브 쿼리
    - 서브 쿼리의 결과가 하나의 행인 서브 쿼리
    - 단일 값끼리 비교하는 일반 연산자를 사용할 수 있다(=, >, <, ...)
    
    # 다중 행 서브 쿼리
    - 서브 쿼리의 결과가 2행 이상인 서브 쿼리
    - 다중 행 연산자와 함께 사용해야 한다 (IN, ANY, SOME, ALL, EXISTS, ...)
*/


-- 단일 행 서브 쿼리
-- ex) 150번의 사원의 급여(10000) 보다 급여가 높은 사람을 가져온다.

SELECT salary FROM employees WHERE employee_id = 150;

SELECT
    *
FROM
    employees
WHERE
    salary >= (SELECT salary FROM employees WHERE employee_id = 150); ----- ???????????????????????




-- 다중 행 서브 쿼리
-- IN : 다중 행 서브 쿼리의 결과 중 일치하는 것이 하나라도 있으면 true
-- ex) 직책명이 SA_REP인 사람과 last_name이 하나라도 겹치면 true

SELECT last_name FROM employees WHERE job_id = 'SA_REP';

SELECT
    *
FROM
    employees
WHERE
    last_name IN (SELECT last_name FROM employees WHERE job_id = 'SA_REP');
    



-- ANY, SOME : 다중 행 서브 쿼리의 여러 값들 중 하나 이상을 만족시키면 true
-- ex) IT_PROG들 중 가장 못 버는 사람보다 많이 버는 사원들을 조회 (4200 이상을 만족 시키면 true)

SELECT salary FROM employees WHERE job_id = 'IT_PROG';

SELECT 
    *
FROM
    employees
WHERE
    salary > ANY(SELECT salary FROM employees WHERE job_id = 'IT_PROG'); 




-- ALL : 다중 행 서브 쿼리로 조회된 모든 결과를 만족시켜야 true
--  ex) IT_PROG들 중 가장 잘 버는 사람보다 많이 버는 사원들을 조회

SELECT salary FROM employees WHERE job_id = 'IT_PROG';

SELECT 
    *
FROM
    employees
WHERE
    salary > ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG'); 



-- EXIST : 서브 쿼리의 결과가 존재하면 true

SELECT * FROM locations; -- location_id가 23개 있음
SELECT * FROM departments;

-- ex) departments에 manager_id가 존재하는 도시만 고르고 싶을 때
SELECT city FROM locations l WHERE -- location이 23번 돈다(for문이랑 비슷)
EXISTS (SELECT manager_id FROM departments d WHERE l.location_id = d.location_id); -- manager_id가 존재하는 곳만 고른 것


-- ★ 연습 1 : job_title에 Manager가 포함되는 모든 사원들의 전화번호를 조회 -- 오답
-- 강사님 정답

SELECT job_id, job_title FROM jobs WHERE job_title LIKE '%Manager%';

SELECT * FROM employees WHERE job_id IN
(SELECT job_id FROM jobs WHERE job_title LIKE '%Manager%');


-- ★ 연습 2 : 소속된 사원이 존재하지 않는 부서의 모든 정보를 조회 -- 오답
-- 강사님 정답
SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL; -- 사원들이 속해 있는 부서번호가 다 나옴

SELECT * FROM departments WHERE department_id NOT IN
(SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL); -- 사원들이 속해 있는 부서번호가 다 나옴






-- 추가 예시
-- 1.employees의 문제로 등장하지 못하는 경우 (일치하는 행이 없다,  null이다, ...)
-- 2. departmnets의 문제로 등장하지 못하는 경우
-- (+)를 안 붙인 쪽이 보고싶다는 의미
SELECT * FROM employees RIGHT OUTER JOIN departments USING (department_id);