-- 06_그룹함수

/*

    # 그룹 함수
    
    - 테이블의 행들을 특정 컬럼 기준으로 그룹화하여 계산하는 함수들
    - 그룹의 기준이 되는 컬럼을 GROUP BY절을 통해 선택할 수 있다
    - 해당 그룹의 총합, 개수, 평균 등을 구할 수 있다
    - 그룹 함수의 결과는 일반 컬럼과 함께 출력할 수 없다
*/


-- sum(column) : 해당 컬럼의 총합을 구하는 그룹 함수 
SELECT sum(salary) FROM employees;
SELECT job_id, sum(salary) FROM employees GROUP BY job_id; -- 직책별 월급 총합

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
        department_id; -- 부서별 월급 총합
    

-- avg(column) : 해당 컬럼의 평균을 구하는 그룹 함수
SELECT avg(salary) FROM employees;
SELECT avg(salary) FROM employees GROUP BY phone_number; -- 전화번호는 다 다르기 때문에 그룹화 안됨

-- SELECT first_name, avg(salary) FROM employees GROUP BY job_id; -- 직책별 평균 월급, 그룹 함수의 결과는 일반 컬럼과 함께 출력할 수 없기 때문에 개인의 이름은 나올 수 없다.
SELECT job_id, avg(salary) FROM employees GROUP BY job_id; -- 직책별 평균 월급
SELECT department_id, avg(salary) FROM employees GROUP BY department_id; -- 부서별 평균 월급


-- count(column) : 해당 컬럼의 개수를 구하는 그룹 함수
SELECT count(commission_pct) FROM employees; -- 커미션을 받는 사원의 총 인원수
SELECT job_id, count(commission_pct) FROM employees GROUP BY job_id; -- 직책별 커미션 받는 사원 인원수

-- max(column) : 해당 컬럼의 값들 중 가장 큰 값을 구함
SELECT max(hire_Date) FROM employees; -- 가장 최근에 고용된 직원의 고용날짜
SELECT job_id, max(hire_Date) FROM employees GROUP BY job_id; -- 가장 최근에 고용된 직책별 직원의 고용날짜
SELECT department_id, max(hire_Date) FROM employees GROUP BY department_id; -- 가장 최근에 고용된 부서별 직원의 고용날짜


-- min(column) : 해당 컬럼의 값들 중 가장 작은 값을 구함
SELECT min(hire_Date) FROM employees; -- 가장 오래전에 고용된 직원의 고용날짜


-- 연습문제 : 각 직책별로 가장 최근에 사원이 입사한 날짜와 가장 오래전 입사한 날짜를 출력해보세요
SELECT job_id, max(hire_date), min(hire_date) FROM employees GROUP BY job_id;

-- 연습문제 : 각 직책별로 평균 연봉을 구해보세요 (월급 말고 연봉)
SELECT job_id, avg(salary * 12) AS 연봉 FROM employees GROUP BY job_id;


/*
    - 그룹 함수의 결과에 대한 조건을 적용하고 싶은 경우 WHERE절이 아닌 HAVING절을 사용해야 한다
    - WHERE절에는 그룹 함수가 허용되지 않는다
*/
SELECT avg(salary), job_id FROM employees GROUP BY job_id WHERE avg(salary) > 10000; -- 에러O
SELECT avg(salary), job_id FROM employees WHERE avg(salary) > 10000 GROUP BY job_id; -- 에러O
SELECT avg(salary), job_id FROM employees GROUP BY job_id HAVING avg(salary) > 10000; -- 에러X

-- WHERE절은 GROUP BY로 묶이기 전에 먼저 적용된다
-- ex) 월급이 5000미만인 사원들의 직책별 평균이 4000이상인 경우만 출력
SELECT avg(salary), job_id FROM employees WHERE salary < 5000 GROUP BY job_id HAVING avg(salary) >= 4000;

-- ex) 직책별로 월급이 5000미만인 사원들이 10명 이상인 경우만 출력
SELECT count(salary), job_id FROM employees WHERE salary < 5000 GROUP BY job_id HAVING count(job_id) > 10;