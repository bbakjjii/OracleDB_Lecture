-- 00_설치 및 기본.Sql


/*
# Database(Oracle XE Database 11g) 설치					
① 주소창 입력 : https://www.oracle.com/database/technologies/xe-prior-release-downloads.html 					
② Oracle Database 11gR2 Express Edition for Windows x64 다운로드 → I reviewed and accept the Oracle License Agreement 체크 → Download OracleXE112_Wind64.zip 클릭					
③ C:\JavaFullStack에 database 폴더 생성 → database 폴더 내에 압축 풀기 → DISK1 생성됨					
④ setup 클릭 → Next → I accept the terms in the license agreement 체크 후 Next → Destination Filder : C:＼oracleexe＼ 확인 후 Next → 관리자 비밀번호 생성(Enter Password : 1234 / Confirm Password : 1234) 후 Next → Current Installation Settings: 내용 복사 후 메모장에 붙여넣고 저장한 뒤 Install 클릭 → Finish 클릭					
· https://goddaehee.tistory.com/191 사이트 참고		

[ Database install 관련 내용 - 메모장 ]					
Destination Folder: C:\oraclexe\					
Oracle Home: C:\oraclexe\app\oracle\product\11.2.0\server\					
Oracle Base:C:\oraclexe\					
Port for 'Oracle Database Listener': 1521					
Port for 'Oracle Services for Microsoft Transaction Server': 2030					
Port for 'Oracle HTTP Listener': 8080					

# 설치 시 주의할 점
1. 설치 경로를 잘 기억해 둘 것 (c:\oracleexe)
2. 설치 시 포트번호를 잘 기억해 둘 것 (1521, 8080, 2030, ...)
3. 설치 시 설정한 비밀번호를 잊지 말 것
4. 실행 할 때마다 Ctrl + S로 저장 수시로 할 것

# 설치 후 콘솔 체크
1. sqlplus
2. 관리자 계정으로 로그인 (sys as sysdba)
3. SELECT * FROM tab; (또는 tabs)
4. SELECT * FROM all_users;

# 연습용 계정(HR) 언락
1. 관리자 계정으로 로그인
2. ALTER USER hr ACCOUNT UNLOCK; (hr 계정의 잠금 해제)
3. ALTER USER hr IDENTIFIED BY password; (hr 계정의 비밀번호 변경 - password 자리에 1234 넣음)
				
# CMD 실행 - Database  설치 결과 확인 및 테스트					
① cmd → C:\Users\PC > sqlplus 입력 후 엔터 (database 설치 여부 확인) → Enter user-name : sys as sysdba → Enter password : 1234					
② SQL > SELECT * FROM tabs; 입력 → Ctrl + C 누르면 중간에 중단 가능					
③ SQL > SELECT * FROM all_users;					
④ SQL > alter user hr account unlock; → alter user hr identified by 1234;					
⑤ SQL > quit					
					
# SQLDeveloper 설치					
① 구글 → sql developer 검색 → Oracle SQL Developer Downloads 클릭 → Windows 64-bit with JDK 11 included 다운로드 → Oracle 로그인 후 자동설치 됨					
② C:\JavaFullStack\database 내에 압축 풀기					
③ sqldeveloper 파일 내 sqldeveloper.exe 실행					
④ 창 뜨면 아니요 누르기?? → Oracle 사용 추척의 Oracle로 자동화된 사용 보고 보내기 허용 체크 해제 후 확인 클릭	

# SQLDeveloper 설치시 주의할 점
1. 구글링 후 다운로드 및 설치
2. 원하는 접속을 생성하여 GUI 환경에서 DB를 다룰 수 있음
3. 접속 시 포트번호가 제대로 설정되었는지 체크할 것
					
# SQL Developer 환경설정					
① 창 좌측 상단 초록색 [+] 버튼 클릭 → [새 데이터 베이스 접속] → Name : 관리자 / 사용자 이름 : sys / 비밀번호 : 1234 / 롤 : SYSDBA → 접속 클릭 										
② [+] 버튼 클릭 → [새 데이터 베이스 접속] → Name : 연습용 계정 / 사용자 이름 : hr / 비밀번호 : 1234 / 롤 : 기본값 → 접속					
③ 질의 결과 창 열기 : Ctrl + Enter					
④ [도구] → [환경설정] →  [코드 편집기] → [글꼴] → 글꼴 이름 : Dialog / 글꼴 크기 : 12로 변경					
⑤ [도구] → [환경설정] →  [코드 편집기] → [PL/SQL 구문 색상] → 사용 가능한 스타일 : 기본 주석 → 전경색 : 초록색으로 변경					
*/


-- 한 줄 주석
/* 여러 줄 주석 */

/*
    # 단축키
    - Ctrl + Enter : 명령문 실행. 각 문장에 커서를 갖다대고 질의 결과 창 켜기. 전체 블록하고 Ctrl+Enter 누르면 전체 명령문 실행
    - F5 : 스크립트 실행. 전체 문장을 스크립트로 보여줌
    - Ctrl + S : 저장하기 (C드라이브 > 자바풀스택 > 데이터베이스 > 메모에 저장)
*/


-- 현재 계정의 테이블 목록 보기 (계정마다 가지고 있는 테이블이 다르다)
SELECT * FROM tab; 

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM countries;
SELECT * FROM locations;
SELECT * FROM fruits;

SELECT * FROM emp_details_view;