--char VS varchar2
--char: ��������/ ������ ���̸�ŭ ���� �Ҵ�
--varchar2: ��������/ ������ ���� ������ �ʿ��� ��ŭ�� ���� �Ҵ�

--[DDL]
--Table ����
create table test1(
eno number(4),
ename varchar2(20),
esal number(7) 
);

--���̺� ���� ��ȸ
desc test1;

--���̺� ����
create table test2 as select * from test1;

--���̺� ����
drop table table3;
insert into test1 values(1, '����ȣ', 5);
select * from test1;

--���̺� ���� ����
--������(where)�� ���������� �����ϸ� �ش� row�� �߰����� ���ؼ� �� ���̺��� ������
create table test3 as select * from test1 where 1=0;
select * from test3;
DESC test3;

-- �÷� �߰��ϱ�
alter table test1 add(email varchar2(10));

--�÷� �����ϱ�(������ ����)
alter table test1 modify(email varchar2(40));
desc test1;

--�÷� �����ϱ�
alter table test1 drop column email;

--���̺��� ��� �ο� ����
truncate table test1;
select * from test1;

--[���̺� ���� ��Ģ]
--���̺���� �ǹ��ִ� �̸�, ������ �ܼ���, �ٸ� ���̺��� ��ġ�� �ʰ�(�ߺ� �Ұ�)
--�� ���̺� �������� Į���� �ߺ� �Ұ�
--���̺� �̸��� �����ϰ�, �� Į������ ��ȣ "( )" �� ���� ����
--�� Į������ �޸�" ", �� ���еǰ� �׻� ���� �����ݷ� ";"���� ������.
--Į���� ���ؼ��� �ٸ� ���̺���� ����Ͽ� �ϰ��� �ְ� ����ϴ� ���� ����(������ ǥ��ȭ ����)
--Į�� �ڿ� ������ ���� ���� �ʼ�
--���̺��� Į������ �ݵ�� ���ڷ� �����ؾ� �ϰ�, �������� ���̿� ���� �Ѱ谡 �ִ�.
--�������� ������ ������ �����(Reserved word)�� �� �� ����.
--A-Z, a-z, 0-9, _, $, # ���ڸ� ���ȴ�.

--���� �ִ� ��� ���̺� ����Ʈ ��ȸ
select * from tabs;

--members ���̺� �����
create table members(
ID varchar2(50),
PWD varchar2(50),
NAME varchar2(10),
GENDER char(1),
AGE number(10),
BIRTHDAY char(20),
REGDATE date,
PHONE varchar(20)
);

drop table members;
desc members;

insert into members(id, pwd, name) values('200901','111','kevin');
select * from members;

-- ����(12): md�� �ִ� ���̺���� �̿��� hmkd������ ������ ���̺��� �����ϰ�
-- �ֿ� Ư¡�� ����ؼ� ��� (���̺� 5�� �̻�)
create table seldata as
select b.bookname, b.price, c.name, c.address, c.phone
from orders o
inner join customer c on o.custid=c.custid
inner join book b on o.bookid=b.bookid;
-- 1. �Ǹ� ������(å�̸�, ����) ����������(�̸�, �ּ�, �ڵ���)
select * from seldata order by bookname;

create table pub as
select b.publisher, b.bookname, c.name, c.address
from orders o
inner join customer c on o.custid=c.custid
right outer join book b on b.bookid=o.bookid;
-- 2. ���ǻ纰 �Ǹ� ����/�� ����
select * from pub order by publisher;

create table cusby as
select name, bookname, saleprice, orderdate
from orders o
inner join book b on o.bookid=b.bookid
right outer join customer c on o.custid=c.custid;
-- 3. ���� ���� �̷�(������, ���Ű���, ��������)
select * from cusby order by name;

create table daysel as
select orderdate, sum(saleprice) �Ϻ������
from orders
group by orderdate;
-- 4. ���� ���ں� ����
select * from daysel order by orderdate;

create table wh as
select substr(address,1,instr(address, ' ')-1) as ����, sum(saleprice) as "������ �����"
from orders o
inner join customer c on o.custid=c.custid
group by substr(address,1,instr(address, ' ')-1);
-- 5. ���� �Ǹž�
select * from wh;

--substr(text, ���� ���� ��ġ, �� ��ġ): ���ڿ����� Ư�� ���� ����
--instr: ������ ���ڿ��� ��Ÿ���� ��ġ ��ȯ
--(instr(address, ' ')-1 ���� ������ �տ������� �ʿ��ؼ� -1�� ����)

-----------------------------------------------------------

select * from member;
drop table member;
desc member;

create table member(
id nvarchar2(20),
pwd nvarchar2(20),
name nchar(5),
gender nchar(1),
age number(3),
birthday nvarchar2(10),
phone nvarchar2(15),
regdate date
);

insert into member values
('puppy0523','popo0523','�質��',
'��','23','2005-05-23','010-1234-5678',
(date '2023-05-10'));

alter table member add(hobby varchar2(20));    --Į���߰�
alter table member modify(hobby nvarchar2(10));   --Į�� �԰ݺ���(��, �����Ͱ� ����� ��)
update member set hobby='��å' where id='puppy0523';  --�� Į���� ���� ������ �߰�
alter table member drop column hobby;   --Į�� ����

alter table member add constraint m_pk primary key(id);  --�������� ����
alter table member drop constraint m_pk;    --�������� ����
desc member;

---------------------------------------------------------

--member1 ���̺� ����(��� ������Ÿ�� ����), ������ 2�� �̻� �Է�
--Į�� Ÿ�� ����, ����, �߰�/ �������� �߰�, ���� �� ����

--���̺� ����
create table member1(
id nvarchar2(20),
pwd nvarchar2(20),
name char(10),
gender nchar(1),
age number(3),
birthday varchar2(20),
phone nvarchar2(15),
regdate date
);

--������ ����
insert into member1 values(
'abc1', 'aaaa', '�����', '��', '25', '1999/10/9',
'010-1111-1110', (date '2023-05-10')
);
insert into member1 values(
'def2', 'dddd', '������', '��', '27', '1997/2/13',
'010-2222-2220', (date '2023-05-10')
);
insert into member1   --birthdayĮ�� ����, ������ ����
(id, pwd, name, gender, age, phone, regdate)
values(
'ghi3', 'gggg', '�Ѽ���', '��', '29',
'010-3333-3330', (date '2023-05-10')
);

alter table member1 add(hobby varchar2(30));  --Į�� �߰�
alter table member1 modify(hobby nvarchar2(10), name char(15));  --Į�� �԰� ����

update member1 set hobby='�뷡 ����' where id='abc1';  --�� Į�� ������ �߰�
update member1 set hobby='�׸� �׸���' where id='def2';

alter table member1 add(job nvarchar2(10));
alter table member1 drop column job;  --Į�� ����

alter table member1 add constraint m_key primary key(id);  --�⺻Ű �������� �߰�
alter table member1 drop constraint m_key;  --�������� ����

TRUNCATE TABLE MEMBER1;   --���̺� ��ü ������ ����

select * from member1;  --���̺� ����
drop table member1;  --���̺� ����
desc member1;  --���̺� ���� ����

--����(1): member2 ���̺� �����ؼ� ddl��ü ��ɾ ����ϴ� �ڵ� �ۼ�(���� member1�ڵ� ����)

--------------------------------------------------------------
--[DML]
select * from employees;

--IN: or ��� ���
select last_name, manager_id from employees
where manager_id=101 or manager_id=102 or manager_id=103;

select last_name, manager_id from employees
where manager_id in (101,102,103);  --�ξ� ª�� �� �� ����

--BETWEEN AND: and ��� ���
select last_name, manager_id from employees
where manager_id between 101 and 105;

--IS NOT NULL: �ΰ�(null) ����
select employee_id, commission_pct from employees
where commission_pct is not null;

--ORDER BY: ����
select employee_id, last_name, salary from employees
order by salary;   --��������(�⺻)

select employee_id, last_name, salary from employees
order by salary desc;  --desc: ��������

select employee_id, last_name, salary from employees
order by salary, last_name;  --2�� ����(salary�� ������ alst_name ����)

--dual table(��� ���̺�)
--select �� ������ �ݵ�� from ���� ����ؾ� �Ѵ�.
--������ ��� select �� ��ü������ ���� ���� -> from �� �ڿ� ���̺� �ʿ� X
--�̷� ��� ����ϴ� Dummy ���̺� = DUAL ���̺�

--mod: ������ ����
select employee_id, last_name from employees 
where mod(employee_id, 2)=1;  --����id�� Ȧ���� �͸�(mod=������ ����)

select mod(10,3) from dual;   --���� ����� �������� ���� ���̺� dual

--round: �ݿø� �Լ�
select round(355.95555, 0) from dual;   --�Ҽ��� ���� �ݿø�
select round(355.95555, -1) from dual;  --10������ �ݿø�

--trunc: ���� �Լ� (������ �ڸ��� ���� ����)
select trunc(45.5555, 2) from dual;   --�Ҽ��� 2° �ڸ� ������ ����
select trunc(45.5555) from dual;   --�Ҽ��� ���� ����

--��¥ ���� �Լ�
--sysdate: ���� ��¥
select sysdate from dual;
select sysdate+1 from dual;   --���굵 ����(������ ��¥ ���ϱ�)

select sysdate, hire_date,
sysdate-hire_date  --�����ϸ� ��/��/�ʱ��� ����(�Ҽ���)
from employees;

--add_months: ��¥�� n���� ���ϱ�
select last_name, hire_date,
add_months(hire_date, 6) "6���� ��"  --������ڿ� 6���� ���ϱ�
from employees;

--last_day: �̹����� ������ ��
select sysdate "���� ��¥", last_day(sysdate) "�̹��� ������ ��",
last_day(sysdate)-sysdate "�̹� �� ���� ��"
from dual;

--next_day: ���� ����� n���� ��¥
select hire_date, next_day(hire_date, '��') "���� ������"
from employees;

--months_between: �� �� ��������
select last_name,
months_between(sysdate, hire_date)  --��볯¥�κ��� ������� n���� ����
from employees;

--�� ��ȯ
--to_date: ���� -> ��¥
select to_date('20210101') from dual;

--to_char: ��¥ -> ����
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') from dual;

--����
--YYYY 		�� �ڸ� ����
--YY		�� �ڸ� ����
--YEAR		���� ���� ǥ��
--MM		���� ���ڷ�
--MON		���� ���ĺ�����
--DD		���� ���ڷ�
--DAY		���� ǥ��
--DY		���� ��� ǥ��
--D		    ���� ���� ǥ��
--AM /PM	���� ����
--HH /HH12	12�ð�
--HH24		24�ð�
--MI		��
--SS		��

-- ���� �Լ�
--upper / lower: ���ڸ� ���� ��(��)���ڷ�
select upper('Hello World') from dual;

select last_name, salary 
from employees
where lower(last_name)='seo';  --�����͸� �ҹ��ڷ� ���� ��, ���� �˻�

--initcap: ���̽� title�Լ��� ��� (�� �ձ��ڸ� �빮�ڷ�)
select job_id, initcap(job_id) from employees;

--length: ������ ���� ���� ���ϱ�
select job_id, length(job_id)
from employees;

--instr: Ư�� ���ڿ��� ��Ÿ���� ��ġ(text, ã�� ����, ã�� ���� �� n��°�� ��ġ)
select instr('Hello World', 'o',3,2)from dual;

--substr(text, ���� ���� ��ġ, �� ��ġ): ���ڿ����� Ư�� ���� ����
select substr('Hello World',1,3)from dual;  --Ư�� ���� ����x ��ġ�θ� ������
select substr('Hello World',-3,3)from dual;  --���̳ʽ� = �ڿ�������

--lpad, rpad: ��/������ ���� �� ���� ä���
select lpad('Hello World', 20, '#') from dual;   --���ʿ� ������ 20�� ä����

--ltrim, rtrim: �յ� Ư�� ���� ����
select ltrim('aaaaHello Worldaaaa', 'a') from dual;   --���� a ����
select rtrim('aaaaHello Worldaaaa', 'a') from dual;   --������ a ����

--trim: �յ� Ư�� ���� ����
select last_name, trim('A' from last_name) from employees;

--nvl: null�� �ٸ� ������ ��ȯ
select salary, nvl(commission_pct, 0) from employees;
--manager_id�� �������̶� ���������� �ٷ� ��ȯ�� ��X
select last_name, nvl(to_char(manager_id), 'CEO') from employees;

--decode: if���̳� case���� ����/ ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
select last_name, department_id,
decode(department_id, 90, '�濵������', 
                    60, '���α׷���', 
                    100, '�λ��') �μ���
from employees;

--case: ���ڵ� �Լ��� �����ϳ�, ���ڵ�� ������ ������ ��쿡�� ����
--���̽��� �پ��� �񱳿����ڷ� ���� ���� ����
select last_name, department_id,
case when department_id=90 then '�濵������'
    when department_id=60 then '���α׷���'
    when department_id=100 then '�λ��'
    when department_id=30 then '������'
    when department_id=50 then '������' end as �μ���
from employees;

--first_value() over(): ������ �׷��� ù��° ���� ����
select first_name �̸�, salary ����, 
first_value(salary) over(order by salary desc rows 3 preceding) �ְ���
--rows 3 preceding: ���� ������ ���� 3������ �����ؼ�, �� �� ���� ���� ������ ��
--ex. ��Ƽ���� ���� �����ص� ȥ�� �̹Ƿ� 24000,
--    ���� ���� �����ؼ� 24000,17000,17000,14000 �̹Ƿ� ù��° ���� 24000
from employees;

select first_name �̸�, salary ����, 
first_value(salary) over(order by salary desc range 2000 preceding) �ְ���
--range 2000: [�ڱ� ���� ~ ����+2000] ���� �ְ��� �� ����,
--           �ڱ� ���� ���� ���켭 �ش� '���� �� ������' ���� ū ��
from employees;

--sum() over(): Ư�� Į�� ���ؿ� ���� �׷��� �������� ����
select department_id, last_name, salary,
sum(salary) over(order by department_id) "���� ������"
from employees;

--INSERT: ������ �Է� ��� 2����/ �� ���� �� �Ǹ� �Է� ����
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);
select * from member;
insert into member(id, pwd, name) values('200903','113','�迬��');
insert into member values('200903','113','�迬��','��',20,'2001-12-30','110-2134-5423',sysdate);

--UPDATE
--UPDATE ������ ���̺��, SET ������ Į����=����(���ο�) ��
--[����] UPDATE PLAYER SET POSITION = 'MF��;
select * from member1;
update member1 set phone='010-3233-0303' where id='ghi3';

select * from member;
update member set name='�߽ż�' where id='200903' and age is null;
update member set id='200902' where name='�߽ż�';

--DELETE
--DELETE FROM ���̺�� (�̶� FROM ������ ������ ����)
--[����] DELETE FROM PLAYER;
select * from member;
update member set phone='010-3233-0303' where id='ghi3';

insert into member(id) values('200902');
alter table member add constraint m_pk primary key(id);
--��ġ�� id�� �־ �⺻Ű�� ������ �� ����
delete member where name is null;

--commit: ���ݱ��� ������Ʈ �� ���׵��� DB�� �ݿ�
commit;

--union: ������/ intersect: ������/ minus: ������/ union all: ��ġ�� �ͱ��� ����
--�� ���� �������� ���/ ������ Ÿ���� ��ġ ���Ѿ� �Ѵ�.
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where salary < 5000;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date < '05/01/01'
order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees where salary < 5000
union  --������: �� �� ���ʿ��� ������ ���
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date < '05/01/01' order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees where salary < 5000
intersect  --������: ���ʿ� ��� �־�߸� ���
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date < '05/01/01' order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees where salary < 5000
minus  --������:  �׷�1���� �׷�2�� ����� �κ� ���� ���
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date < '05/01/01' order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees where salary < 5000
union all   --�ߺ� ���� ������
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date < '05/01/01' order by �Ի���;

--join
create table test5(
id varchar2(10),
name varchar2(10),
eng number
);
insert into test5 values('111','james',90);
insert into test5 values('112','susan',60);
insert into test5 values('113','tom',85);
insert into test5 values('114','jean',70);
insert into test5 values('115','dick',75);
select * from test5;

drop table test6;
create table test6(
id varchar2(10),
math number,
age number
);
insert into test6 values('111',90,20);
insert into test6 values('112',60,20);
insert into test6 values('113',85,20);
insert into test6 values('114',70,20);
insert into test6 values('115',75,20);
insert into test6 values('116',39,23);
select * from test6;

--inner join
select * from test5
inner join test6 on test5.id = test6.id;

--outer join
select * from test5
left outer join test6 on test5.id = test6.id;
--join test6 on test5.id(+) = test6.id;   --left ��� (+)�� �ٿ��൵ ok

select * from test5
right outer join test6 on test5.id = test6.id;

select * from test5
full outer join test6 on test5.id = test6.id;

--����(2): test5, test6�� ������/������ ���̸� where�� �̿��� ���ϱ�
--������ �𸣰���~~~
select *
from test5, test6
where test5.id=test6.id;    --������

--������(�������)
select * from test5
where id in (select id from test6);

--������(�������)
select * from test6
where id not in (select id from test5);

SELECT * FROM test5  --���ξ�� �ڵ�
WHERE EXISTS (SELECT * FROM test6 WHERE test6.id = test5.id);

--����(3): ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title) ���
--join~on / where 2���� �������
select e.employee_id, first_name, last_name, e.job_id, j.job_title
from employees e, jobs j
where e.job_id=j.job_id and employee_id=120;

select e.employee_id, first_name, last_name, e.job_id, j.job_title
from employees e
inner join jobs j on e.job_id=j.job_id
where employee_id=120;

--����(4): employees, jobs, departments 3�� ���̺� ����
--employee_id, job_title, department_name���
select e.employee_id, d.department_name, j.job_title
from employees e
inner join jobs j on e.job_id=j.job_id
inner join departments d on e.manager_id = d.manager_id;

--����(5): hr�� 6�� ���̺���� �м��ؼ� �λ���Ʈ�� 5�� �̻� ���
--(ex. �μ��� ��� salary����)
select d.department_name, round(avg(e.salary)) avg
from departments d, employees e
where d.department_id=e.department_id
group by department_name
order by avg desc;

--<countries>
--country_id(�����ڵ�), country_name(������), region_id(�����ڵ�)

--<departments>
--department_id(�μ��ڵ�), department_name(�μ���), manager_id(�����ڵ�), 
--location_id(��������id)

--<employees>
--employee_id(���id), first_name, last_name, email, phone_number, 
--hire_date(�Ի���), job_id(�����ڵ�), salary(�޿�), commision_pct,
--manager_id(�����ڵ�), department_id(�μ��ڵ�)

--<jobs>
--job_id(�����ڵ�), job_title(������), min_salary(�ּ��ӱ�), max_salary(�ִ��ӱ�)

--<locations>
--location_id(��������id), street_address(���θ�), postal_code(�����ȣ), 
--city(����), state_province(����>��/��), country_id(�����ڵ�)

select e.job_id, job_title, salary, hire_date
from employees e, jobs j
where e.job_id=j.job_id
order by job_title, hire_date; 
--������, �Ի��Ͽ� ���� ���� ���� -> �Ի����� �������� ���� ���� �������� ����
--�Ϻ� ���ܰ� ������ �ʹ� �Ҽ����� �׼� ���̵� Ŀ��, �Ի��ϰ��� ������� �Ŷ� ����



select * from locations;
