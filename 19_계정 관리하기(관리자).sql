-- 19_계정 관리하기(관리자).sql

/*
비밀번호 바꾸러면 - SYS 계정에서 해야 함.
*/
CONNECT sys as sysdba;
SHOW user;

-- 새 계정 생성하기
-- 계정 생성 : CREATE USER 계정명 IDENTIFIED BY 비밀번호;
-- 비번 변경 : ALTER USER 계정명 IDENTIFIED BY 변경할 비밀번호;
-- 변경할 비밀번호는 문자로 시작해야 함
CREATE USER testuser IDENTIFIED BY password; -- 비밀번호 잘못 입력함
ALTER USER testuser IDENTIFIED BY "password"; -- 비밀번호 password 변경

CREATE USER onore IDENTIFIED BY "1234";

-- 유저 데이터 딕셔너리 뷰
SELECT * FROM all_users; -- 현재 생성된 모든 계정 확인

-- 유저에게 권한 주기 (GRANT 권한명 TO 계정;)
GRANT CREATE SESSION TO onore; -- 접속 권한 주기
GRANT CREATE TABLE TO onore; -- 테이블 생성 권한 주기
GRANT RESOURCE TO onore; -- DB 저장 공간 사용 권한 주기

CONNECT testuser;

-- 유저의 권한 뺏기 (REVOKE 권한명 (시스템 명령 또는 SQL 명령) ON 테이블명 FROM 계정;)
REVOKE CREATE TABLE FROM testuser; -- 테이블 만드는 권한이 사라짐
REVOKE RESOURCE FROM testuser;

-- 비밀번호 바꾸기
ALTER USER testuser IDENTIFIED BY "1234";

-- 계정 삭제하기 (DROP USER 계정명;)
-- 계정이름 변경하려면 삭제 후 다시 만들어야 함
DROP USER testuser;


SELECT USER#, NAME FROM USER$ WHERE NAME = "새로운계정";