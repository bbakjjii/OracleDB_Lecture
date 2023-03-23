-- 00_��ġ �� �⺻.Sql


/*
# Database(Oracle XE Database 11g) ��ġ					
�� �ּ�â �Է� : https://www.oracle.com/database/technologies/xe-prior-release-downloads.html 					
�� Oracle Database 11gR2 Express Edition for Windows x64 �ٿ�ε� �� I reviewed and accept the Oracle License Agreement üũ �� Download OracleXE112_Wind64.zip Ŭ��					
�� C:\JavaFullStack�� database ���� ���� �� database ���� ���� ���� Ǯ�� �� DISK1 ������					
�� setup Ŭ�� �� Next �� I accept the terms in the license agreement üũ �� Next �� Destination Filder : C:��oracleexe�� Ȯ�� �� Next �� ������ ��й�ȣ ����(Enter Password : 1234 / Confirm Password : 1234) �� Next �� Current Installation Settings: ���� ���� �� �޸��忡 �ٿ��ְ� ������ �� Install Ŭ�� �� Finish Ŭ��					
�� https://goddaehee.tistory.com/191 ����Ʈ ����		

[ Database install ���� ���� - �޸��� ]					
Destination Folder: C:\oraclexe\					
Oracle Home: C:\oraclexe\app\oracle\product\11.2.0\server\					
Oracle Base:C:\oraclexe\					
Port for 'Oracle Database Listener': 1521					
Port for 'Oracle Services for Microsoft Transaction Server': 2030					
Port for 'Oracle HTTP Listener': 8080					

# ��ġ �� ������ ��
1. ��ġ ��θ� �� ����� �� �� (c:\oracleexe)
2. ��ġ �� ��Ʈ��ȣ�� �� ����� �� �� (1521, 8080, 2030, ...)
3. ��ġ �� ������ ��й�ȣ�� ���� �� ��
4. ���� �� ������ Ctrl + S�� ���� ���÷� �� ��

# ��ġ �� �ܼ� üũ
1. sqlplus
2. ������ �������� �α��� (sys as sysdba)
3. SELECT * FROM tab; (�Ǵ� tabs)
4. SELECT * FROM all_users;

# ������ ����(HR) ���
1. ������ �������� �α���
2. ALTER USER hr ACCOUNT UNLOCK; (hr ������ ��� ����)
3. ALTER USER hr IDENTIFIED BY password; (hr ������ ��й�ȣ ���� - password �ڸ��� 1234 ����)
				
# CMD ���� - Database  ��ġ ��� Ȯ�� �� �׽�Ʈ					
�� cmd �� C:\Users\PC > sqlplus �Է� �� ���� (database ��ġ ���� Ȯ��) �� Enter user-name : sys as sysdba �� Enter password : 1234					
�� SQL > SELECT * FROM tabs; �Է� �� Ctrl + C ������ �߰��� �ߴ� ����					
�� SQL > SELECT * FROM all_users;					
�� SQL > alter user hr account unlock; �� alter user hr identified by 1234;					
�� SQL > quit					
					
# SQLDeveloper ��ġ					
�� ���� �� sql developer �˻� �� Oracle SQL Developer Downloads Ŭ�� �� Windows 64-bit with JDK 11 included �ٿ�ε� �� Oracle �α��� �� �ڵ���ġ ��					
�� C:\JavaFullStack\database ���� ���� Ǯ��					
�� sqldeveloper ���� �� sqldeveloper.exe ����					
�� â �߸� �ƴϿ� ������?? �� Oracle ��� ��ô�� Oracle�� �ڵ�ȭ�� ��� ���� ������ ��� üũ ���� �� Ȯ�� Ŭ��	

# SQLDeveloper ��ġ�� ������ ��
1. ���۸� �� �ٿ�ε� �� ��ġ
2. ���ϴ� ������ �����Ͽ� GUI ȯ�濡�� DB�� �ٷ� �� ����
3. ���� �� ��Ʈ��ȣ�� ����� �����Ǿ����� üũ�� ��
					
# SQL Developer ȯ�漳��					
�� â ���� ��� �ʷϻ� [+] ��ư Ŭ�� �� [�� ������ ���̽� ����] �� Name : ������ / ����� �̸� : sys / ��й�ȣ : 1234 / �� : SYSDBA �� ���� Ŭ�� 										
�� [+] ��ư Ŭ�� �� [�� ������ ���̽� ����] �� Name : ������ ���� / ����� �̸� : hr / ��й�ȣ : 1234 / �� : �⺻�� �� ����					
�� ���� ��� â ���� : Ctrl + Enter					
�� [����] �� [ȯ�漳��] ��  [�ڵ� ������] �� [�۲�] �� �۲� �̸� : Dialog / �۲� ũ�� : 12�� ����					
�� [����] �� [ȯ�漳��] ��  [�ڵ� ������] �� [PL/SQL ���� ����] �� ��� ������ ��Ÿ�� : �⺻ �ּ� �� ����� : �ʷϻ����� ����					
*/


-- �� �� �ּ�
/* ���� �� �ּ� */

/*
    # ����Ű
    - Ctrl + Enter : ��ɹ� ����. �� ���忡 Ŀ���� ���ٴ�� ���� ��� â �ѱ�. ��ü ����ϰ� Ctrl+Enter ������ ��ü ��ɹ� ����
    - F5 : ��ũ��Ʈ ����. ��ü ������ ��ũ��Ʈ�� ������
    - Ctrl + S : �����ϱ� (C����̺� > �ڹ�Ǯ���� > �����ͺ��̽� > �޸� ����)
*/


-- ���� ������ ���̺� ��� ���� (�������� ������ �ִ� ���̺��� �ٸ���)
SELECT * FROM tab; 

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM countries;
SELECT * FROM locations;
SELECT * FROM fruits;

SELECT * FROM emp_details_view;