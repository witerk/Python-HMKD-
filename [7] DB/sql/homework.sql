--����(1): ���, �̸�, ���� ��� (��, ������ �Ʒ� ���ؿ� ����)
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�' 
--salary > 10000 then '����' 
--salary > 5000 then '����' 
--salary > 3000 then '�븮'
--������ '���'
select employee_id ���, first_name ��, last_name �̸�, 
case when salary > 20000 then '��ǥ�̻�'
    when salary > 15000 then '�̻�' 
    when salary > 10000 then '����' 
    when salary > 5000 then '����' 
    when salary > 3000 then '�븮'
    else '���' end as ����
from employees;

--����(2): �μ��� ���� ������ ���
select e.department_id �μ��ڵ�, d.department_name �μ���, round(avg(e.salary),0) ��տ���
from employees e, departments d
where e.department_id=d.department_id
group by e.department_id, d.department_name
order by ��տ��� desc;

--����(3): employees ���̺��� employee_id�� salary�� �����ؼ� employee_salary ���̺��� ����
create table employee_salary
as select employee_id, salary from employees;

select * from employee_salary;

--����(4): employees_salary ���̺� first_name, last_name �÷��� �߰��ϼ���.
alter table employee_salary add(first_name varchar2(20), last_name varchar2(30));
alter table employee_salary add(first_name varchar2(20), last_name varchar2(30));
update employee_salary a set 
    first_name = (select first_name from employees b where a.employee_id=b.employee_id);
update employee_salary a set 
    last_name = (select last_name from employees b where a.employee_id=b.employee_id);

select * from employee_salary;

--����(5): last_name�� name���� �����ϼ���.
alter table employee_salary rename column last_name to name;
select * from employee_salary;

--����(6): employees_salary ���̺��� employee_id�� �⺻Ű�� �����ϰ� CONSTRAINT_NAME�� ES_PK�� ���� �� ����ϼ���.
alter table employee_salary add constraint ES_PK primary key(employee_id);
desc employee_salary;

--����(7) employees_salary ���̺��� employee_id���� CONSTRAINT_NAME�� ������ ���� ���θ� Ȯ��
alter table employee_salary drop constraint ES_PK;
desc employee_salary;

--����(8): lm������ ���̺� 6���� l���� ��Ȳ�� �ľ��� �� �ִ� ��� ���̺��� 5�� �̻� ����
select p.���޻�, sum(p.���űݾ�)
from channel c, pur p
where p.���޻�=c.���޻�
group by p.���޻�;

--���������� 
--���޻�: ���ĺ� �ϳ�(compet, pur)
--�����: ���ĺ�+��������(compet)
--���޻�: ���ĺ�_�����/��(channel)   --n���� ���Ű�_�����/pc

select * from compet;    --2015�� �����͸� ����
select min(�̿���), max(�̿���) from compet;    --2015/1 ~ 2015/12

select * from channel;
select * from pur;

select ���޻�, �����, count(*)
from compet
group by ���޻�, �����
order by ���޻�, �����;
--------------------------------------------------------------------------
--2015 ���޻縸 �̿��� ������ ��� ����
select ���޻�, count(*) "���޻� ������ ��", sum(���űݾ�) "���޻纰 ���� �Ѿ�", round(avg(���űݾ�),0) "��� ���ž�"
from pur
where ����ȣ not in (select ����ȣ from compet) and �������� like '2015%'
group by ���޻�
order by ���޻�, sum(���űݾ�);

--2015 ���޻�� ����縦 ��� �̿��� ����
select ���޻�, count(*) "����� ������ ��", sum(���űݾ�) "����纰 ���� �Ѿ�", round(avg(���űݾ�),0) "��� ���ž�"
from pur
where ����ȣ in (select ����ȣ from compet) and �������� like '2015%'
group by ���޻�
order by ���޻�, sum(���űݾ�);

--���� ��� �׼��� ����� ��(�뷫 10% ���� ����)
--�̿��� �� �� ���ž��� ���޻縸 �̿��� ������ �� ����
--A: �̿��� �� �� 1.4��, ���ž� �� 1.6��
--B: �̿��� ��, ���ž� �� 3��
--C: �̿��� �� �� 3.7��, ���ž� �� 3��
--D: �̿��� �� 2�� �� �� ��, ���ž� 1.5�� ����
-----------------------------------------------------------------------------
--����縦 �̿��� ������ ���� ������ (���ż�2: ���޻縸 �̿��� ����)
--� ������ ����� -> �ش� ���Ǻ��� ����� ������ �� ������ �װ� ��°� -> ��ǰ ���� �ʿ�
select a.���޻�, a.��з��ڵ�, a.p "���� ��(�����)", b.p "���� ��(���޻縸)", round((a.p/(a.p+b.p))*100,0) "����� ��ǰ ���� ����"
from (select ���޻�, ��з��ڵ�, count(*) p from pur
    where ����ȣ in (select ����ȣ from compet) and �������� like '2015%'
    group by ���޻�, ��з��ڵ�) a
join (select ���޻�, ��з��ڵ�, count(*) p from pur
    where ����ȣ not in (select ����ȣ from compet) and �������� like '2015%'
    group by ���޻�, ��з��ڵ�) b
on a.���޻�=b.���޻� and a.��з��ڵ�=b.��з��ڵ�
order by a.���޻�, "����� ��ǰ ���� ����" desc;
--A: 

