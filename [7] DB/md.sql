select * from book;

-- 작은 따옴표: 문자열 값을 감싸기 위함
-- 큰 따옴표: 식별자를 감싸기 위함 (칼럼이름 등을 예약어와 구분하기 위해)

-- 모든 도서의 도서이름, 출판사 검색
SELECT bookname, publisher
FROM book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격 검색
SELECT bookid, bookname, publisher, price
FROM Book;

SELECT *
FROM Book;

-- 중복 제외: DISTINCT
SELECT DISTINCT publisher
FROM book;

-- 가격이 만원 이상인 책 (조건: where)
select * from book
where price>=10000;

-- 가격이 만원~2만원 사이인 책 (and/ between)
select * from book
where price>=10000 and price<=20000;

select * from book
where price between 10000 and 20000;

-- 출판사가 굿스포츠 혹은 대한미디어인 도서 (or/ in)
select * from book
where publisher='굿스포츠' or publisher='대한미디어';

select * from book
where publisher in ('굿스포츠', '대한미디어');

-- 출판사가 굿스포츠 혹은 대한미디어가 아닌 도서 (or/ in)
select * from book
where publisher!='굿스포츠' and publisher!='대한미디어';

select * from book
where publisher not in ('굿스포츠', '대한미디어');

-- 책이름이 축구의 역사인 책 (LIKE)
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '축구의 역사';

-- 책이름에 축구가 포함되어있는 도서를 검색 (%)
SELECT * FROM book
WHERE bookname LIKE '%축구%';

-- 도서이름 왼쪽 2번째에 '구'라는 문자열을 갖는 도서 (_)
SELECT * FROM book
WHERE bookname LIKE '_구%';

-- 축구에 관한 도서중 가격이 2만원 이상인 도서
SELECT * FROM book
WHERE bookname LIKE '%축구%' and price>=20000;

-- 특정 칼럼을 기준으로 정렬 (order by/ 오름차순)
select *
from book
order by bookname;

-- 특정 칼럼을 기준으로 정렬 (order by + desc/ 내림차순)
select *
from book
order by bookname desc;

-- 가격순 -> 이름순(가격이 같으면) 정렬 검색
select *
from book
order by price, bookname;

-- 가격 내림차순 -> 출판사 오름차순 정렬
select *
from book
order by price desc, publisher;

-------------<orders셋>-----------------------------
select * from orders;

-- 계산(sum)/ 칼럼 이름 바꿔서 출력(as)
select sum(saleprice) as "총 매출"
from orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액
select sum(saleprice) as "김연아"
from orders
where custid=2;

-- 과제(1): orders 테이블에서 saleprice의 합, 평균, 최소, 최대값을 구하라
select sum(saleprice) as "합",
avg(saleprice) as "평균", 
min(saleprice) as "최소값", 
max(saleprice) as "최대값"
from orders;

-- 과제(2): orders 테이블에서 도서수량, 총 판매액 구하기
select count(*) as "도서수량", sum(saleprice) as "총 판매액"
from orders;

-- 과제(3): 가격이 8천원 이상인 도서를 구매한 고객에 대해, 고객별 주문 도서의 총 수량 구하기
--(단, 2권 이상 구매한 고객만)
select custid as "고객id", count(*) as "주문 도서 수량", sum(saleprice) as "총 주문액"
from orders
where saleprice>=8000
group by custid
having count(*)>=2;    -- count(*) 하면 그룹화 기준인 custid 개수를 셈
-- having: group by와 함께 사용/ 그룹화한 결과를 필터링 해줌
-- where: 집합에 대한 조건을 지정/ having: 집계함수 결과에 대한 조건을 지정 

-- customer.custid와 orders.custid가 같은 고객만 뽑기 (두 테이블 합치기)
select *
from customer, orders
where customer.custid = orders.custid
order by customer.custid;

-- 고객 이름과 고객이 주문한 도서의 판매가격을 검색 (group by)
select customer.name, sum(orders.saleprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name;

select customer.custid, name, saleprice   --이름 중복 제거x 구매액 합x
from customer, orders
where customer.custid = orders.custid;

-- 과제(4): 고객별 주문한 모든 도서의 총 판매액 구하기, 고객별로 정렬
select name, sum(orders.saleprice)
from customer, orders
where customer.custid = orders.custid
group by name
order by name;

-- 과제(5): 고객 이름과 고객이 주문한 도서 이름 구하기
select name, bookname
from book b, customer c, orders o
where b.bookid=o.bookid and c.custid=o.custid
order by name;

-- 과제(6): 가격이 2만원 이상인 도서를 주문한 고객의 이름과 도서 이름
select name, bookname, saleprice
from book, customer, orders
where saleprice>=20000 
    and orders.bookid=book.bookid 
    and orders.custid=customer.custid
order by name;

-- 합집합: 한쪽에 있으면 뽑기
-- (+)가 붙은 반대(=왼쪽) 기준으로 합병 (+붙은 쪽에 없을 경우 null값 나옴)
-- 데이터 개수가 더 적은 쪽에 + 붙이기 -> 부족한 부분은 null값으로 출력
select c.custid, o.custid, c.name, o.saleprice
from customer c, orders o
where c.custid=o.custid(+);

-- 위와 같음
-- 왼쪽을 기준으로 조인 (left outer join ~ on 병합 기준)
select c.custid, o.custid, c.name, o.saleprice
from customer c left outer join orders o on c.custid=o.custid;

-- 가장 비싼 도서의 이름을 출력 (이중 select/ subquery)
select bookname, price
from book
where price=(select max(price) from book);

-- 도서를 구매한 적이 있는 고객의 이름을 검색하세요 (3가지 방법)
select distinct name
from orders, customer
where customer.custid in orders.custid;

select distinct name
from orders, customer
where customer.custid = orders.custid;

select name
from customer
where custid in (select custid from orders);

-- 과제(7): '대한미디어'에서 출판한 도서를 구매한 고객 이름
select customer.name, book.bookname, book.publisher
from orders, customer, book
where orders.bookid in (select bookid from book where publisher='대한미디어')
     and orders.custid=customer.custid
     and book.bookid=orders.bookid;
    
-- 과제(8): 출판사별 해당 출판사 평균 도서 가격보다 비싼 도서 목록
select bookname, price, publisher 
from book b1 
where price > (select avg(price) from book b2
            where b1.publisher = b2.publisher);

-- 과제(9): 도서를 주문하지 않은 고객 이름
select customer.name
from customer left join orders on customer.custid=orders.custid
where orders.custid is null;

select custid, name
from customer
where not exists (select 1 from orders where orders.custid = customer.custid);
-- NOT EXISTS: 조건을 만족하는 레코드 중 서브쿼리의 검색에 해당하는게 없을 때 반환
    --ex. A테이블에서 B테이블에 '없는' 레코드를 검색하고 싶을 때
    
select custid, name
from customer
where custid not in (select custid from orders);

select name
from customer
minus select name from customer    -- 제외: MINUS
where custid in (select custid from orders);

-- 과제(10): 주문이 있는 고객의 이름과 주소 검색
select name, address
from customer
where custid in (select custid from orders);

-----------------------------------------------------

-- 계산(dual: 계산값을 보여주기 위한 가상 테이블)
select abs(-78), abs(+78) from dual;
select round(4.875, 1) from dual;

-- 고객별 평균주문금액을 백원단위로 반올림
select name, round(avg(saleprice), -2)
from orders, customer
where orders.custid=customer.custid
group by name;     -- 그룹바이 필요함

SELECT name, ROUND(AVG(saleprice), -2)
FROM orders
JOIN customer ON orders.custid = customer.custid   --GPT코드
GROUP BY name;

-- 도서 제목에 '야구'가 포함된 도서를 농구로 변경
-- 변경: replace
select replace(bookname, '야구', '농구') bookname, bookid, price
from book;

-- 굿스포츠에서 출판한 도서 제목과 글자 수(length), 바이트 수(lengthb) 구하기
select bookname 제목, length(bookname) as "제목 글자 수", lengthb(bookname) as "바이트 수"
-- 별칭 지정해 줄 때는 그냥 한글만 쓰던가 as "ooo"으로 사용
from book
where publisher='굿스포츠';

-- 데이터 삽입(insert)
insert into customer values(6, '박찬호', '대한민국 공주', null);
-- 확인
select * from customer;

-- 마당서점 고객 중 같은 성을 가진 사람이 몇이나 되는지 인원수 구하기
select substr(name, 1, 1) 성씨, count(*)
from customer
group by substr(name, 1, 1);   --substr: name의, 첫 번째, 1개만 떼서 봐라

-- 마당서점은 주문일로부터 10일 후 매출을 확정함. 각 주문의 확정일자 구하기
select orderid 주문, orderdate+10 주문확정일자
from orders;

-- 과제(1): 2020-07-07에 받은 도서의 주문번호, 주문일, 고객번호, 도서번호 구하기
-- 주문일은 yyyy-mm-dd 형태로 표기
select orderid, replace(orderdate, '/','-'), custid, bookid
from orders
where orderdate='20-07-07';

-- 현재 날짜(오늘자)
select sysdate from dual;
-- TO_CHAR 함수를 이용해 SYSDATE값을 문자열 형식으로 반환
select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss')
from dual;

-- 과제(2): DBMS서버에 설정된 현재 날자와 시간, 요일 확인
select sysdate, to_char(sysdate, 'yyyy/mm/dd') 날짜, 
to_char(sysdate, 'dy') 요일,
to_char(sysdate, 'hh24:mi:ss') 시간
from dual;

-- 과제(3): 이름, 전화번호가 포함된 고객목록
-- 단, 전화번호가 없는 고객은 ‘연락처없음’으로 
-- NVL("값", "지정값"): 값이 NULL이면 지정값을 출력/ NULL이 아니면 원래 값을 출력
select name 이름, nvl(phone, '연락처없음') 전화번호
from customer;

-- COALESCE(col1, col2, col3, '지정값'): nvl과 같음, 단 인자를 여러개 받음
-- 각 행별로 col1, col2, col3를 순서대로 검사해서 '가장 먼저 나오는 null이 아닌 값' 반환
-- col1, col2, col3이 전부 null이면 '지정값' 반환
select name 이름, COALESCE(phone, '연락처없음') 전화번호
from customer;

-- 과제(4): 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이세요.
-- rownum <= n: 목록 중 n개만 뽑겠다고 조건 지정
select custid, name, phone
from customer
where rownum<=2;

--과제(5): 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이세요.
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice) from orders);

--과제(6): 각 고객 평균 주문금액보다 큰 금액의 주문 내역에 대해 주문번호, 고객번호, 금액 출력
select orderid, custid, saleprice
from orders a
where saleprice > (select avg(saleprice) from orders b where a.custid=b.custid);

--과제(7): ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액
select sum(saleprice) as "총 판매액"
from orders o, customer c
where o.custid =c.custid and address like '대한민국%';

--과제(8): 3번 고객의 최고 구매금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
select orderid, saleprice
from orders
where saleprice>(select max(saleprice) from orders where custid=3);

--과제(9): EXISTS 사용/ 대한민국에 거주하는 고객의 도서 총 판매액
select sum(saleprice)
from orders
where exists (select 1 from customer where address like '대한민국%' 
             and orders.custid = customer.custid);

-- 과제(10): 마당서점 고객별 판매액(고객이름, 고객별 판매액 출력)
select c.name 고객이름, nvl(sum(o.saleprice),0) "고객별 판매액"
from customer c, orders o
where c.custid=o.custid(+)
group by c.name;

-- update set
update customer
set phone='010-1234-5678'
where custid=1;

--과제(11): 고객번호가 2이하인 고객의 판매액 (고객이름, 고객별 판매액)
select o.custid, name, sum(saleprice) "총 구매액"
from orders o, customer c
where o.custid<=2 and o.custid=c.custid
group by o.custid, name;

-- View = 가상의 테이블: 데이터는 없고, SQL만 저장되어있는 객체(object)
-- 기본 테이블의 기본키(속성)을 포함하여 뷰를 생성하면 삽입, 삭제, 갱신, 연산이 가능 합니다. 
-- 한 번 정의가 된 뷰의 경우 다른 뷰의 기본 데이터가 될 수 있음
-- 뷰에 있는 기본 테이블이나 뷰를 삭제하면 해당 데이터를 기초로한 다른 뷰들이 자동으로 삭제
-- 뷰에서는 ALTER 명령어를 사용불가

-- 주소에 대한민국을 포함하는 고객들로 구성된 뷰를 만들고 조회
create view vw_customer   --뷰 생성
as select * from customer where address like '대한민국%';
select * from vw_customer;   --조회

