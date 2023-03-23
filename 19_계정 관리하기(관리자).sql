-- 19_���� �����ϱ�(������).sql

/*
��й�ȣ �ٲٷ��� - SYS �������� �ؾ� ��.
*/
CONNECT sys as sysdba;
SHOW user;

-- �� ���� �����ϱ�
-- ���� ���� : CREATE USER ������ IDENTIFIED BY ��й�ȣ;
-- ��� ���� : ALTER USER ������ IDENTIFIED BY ������ ��й�ȣ;
-- ������ ��й�ȣ�� ���ڷ� �����ؾ� ��
CREATE USER testuser IDENTIFIED BY password; -- ��й�ȣ �߸� �Է���
ALTER USER testuser IDENTIFIED BY "password"; -- ��й�ȣ password ����

CREATE USER onore IDENTIFIED BY "1234";

-- ���� ������ ��ųʸ� ��
SELECT * FROM all_users; -- ���� ������ ��� ���� Ȯ��

-- �������� ���� �ֱ� (GRANT ���Ѹ� TO ����;)
GRANT CREATE SESSION TO onore; -- ���� ���� �ֱ�
GRANT CREATE TABLE TO onore; -- ���̺� ���� ���� �ֱ�
GRANT RESOURCE TO onore; -- DB ���� ���� ��� ���� �ֱ�

CONNECT testuser;

-- ������ ���� ���� (REVOKE ���Ѹ� (�ý��� ��� �Ǵ� SQL ���) ON ���̺�� FROM ����;)
REVOKE CREATE TABLE FROM testuser; -- ���̺� ����� ������ �����
REVOKE RESOURCE FROM testuser;

-- ��й�ȣ �ٲٱ�
ALTER USER testuser IDENTIFIED BY "1234";

-- ���� �����ϱ� (DROP USER ������;)
-- �����̸� �����Ϸ��� ���� �� �ٽ� ������ ��
DROP USER testuser;


SELECT USER#, NAME FROM USER$ WHERE NAME = "���ο����";