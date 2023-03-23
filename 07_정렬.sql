-- 07_정렬.sql

/*
    # ORER BY
    
    - 원하는 컬럼 기준으로 정렬하여 조회하는 문법
    - ORDER BY 컬럼명 [ASC|DESC]
    - ASC : 오름차순 (Ascending)
    - DESC : 내림차순 (Descending)
*/

-- DESC : 내림차순
SELECT * FROM employees ORDER BY hire_date DESC; -- 가장 최근에 고용된 사람 > 가장 오래전에 고용된 사람 순으로 정렬됨
SELECT * FROM employees ORDER BY salary DESC; -- 가장 월급이 높은 사람 > 낮은사람 순으로 정렬됨

-- ASC : 오름차순, 생략 가능
SELECT * FROM employees ORDER BY salary ASC; -- 월급이 가장 낮은 사람 > 높은 사람 순으로 정렬
SELECT * FROM employees ORDER BY salary; -- 월급이 가장 낮은 사람 > 높은 사람 순으로 정렬

-- null은 내림차순 기준으로 가장 먼저 등장한다 (null이 가장 크다)
SELECT * FROM employees ORDER BY commission_pct DESC; -- null > 높은 사람 > 낮은 사람 기준

-- null 오름차순 기준으로 가장 나중에 등장한다
SELECT * FROM employees ORDER BY commission_pct ASC; -- 낮은 사람 > 높은 사람 > null 기준

-- 정렬 기준을 여러개 설정할 수도 있다
-- ex) 직책 기준으로 오름차순 정렬하되 같은 직책인 경우 사원번호 기준 오름차순 정렬
SELECT employee_id, first_name, salary, job_id FROM employees ORDER BY job_id, employee_id;

-- ex) 직책 기준으로 내림차순 정렬하되 같은 직책인 경우 사원번호 기준으로 오름차순 정렬(ASC는 생략 가능)
SELECT employee_id, first_name, salary, job_id FROM employees ORDER BY job_id DESC, employee_id ASC;


-- 연습 1 : 이름에 i가 포함되어 있는 사원들을 돈 많이 받는 순서대로 조회 (이름이 i로 시작하는 사원도 포함)
SELECT * FROM employees WHERE first_name LIKE 'I%' OR first_name LIKE '%i%' ORDER BY salary DESC;
SELECT first_name FROM employees WHERE first_name LIKE '%i%' OR first_name LIKE 'I%' ORDER BY salary DESC; -- 강사님 방법 1.
SELECT first_name FROM employees WHERE lower(first_name) LIKE '%i%' ORDER BY salary DESC; -- 강사님 방법 2.


-- 연습 2 : 모든 사원들을 last_name 기준으로 오름차순 정렬, 같은 last_name인 경우 first_name기준 오름차순 정렬
SELECT * FROM employees ORDER BY last_name ASC, first_name ASC; 
SELECT last_name, first_name FROM employees ORDER BY last_name ASC, first_name ASC; -- 강사님 방법

-- ex) 월급이 3000이하면서, 인원이 10명 이상인 직책
SELECT job_id, count(salary) FROM employees WHERE salary <= 3000 GROUP BY job_id HAVING count(salary) >= 10;

