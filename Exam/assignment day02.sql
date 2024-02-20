CREATE database p205;
use p205;

CREATE TABLE DEPT
(
	DEPTNO integer NOT NULL,
    DNAME varchar(14),
    LOC varchar(13),
    PRIMARY KEY(DEPTNO)
);

CREATE TABLE EMP
(
	EMPNO integer primary key,
    ENAME varchar(10),
    JOB varchar(9),
    MGR integer,
    HIREDATE DATE,
    SAL integer,
    COMM integer,
    DEPTNO integer,
    FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

desc EMP;

INSERT INTO Dept(deptno, dname, loc) VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO Dept(deptno, dname, loc) VALUES(20,'RESEARCH','DALLAS');
INSERT INTO Dept(deptno, dname, loc) VALUES(30,'SALES','CHICAGO');
INSERT INTO Dept(deptno, dname, loc) VALUES(40,'OPERATIONS','BOSTON');
SELECT * FROM DEPT;

INSERT INTO Emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(7369,'SMITH','CLERK',7902,'1980-12-17 00:00:00', 800, NULL, 20);
INSERT INTO Emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(7499,'ALLEN','SALESMAN',7698,'1981-02-20 00:00:00', 1600, 300, 30);
INSERT INTO Emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(7521,'WARD','SALESMAN',7698,'1981-02-22 00:00:00', 1250, 500, 30);
INSERT INTO Emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(7566,'JONES','MANAGER',7839,'1981-04-02 00:00:00', 2975, NULL, 20);

SELECT * FROM EMP;
# (5) INSERT INTO Emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(7654,'MARTIN','SALESMAN',7698,'1981-09-28 00:00:00', 1250, 1400, 50);

SELECT ename, loc FROM emp, Dept WHERE Emp.deptno=Dept.deptno;

ALTER TABLE DEPT ADD managername varchar(20);
SELECT * FROM DEPT;

UPDATE DEPT SET managername = 'KIM' WHERE DEPTNO = 10;
UPDATE DEPT SET managername = 'HEO' WHERE DEPTNO = 20;
UPDATE DEPT SET managername = 'PARK' WHERE DEPTNO = 30;
UPDATE DEPT SET managername = 'JI' WHERE DEPTNO = 40;

SELECT * FROM DEPT;