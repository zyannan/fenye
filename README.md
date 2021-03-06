# 分页查询


## 环境

```
myeclipse8.5
导入mye就可以跑
```

```
tomcat就用myeclipse自带的就可以，就是打开就在servers标签里就有的，我这里叫MyEclipse Tomcat
jdk就用myeclipse自带的就可以，我这里默认是Sun JDK 1.6.0_13
```

## 其他信息
```
参考自 /李兴华/魔乐JAVAWEB实战经典高级篇/060502_〖第05章：JSP基础语法〗_第02题
部分样式参考自，金币交易系统
```

```
//mysql的分页，要的是行号和要查询的行数，一个初始行号,从0开始，一个行数，即页面大小
//oracle的分页，是要的2个行号，一个初始行号，从1开始，一个结束行号

//如果那个select里面，option没有那个值，就赋值不了，相当于name=cp这个input被disabled了
```

```
注意事项：
- 偶发：由于git不允许上传空文件夹，导入myeclipse的时候，自行在根目录下创建一个src目录
```
## 访问路径

```
http://localhost:8080/fenye/fenye_controller.jsp
http://localhost:8080/fenye/search_fenye_controller.jsp
```


## 功能

```
有分页组件，有模糊查询，可以连oracle，可以连mysql
```


## sql脚本如下

### oracle

```
DROP TABLE DEPT;
CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) ) ;
DROP TABLE EMP;
CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-87','dd-mm-rr')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-87','dd-mm-rr')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
```

### mysql

```
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `mid` VARCHAR(50),
  `password` VARCHAR(32) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `dept`;
CREATE TABLE DEPT(
	DEPTNO int(2),
	DNAME VARCHAR(14) ,
	LOC VARCHAR(13) ,
	PRIMARY KEY (`deptno`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
	
DROP TABLE IF EXISTS `emp`;
CREATE TABLE emp(
	EMPNO int(4),
	ENAME VARCHAR(10) ,
	Job VARCHAR(9) ,
	MGR int(4),
	HIREDATE DATE,
	SAL double(7,2),
	COMM double(7,2),
	PRIMARY KEY (`EMPNO`),
	DEPTNO int(2),
	foreign key (deptno) references DEPT(DEPTNO)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;
	

INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,str_to_date('17-12-1980','%e-%c-%Y'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,str_to_date('20-2-1981','%e-%c-%Y'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,str_to_date('22-2-1981','%e-%c-%Y'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,str_to_date('2-4-1981','%e-%c-%Y'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,str_to_date('28-9-1981','%e-%c-%Y'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,str_to_date('1-5-1981','%e-%c-%Y'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,str_to_date('9-6-1981','%e-%c-%Y'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,date_sub( str_to_date('13-7-87','%e-%c-%y'), interval 85 day),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,str_to_date('17-11-1981','%e-%c-%Y'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,str_to_date('8-9-1981','%e-%c-%Y'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,date_sub(str_to_date('13-7-87','%e-%c-%y'), interval 51 day),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,str_to_date('3-12-1981','%e-%c-%Y'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,str_to_date('3-12-1981','%e-%c-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,str_to_date('23-1-1982','%e-%c-%Y'),1300,NULL,10);
```
