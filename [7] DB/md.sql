select * from book;

-- ���� ����ǥ: ���ڿ� ���� ���α� ����
-- ū ����ǥ: �ĺ��ڸ� ���α� ���� (Į���̸� ���� ������ �����ϱ� ����)

-- ��� ������ �����̸�, ���ǻ� �˻�
SELECT bookname, publisher
FROM book;

-- ��� ������ ������ȣ, �����̸�, ���ǻ�, ���� �˻�
SELECT bookid, bookname, publisher, price
FROM Book;

SELECT *
FROM Book;

-- �ߺ� ����: DISTINCT
SELECT DISTINCT publisher
FROM book;

-- ������ ���� �̻��� å (����: where)
select * from book
where price>=10000;

-- ������ ����~2���� ������ å (and/ between)
select * from book
where price>=10000 and price<=20000;

select * from book
where price between 10000 and 20000;

-- ���ǻ簡 �½����� Ȥ�� ���ѹ̵���� ���� (or/ in)
select * from book
where publisher='�½�����' or publisher='���ѹ̵��';

select * from book
where publisher in ('�½�����', '���ѹ̵��');

-- ���ǻ簡 �½����� Ȥ�� ���ѹ̵� �ƴ� ���� (or/ in)
select * from book
where publisher!='�½�����' and publisher!='���ѹ̵��';

select * from book
where publisher not in ('�½�����', '���ѹ̵��');

-- å�̸��� �౸�� ������ å (LIKE)
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '�౸�� ����';

-- å�̸��� �౸�� ���ԵǾ��ִ� ������ �˻� (%)
SELECT * FROM book
WHERE bookname LIKE '%�౸%';

-- �����̸� ���� 2��°�� '��'��� ���ڿ��� ���� ���� (_)
SELECT * FROM book
WHERE bookname LIKE '_��%';

-- �౸�� ���� ������ ������ 2���� �̻��� ����
SELECT * FROM book
WHERE bookname LIKE '%�౸%' and price>=20000;

-- Ư�� Į���� �������� ���� (order by/ ��������)
select *
from book
order by bookname;

-- Ư�� Į���� �������� ���� (order by + desc/ ��������)
select *
from book
order by bookname desc;

-- ���ݼ� -> �̸���(������ ������) ���� �˻�
select *
from book
order by price, bookname;

-- ���� �������� -> ���ǻ� �������� ����
select *
from book
order by price desc, publisher;

-------------<orders��>-----------------------------
select * from orders;

-- ���(sum)/ Į�� �̸� �ٲ㼭 ���(as)
select sum(saleprice) as "�� ����"
from orders;

-- 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž�
select sum(saleprice) as "�迬��"
from orders
where custid=2;

-- ����(1): orders ���̺��� saleprice�� ��, ���, �ּ�, �ִ밪�� ���϶�
select sum(saleprice) as "��",
avg(saleprice) as "���", 
min(saleprice) as "�ּҰ�", 
max(saleprice) as "�ִ밪"
from orders;

-- ����(2): orders ���̺��� ��������, �� �Ǹž� ���ϱ�
select count(*) as "��������", sum(saleprice) as "�� �Ǹž�"
from orders;

-- ����(3): ������ 8õ�� �̻��� ������ ������ ���� ����, ���� �ֹ� ������ �� ���� ���ϱ�
--(��, 2�� �̻� ������ ����)
select custid as "��id", count(*) as "�ֹ� ���� ����", sum(saleprice) as "�� �ֹ���"
from orders
where saleprice>=8000
group by custid
having count(*)>=2;    -- count(*) �ϸ� �׷�ȭ ������ custid ������ ��
-- having: group by�� �Բ� ���/ �׷�ȭ�� ����� ���͸� ����
-- where: ���տ� ���� ������ ����/ having: �����Լ� ����� ���� ������ ���� 

-- customer.custid�� orders.custid�� ���� ���� �̱� (�� ���̺� ��ġ��)
select *
from customer, orders
where customer.custid = orders.custid
order by customer.custid;

-- �� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻� (group by)
select customer.name, sum(orders.saleprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name;

select customer.custid, name, saleprice   --�̸� �ߺ� ����x ���ž� ��x
from customer, orders
where customer.custid = orders.custid;

-- ����(4): ���� �ֹ��� ��� ������ �� �Ǹž� ���ϱ�, ������ ����
select name, sum(orders.saleprice)
from customer, orders
where customer.custid = orders.custid
group by name
order by name;

-- ����(5): �� �̸��� ���� �ֹ��� ���� �̸� ���ϱ�
select name, bookname
from book b, customer c, orders o
where b.bookid=o.bookid and c.custid=o.custid
order by name;

-- ����(6): ������ 2���� �̻��� ������ �ֹ��� ���� �̸��� ���� �̸�
select name, bookname, saleprice
from book, customer, orders
where saleprice>=20000 
    and orders.bookid=book.bookid 
    and orders.custid=customer.custid
order by name;

-- ������: ���ʿ� ������ �̱�
-- (+)�� ���� �ݴ�(=����) �������� �պ� (+���� �ʿ� ���� ��� null�� ����)
-- ������ ������ �� ���� �ʿ� + ���̱� -> ������ �κ��� null������ ���
select c.custid, o.custid, c.name, o.saleprice
from customer c, orders o
where c.custid=o.custid(+);

-- ���� ����
-- ������ �������� ���� (left outer join ~ on ���� ����)
select c.custid, o.custid, c.name, o.saleprice
from customer c left outer join orders o on c.custid=o.custid;

-- ���� ��� ������ �̸��� ��� (���� select/ subquery)
select bookname, price
from book
where price=(select max(price) from book);

-- ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ��� (3���� ���)
select distinct name
from orders, customer
where customer.custid in orders.custid;

select distinct name
from orders, customer
where customer.custid = orders.custid;

select name
from customer
where custid in (select custid from orders);

-- ����(7): '���ѹ̵��'���� ������ ������ ������ �� �̸�
select customer.name, book.bookname, book.publisher
from orders, customer, book
where orders.bookid in (select bookid from book where publisher='���ѹ̵��')
     and orders.custid=customer.custid
     and book.bookid=orders.bookid;
    
-- ����(8): ���ǻ纰 �ش� ���ǻ� ��� ���� ���ݺ��� ��� ���� ���
select bookname, price, publisher 
from book b1 
where price > (select avg(price) from book b2
            where b1.publisher = b2.publisher);

-- ����(9): ������ �ֹ����� ���� �� �̸�
select customer.name
from customer left join orders on customer.custid=orders.custid
where orders.custid is null;

select custid, name
from customer
where not exists (select 1 from orders where orders.custid = customer.custid);
-- NOT EXISTS: ������ �����ϴ� ���ڵ� �� ���������� �˻��� �ش��ϴ°� ���� �� ��ȯ
    --ex. A���̺��� B���̺� '����' ���ڵ带 �˻��ϰ� ���� ��
    
select custid, name
from customer
where custid not in (select custid from orders);

select name
from customer
minus select name from customer    -- ����: MINUS
where custid in (select custid from orders);

-- ����(10): �ֹ��� �ִ� ���� �̸��� �ּ� �˻�
select name, address
from customer
where custid in (select custid from orders);

-----------------------------------------------------

-- ���(dual: ��갪�� �����ֱ� ���� ���� ���̺�)
select abs(-78), abs(+78) from dual;
select round(4.875, 1) from dual;

-- ���� ����ֹ��ݾ��� ��������� �ݿø�
select name, round(avg(saleprice), -2)
from orders, customer
where orders.custid=customer.custid
group by name;     -- �׷���� �ʿ���

SELECT name, ROUND(AVG(saleprice), -2)
FROM orders
JOIN customer ON orders.custid = customer.custid   --GPT�ڵ�
GROUP BY name;

-- ���� ���� '�߱�'�� ���Ե� ������ �󱸷� ����
-- ����: replace
select replace(bookname, '�߱�', '��') bookname, bookid, price
from book;

-- �½��������� ������ ���� ����� ���� ��(length), ����Ʈ ��(lengthb) ���ϱ�
select bookname ����, length(bookname) as "���� ���� ��", lengthb(bookname) as "����Ʈ ��"
-- ��Ī ������ �� ���� �׳� �ѱ۸� ������ as "ooo"���� ���
from book
where publisher='�½�����';

-- ������ ����(insert)
insert into customer values(6, '����ȣ', '���ѹα� ����', null);
-- Ȯ��
select * from customer;

-- ���缭�� �� �� ���� ���� ���� ����� ���̳� �Ǵ��� �ο��� ���ϱ�
select substr(name, 1, 1) ����, count(*)
from customer
group by substr(name, 1, 1);   --substr: name��, ù ��°, 1���� ���� ����

-- ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ����. �� �ֹ��� Ȯ������ ���ϱ�
select orderid �ֹ�, orderdate+10 �ֹ�Ȯ������
from orders;

-- ����(1): 2020-07-07�� ���� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ ���ϱ�
-- �ֹ����� yyyy-mm-dd ���·� ǥ��
select orderid, replace(orderdate, '/','-'), custid, bookid
from orders
where orderdate='20-07-07';

-- ���� ��¥(������)
select sysdate from dual;
-- TO_CHAR �Լ��� �̿��� SYSDATE���� ���ڿ� �������� ��ȯ
select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss')
from dual;

-- ����(2): DBMS������ ������ ���� ���ڿ� �ð�, ���� Ȯ��
select sysdate, to_char(sysdate, 'yyyy/mm/dd') ��¥, 
to_char(sysdate, 'dy') ����,
to_char(sysdate, 'hh24:mi:ss') �ð�
from dual;

-- ����(3): �̸�, ��ȭ��ȣ�� ���Ե� �����
-- ��, ��ȭ��ȣ�� ���� ���� ������ó���������� 
-- NVL("��", "������"): ���� NULL�̸� �������� ���/ NULL�� �ƴϸ� ���� ���� ���
select name �̸�, nvl(phone, '����ó����') ��ȭ��ȣ
from customer;

-- COALESCE(col1, col2, col3, '������'): nvl�� ����, �� ���ڸ� ������ ����
-- �� �ະ�� col1, col2, col3�� ������� �˻��ؼ� '���� ���� ������ null�� �ƴ� ��' ��ȯ
-- col1, col2, col3�� ���� null�̸� '������' ��ȯ
select name �̸�, COALESCE(phone, '����ó����') ��ȭ��ȣ
from customer;

-- ����(4): ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̼���.
-- rownum <= n: ��� �� n���� �̰ڴٰ� ���� ����
select custid, name, phone
from customer
where rownum<=2;

--����(5): ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̼���.
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice) from orders);

--����(6): �� �� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���� �ֹ���ȣ, ����ȣ, �ݾ� ���
select orderid, custid, saleprice
from orders a
where saleprice > (select avg(saleprice) from orders b where a.custid=b.custid);

--����(7): �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž�
select sum(saleprice) as "�� �Ǹž�"
from orders o, customer c
where o.custid =c.custid and address like '���ѹα�%';

--����(8): 3�� ���� �ְ� ���űݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid, saleprice
from orders
where saleprice>(select max(saleprice) from orders where custid=3);

--����(9): EXISTS ���/ ���ѹα��� �����ϴ� ���� ���� �� �Ǹž�
select sum(saleprice)
from orders
where exists (select 1 from customer where address like '���ѹα�%' 
             and orders.custid = customer.custid);

-- ����(10): ���缭�� ���� �Ǹž�(���̸�, ���� �Ǹž� ���)
select c.name ���̸�, nvl(sum(o.saleprice),0) "���� �Ǹž�"
from customer c, orders o
where c.custid=o.custid(+)
group by c.name;

-- update set
update customer
set phone='010-1234-5678'
where custid=1;

--����(11): ����ȣ�� 2������ ���� �Ǹž� (���̸�, ���� �Ǹž�)
select o.custid, name, sum(saleprice) "�� ���ž�"
from orders o, customer c
where o.custid<=2 and o.custid=c.custid
group by o.custid, name;

-- View = ������ ���̺�: �����ʹ� ����, SQL�� ����Ǿ��ִ� ��ü(object)
-- �⺻ ���̺��� �⺻Ű(�Ӽ�)�� �����Ͽ� �並 �����ϸ� ����, ����, ����, ������ ���� �մϴ�. 
-- �� �� ���ǰ� �� ���� ��� �ٸ� ���� �⺻ �����Ͱ� �� �� ����
-- �信 �ִ� �⺻ ���̺��̳� �並 �����ϸ� �ش� �����͸� ���ʷ��� �ٸ� ����� �ڵ����� ����
-- �信���� ALTER ��ɾ ���Ұ�

-- �ּҿ� ���ѹα��� �����ϴ� ����� ������ �並 ����� ��ȸ
create view vw_customer   --�� ����
as select * from customer where address like '���ѹα�%';
select * from vw_customer;   --��ȸ

