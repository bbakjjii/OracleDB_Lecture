-- 08_JOIN.sql ★ 암기 ★

/*
    # 기본키 (Primary Key, PK)
    - 한 테이블에서 하나의 행을 유일하게 구분할 수 있는 컬럼
        ex) 전화번호, 주민등록번호, 이메일, 사원번호 등
    - 각 테이블에 기본키는 하나밖에 설정할 수 없다
    - 기본키로 설정된 컬럼에는 중복값을 넣을 수 없다 (UNIQUE)
    - 기본키로 설정된 컬럼에는 NULL값을 넣을 수 없다 (NOT NULL)
    
    
    # 후보키 (Candidate Key)
    - 기본키가 될 자격을 갖추었지만 기본키로 설정되지는 않은 컬럼
    
    # 외래키 (Foreign Key, FK)
    - 다른 테이블에서는 기본키(또는 후보키)지만 해당 테이블에서는 중복되는 값인 컬럼
        ex) employees의 department_id는 외래키
             departments의 department_id는 기본키
    - 어떤 테이블의 기본키(또는 후보키)가 해당 테이블의 외래키로 설정되면 두 테이블간에는 1:N 관계가 형성되었다고 볼 수 있다
        ex) 부서 1 : 사원 N(외래키를 들고 있는 쪽)
        
    # 개체 간 관계의 종류
    - 1:1 관계 : 같은 테이블 안에 넣으면 됨
    - 1:N 관계 : 부서 - 사원, 브랜드 - 체인점, 게시글 - 댓글, 회원 - 게시글  
    - N:N 관계 : 박생 - 전공(복수전공), 교수(여러 과목) - 과목(여러 교수)
    
    # 테이블 간의 JOIN
    - 기본키와 외래키로 관계가 형성되어 있는 경우 테이블의 정보를 종합하여 조회하는 것
    - CROSS JOIN
    - EQUI JOIN
    - SELF JOIN
    - 등등
*/

SELECT * FROM employees;
SELECT * FROM departments;

/*
    # CROSS JOIN
    - 조인에 사용되는 테이블들의 데이터를 조합하여 나올 수 있는 모든 경우를 출력하는 JOIN
    - 그냥 모든 행을 순서대로 조합하는 쓸데없는 정보
*/
SELECT * FROM employees; -- 107 rows
SELECT * FROM departments; -- 27 rows
SELECT * FROM employees, departments; -- 10개의 부서의 모든 사원을 곱한다. (모든 경우를 한다) -- 107 * 27 = 2889 rows

-- CROSS JOIN : 의미없는 모든 조합 : 10번 부서에 모든 사원 붙여보고, 20분 부서에 모든 사원 붙여보고... 쓸데 없는 조합..
SELECT
    employee_id,
    first_name,
    employees.department_id, -- 테이블명.컬럼 : 양 테이블에 이름이 겹치는 컬럼이 있는 경우 구분. 어느 테이블의 값인지 확실하게 구분해줘야 한다.
    departments.department_id, -- 테이블명.컬럼 : 양 테이블에 이름이 겹치는 컬럼이 있는 경우 구분. 어느 테이블의 값인지 확실하게 구분해줘야 한다.
    department_name
FROM
    employees,
    departments;
    
    
    /*
        # EQUI JOIN (이퀴 조인)
        
        - 두 테이블에서 서로 동일한 값을 지닌 컬럼(주로 기본키와 외래키)을 이용하여 CROSS JOIN으로부터 의미있는 데이터를 걸러내는 JOIN
        - 두 테이블에서 같은 이름을 가진 컬럼이 있는 경우 테이블명을 이용해 구분해줘야 한다.
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


-- 연습 1 : 모든 사원들의 사번/이름/부서명을 조회해보세요
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

-- 강사님 정답
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


-- 연습 2 : job_id가 IT_PROG인 사원들의 이름/직책/부서명을 조회해보세요
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

-- 강사님 정답
SELECT
    first_name, 
    job_id, 
    department_name
FROM
    employees emp, -- emp : 변수 설정 가능
    departments dept -- dept : 변수 설정 가능
WHERE
    emp.department_id = dept.department_id
    AND job_id = 'IT_PROG';
    
    
-- 연습 3 : 커미션을 받는 사원들의 사번/이름/소속도시를 조회해보세요
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
    
-- 강사님 정답
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


-- 연습 4 : Seattle에서 근무하는 사원들의 이름/직책명(job_title)/급여/소속도시를 조회해보세요
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

-- 강사님 정답
SELECT
    first_name, job_title, salary, city
FROM
    employees e, jobs j, departments d, locations l
WHERE
    e.job_id = j.job_id
    AND e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND city = 'Seattle';
    
    
-- ※ EMP_DETAILS_VIEW 쓰면 0점
-- EMP_DETAILS_VIEW : 테이블이 아니라 미리 조인을 다 해놓은 뷰
SELECT * FROM emp_details_view;
SELECT * FROM user_views;




/*
    # SELF JOIN
    
    - 하나의 테이블내에서 자기 자신과 JOIN하여 원하는 데이터를 얻어내는 방식
    - 해당 테이블의 기본키를 다른 컬럼에서 외래키로 사용하는 경우
        ex) employees의 manager_id,  회원정보 테이블의 추천인
*/

-- 자신의 직장 상사의 manager ID
SELECT
    e1.employee_id,
    e1. first_name AS "사원명",
    e1.manager_id AS "매니저 ID",
    e2.employee_id AS "매니저 본인 ID",
    e2.first_name || ' ' || e2.last_name AS "매니저 이름"
FROM
    employees e1, employees e2 -- 자기 자신의 테이블을 2개로 만들어 SELF JOIN 함  --  e1 : 직원, e2 : 매니저ㅣ
WHERE
    e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id; 

 -- ★ 다시 이해 해보기 ★       
-- 연습 1 : 매니저의 first_name이 e가 포함되는 모든 사원들의 "사번/이름/직책명/매니저이름"을 조회
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
    
    -- 강사님 정답
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


-- ★ 다시 이해 해보기 ★
-- 연습 2 : first_name이 Curtis인 사원과 동일한 부서인 사원들을 셀프 조인을 이용하여 모두 조회 
SELECT
    e2.employee_id,
    e2.first_name,
    e2.last_name,
    d.department_name
FROM
    employees e1, employees e2, departments d -- e1: first_name = Curtis, e2 : 나머지 직원들
WHERE
    e1.department_id = e2.department_id
    AND e2.department_id = d.department_id
    AND e1.first_name = 'Curtis'
ORDER BY
    e2.employee_id;
    
    -- 강사님 정답
SELECT 
    e2.* -- e2의 모든 것 조회
FROM
    employees e1, 
    employees e2
WHERE
    e1.first_name = 'Curtis'
    AND e1.department_id = e2.department_id
    AND e2.first_name <> 'Curtis' -- <> : Curtis 빼고 모든 직원이 조회됨
ORDER BY
    e2.employee_id; -- e1.employee_id : Curtis만 조회됨
    
    
/*
    # 연습문제
    
(1) 1:N 관계로 설정할 수 있는 실제 사례들을 생각해보세요.
카페 - 직원명단, 전체메뉴, 발주, 기계

(2) 1:N 관계로 설정한 각 개체를 테이블 형태로 설계해보세요 (테이블명, 컬럼명, 각 컬럼 타입..)

<< 직원명단 >>
[기본키] 사원번호  (NOT NULL NUMBER)
                이름          (VARCHAR2)
                연락처      (VARCHAR2)
[외래키] 파트명        (VARCHAR2) 
                직급           (NOT NULL VARCHAR2)
                급여           (NUMBER)
                고용일자   (NOT NULL DATE)
[외래키] 관리자번호 (NUMBER)  


<< 전체 메뉴 >>
[외래키] 파트명           (NUMBER)  -- 카테고리로 나누는게 나음
[기본키] 메뉴명           (VARCHAR2)
               용량                
               가격                (NUMBER)


<< 식재료 및 소모품 발주 >>
[외래키] 관리자번호  (NUMBER)
                재료아이디
[기본키] 재료명           (VARCHAR2) -- 재료 이름이 겹치는 경우가 있으니 재료 아이디로 기본키 하는게 좋음
                원산지          (NOT NULL CHAR)
                규격
                개수               (NUMBER)
                개당가격       (NUMBER)
                총액               (NUMBER)
 [외래키]  발주자(사원번호) 
                발주날짜       (NOT NULL DATE)
                발주처명        (VARCHAR2)
                발주 연락처   (VARCHAR2)
                발주 이메일   (NOT NULL VARCHAR2) 


<< 기계 >>
[외래키] 관리자번호 (NUMBER)
[기본키] 기계명         (VARCHAR2)
                가격            (NUMBER)
                구매일자    (NOT NULL DATE)
                내용연수    (NUMBER)
                구매처        (VARCHAR2)
                A/S 담당자 (VARCHAR2)
                A/S 연락처 (VARCHAR2)
                
<< 부서 >>
[기본키] 부서명
                관리자번호

(3) 어떤 컬럼이 기본키와 외래키 역할을 할지 생각해보세요

*/




/*
    # OUTER JOIN
    - JOIN 조건을 만족하지 못해 등장하지 못하는 행을 확인할 수 있는 JOIN
    - (+)를 붙인 쪽에 null을 추가해서 등장하지 못했던 행들을 확인할 수 있다
    
*/

SELECT count(*) FROM employees;
SELECT count(department_id) FROM employees;
SELECT count(manager_id) FROM employees;

-- Kimberely는 할당된 부서가 없어서 부서ID를 활용한 JOIN 조건을 만족하지 못하여 등장하지 못한다
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
-- e.department(+) : employee 쪽에 null값을 붙인 것 : 소속된 사원이 없는 부서를 조회
-- d.department(+) : departments쪽에 null값을 붙인 것 : 소속된 부서가 없는 사원을 조회

SELECT * FROM employees WHERE department_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NULL;


-- ★ 연습 1 : 모든 사원들의 "이름/월급/매니저이름"을 조회하되 매니저가 없는 사원도 함께 조회해보세요 -- 오답
-- 강사님 정답
SELECT
    emp.first_name,
    emp.salary,
    mgr.first_name AS manager_name
FROM
    employees emp,
    employees mgr
WHERE
    emp.manager_id = mgr.employee_id(+);

-- 연습 2 : "부서번호/부서명/주소/도시"를 조회하되 소속된 부서가 없는 도시도 함께 조회해보세요
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
    
-- 강사님 정답
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

-- ★연습 3 : 소속된 사원이 없는 부서만 조회해보세요 -- 오답
-- 강사님 정답
SELECT
    employee_id,
    dept.*
FROM
    departments dept,
    employees emp
WHERE
    dept.department_id = emp.department_id(+)
    AND employee_id IS NULL;