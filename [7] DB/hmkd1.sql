--char VS varchar2
--char: 고정길이/ 선언한 길이만큼 공간 할당
--varchar2: 가변길이/ 선언한 길이 내에서 필요한 만큼만 공간 할당

--[DDL]
--Table 생성
create table test1(
eno number(4),
ename varchar2(20),
esal number(7) 
);

--테이블 내용 조회
desc test1;

--테이블 복사
create table test2 as select * from test1;

--테이블 삭제
drop table table3;
insert into test1 values(1, '박찬호', 5);
select * from test1;

--테이블 구조 복사
--조건절(where)에 거짓조건을 지정하면 해당 row를 발견하지 못해서 빈 테이블을 생성함
create table test3 as select * from test1 where 1=0;
select * from test3;
DESC test3;

-- 컬럼 추가하기
alter table test1 add(email varchar2(10));

--컬럼 변경하기(사이즈 변경)
alter table test1 modify(email varchar2(40));
desc test1;

--컬럼 삭제하기
alter table test1 drop column email;

--테이블의 모든 로우 삭제
truncate table test1;
select * from test1;

--[테이블 생성 규칙]
--테이블명은 의미있는 이름, 가능한 단수형, 다른 테이블명과 겹치지 않게(중복 불가)
--한 테이블 내에서는 칼럼명 중복 불가
--테이블 이름을 지정하고, 각 칼럼들은 괄호 "( )" 로 묶어 지정
--각 칼럼들은 콤마" ", 로 구분되고 항상 끝은 세미콜론 ";"으로 끝난다.
--칼럼에 대해서는 다른 테이블까지 고려하여 일관성 있게 사용하는 것이 좋음(데이터 표준화 관점)
--칼럼 뒤에 데이터 유형 지정 필수
--테이블명과 칼럼명은 반드시 문자로 시작해야 하고, 벤더별로 길이에 대한 한계가 있다.
--벤더에서 사전에 정의한 예약어(Reserved word)는 쓸 수 없다.
--A-Z, a-z, 0-9, _, $, # 문자만 허용된다.

--현재 있는 모든 테이블 리스트 조회
select * from tabs;

--members 테이블 만들기
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

-- 과제(12): md에 있는 테이블들을 이용해 hmkd서점의 데이터 테이블을 생성하고
-- 주요 특징을 요약해서 출력 (테이블 5개 이상)
create table seldata as
select b.bookname, b.price, c.name, c.address, c.phone
from orders o
inner join customer c on o.custid=c.custid
inner join book b on o.bookid=b.bookid;
-- 1. 판매 도서별(책이름, 가격) 구매자정보(이름, 주소, 핸드폰)
select * from seldata order by bookname;

create table pub as
select b.publisher, b.bookname, c.name, c.address
from orders o
inner join customer c on o.custid=c.custid
right outer join book b on b.bookid=o.bookid;
-- 2. 출판사별 판매 도서/고객 정보
select * from pub order by publisher;

create table cusby as
select name, bookname, saleprice, orderdate
from orders o
inner join book b on o.bookid=b.bookid
right outer join customer c on o.custid=c.custid;
-- 3. 고객별 구매 이력(도서명, 구매가격, 구매일자)
select * from cusby order by name;

create table daysel as
select orderdate, sum(saleprice) 일별매출액
from orders
group by orderdate;
-- 4. 구매 일자별 매출
select * from daysel order by orderdate;

create table wh as
select substr(address,1,instr(address, ' ')-1) as 국가, sum(saleprice) as "국가별 매출액"
from orders o
inner join customer c on o.custid=c.custid
group by substr(address,1,instr(address, ' ')-1);
-- 5. 나라별 판매액
select * from wh;

--substr(text, 추출 시작 위치, 끝 위치): 문자열에서 특정 문자 추출
--instr: 지정한 문자열이 나타나는 위치 반환
--(instr(address, ' ')-1 에선 공백의 앞에까지만 필요해서 -1을 해줌)

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
('puppy0523','popo0523','김나영',
'여','23','2005-05-23','010-1234-5678',
(date '2023-05-10'));

alter table member add(hobby varchar2(20));    --칼럼추가
alter table member modify(hobby nvarchar2(10));   --칼럼 규격변경(단, 데이터가 없어야 함)
update member set hobby='산책' where id='puppy0523';  --새 칼럼에 대한 데이터 추가
alter table member drop column hobby;   --칼럼 삭제

alter table member add constraint m_pk primary key(id);  --제약조건 설정
alter table member drop constraint m_pk;    --제약조건 삭제
desc member;

---------------------------------------------------------

--member1 테이블 생성(모든 데이터타입 적용), 데이터 2행 이상 입력
--칼럼 타입 변경, 삭제, 추가/ 제약조건 추가, 삭제 등 수행

--테이블 생성
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

--데이터 삽입
insert into member1 values(
'abc1', 'aaaa', '김민주', '여', '25', '1999/10/9',
'010-1111-1110', (date '2023-05-10')
);
insert into member1 values(
'def2', 'dddd', '차은우', '남', '27', '1997/2/13',
'010-2222-2220', (date '2023-05-10')
);
insert into member1   --birthday칼럼 제외, 데이터 삽입
(id, pwd, name, gender, age, phone, regdate)
values(
'ghi3', 'gggg', '한소희', '여', '29',
'010-3333-3330', (date '2023-05-10')
);

alter table member1 add(hobby varchar2(30));  --칼럼 추가
alter table member1 modify(hobby nvarchar2(10), name char(15));  --칼럼 규격 변경

update member1 set hobby='노래 감상' where id='abc1';  --새 칼럼 데이터 추가
update member1 set hobby='그림 그리기' where id='def2';

alter table member1 add(job nvarchar2(10));
alter table member1 drop column job;  --칼럼 삭제

alter table member1 add constraint m_key primary key(id);  --기본키 제약조건 추가
alter table member1 drop constraint m_key;  --제약조건 삭제

TRUNCATE TABLE MEMBER1;   --테이블 전체 데이터 삭제

select * from member1;  --테이블 보기
drop table member1;  --테이블 삭제
desc member1;  --테이블 정보 보기

--과제(1): member2 테이블 생성해서 ddl전체 명령어를 사용하는 코드 작성(위에 member1코드 참고)

--------------------------------------------------------------
--[DML]
select * from employees;

--IN: or 대신 사용
select last_name, manager_id from employees
where manager_id=101 or manager_id=102 or manager_id=103;

select last_name, manager_id from employees
where manager_id in (101,102,103);  --훨씬 짧게 쓸 수 있음

--BETWEEN AND: and 대신 사용
select last_name, manager_id from employees
where manager_id between 101 and 105;

--IS NOT NULL: 널값(null) 제외
select employee_id, commission_pct from employees
where commission_pct is not null;

--ORDER BY: 정렬
select employee_id, last_name, salary from employees
order by salary;   --오름차순(기본)

select employee_id, last_name, salary from employees
order by salary desc;  --desc: 내림차순

select employee_id, last_name, salary from employees
order by salary, last_name;  --2중 정렬(salary가 같으면 alst_name 검토)

--dual table(듀얼 테이블)
--select 절 다음에 반드시 from 절을 기술해야 한다.
--연산의 경우 select 절 자체적으로 연산 가능 -> from 절 뒤에 테이블 필요 X
--이런 경우 사용하는 Dummy 테이블 = DUAL 테이블

--mod: 나머지 연산
select employee_id, last_name from employees 
where mod(employee_id, 2)=1;  --직원id가 홀수인 것만(mod=나머지 연산)

select mod(10,3) from dual;   --연산 결과를 보기위한 더미 테이블 dual

--round: 반올림 함수
select round(355.95555, 0) from dual;   --소수점 이하 반올림
select round(355.95555, -1) from dual;  --10단위로 반올림

--trunc: 버림 함수 (지정한 자리수 이하 삭제)
select trunc(45.5555, 2) from dual;   --소수점 2째 자리 밑으로 버림
select trunc(45.5555) from dual;   --소수점 전부 버림

--날짜 관련 함수
--sysdate: 현재 날짜
select sysdate from dual;
select sysdate+1 from dual;   --연산도 가능(다음날 날짜 구하기)

select sysdate, hire_date,
sysdate-hire_date  --연산하면 시/분/초까지 계산됨(소수점)
from employees;

--add_months: 날짜에 n개월 더하기
select last_name, hire_date,
add_months(hire_date, 6) "6개월 후"  --고용일자에 6개월 더하기
from employees;

--last_day: 이번달의 마지막 날
select sysdate "오늘 날짜", last_day(sysdate) "이번달 마지막 날",
last_day(sysdate)-sysdate "이번 달 남은 날"
from dual;

--next_day: 가장 가까운 n요일 날짜
select hire_date, next_day(hire_date, '월') "다음 월요일"
from employees;

--months_between: 몇 달 지났는지
select last_name,
months_between(sysdate, hire_date)  --고용날짜로부터 현재까지 n개월 지남
from employees;

--형 변환
--to_date: 문자 -> 날짜
select to_date('20210101') from dual;

--to_char: 날짜 -> 문자
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') from dual;

--형식
--YYYY 		네 자리 연도
--YY		두 자리 연도
--YEAR		연도 영문 표기
--MM		월을 숫자로
--MON		월을 알파벳으로
--DD		일을 숫자로
--DAY		요일 표현
--DY		요일 약어 표현
--D		    요일 숫자 표현
--AM /PM	오전 오후
--HH /HH12	12시간
--HH24		24시간
--MI		분
--SS		초

-- 문자 함수
--upper / lower: 문자를 전부 대(소)문자로
select upper('Hello World') from dual;

select last_name, salary 
from employees
where lower(last_name)='seo';  --데이터를 소문자로 변경 후, 조건 검색

--initcap: 파이썬 title함수와 비슷 (각 앞글자만 대문자로)
select job_id, initcap(job_id) from employees;

--length: 데이터 글자 길이 구하기
select job_id, length(job_id)
from employees;

--instr: 특정 문자열이 나타나는 위치(text, 찾을 문자, 찾을 문자 중 n번째의 위치)
select instr('Hello World', 'o',3,2)from dual;

--substr(text, 추출 시작 위치, 끝 위치): 문자열에서 특정 문자 추출
select substr('Hello World',1,3)from dual;  --특정 문자 지정x 위치로만 빼낸거
select substr('Hello World',-3,3)from dual;  --마이너스 = 뒤에서부터

--lpad, rpad: 왼/오른쪽 정렬 후 문자 채우기
select lpad('Hello World', 20, '#') from dual;   --왼쪽에 공백을 20개 채워줌

--ltrim, rtrim: 앞뒤 특정 문자 제거
select ltrim('aaaaHello Worldaaaa', 'a') from dual;   --왼쪽 a 제거
select rtrim('aaaaHello Worldaaaa', 'a') from dual;   --오른쪽 a 제거

--trim: 앞뒤 특정 문자 제거
select last_name, trim('A' from last_name) from employees;

--nvl: null을 다른 값으로 변환
select salary, nvl(commission_pct, 0) from employees;
--manager_id는 숫자형이라 문자형으로 바로 변환할 수X
select last_name, nvl(to_char(manager_id), 'CEO') from employees;

--decode: if문이나 case문과 유사/ 여러 경우를 선택할 수 있도록 하는 함수
select last_name, department_id,
decode(department_id, 90, '경영지원실', 
                    60, '프로그래머', 
                    100, '인사부') 부서명
from employees;

--case: 디코드 함수와 동일하나, 디코드는 조건이 동일한 경우에만 가능
--케이스는 다양한 비교연산자로 조건 제시 가능
select last_name, department_id,
case when department_id=90 then '경영지원실'
    when department_id=60 then '프로그래머'
    when department_id=100 then '인사부'
    when department_id=30 then '영업부'
    when department_id=50 then '관리부' end as 부서명
from employees;

--first_value() over(): 지정된 그룹의 첫번째 값을 구함
select first_name 이름, salary 연봉, 
first_value(salary) over(order by salary desc rows 3 preceding) 최고연봉
--rows 3 preceding: 현재 값에서 위로 3개까지 포함해서, 그 중 가장 먼저 나오는 값
--ex. 스티븐은 위로 포함해도 혼자 이므로 24000,
--    존은 위로 포함해서 24000,17000,17000,14000 이므로 첫번째 값은 24000
from employees;

select first_name 이름, salary 연봉, 
first_value(salary) over(order by salary desc range 2000 preceding) 최고연봉
--range 2000: [자기 연봉 ~ 연봉+2000] 값이 최고연봉 값 범위,
--           자기 위로 전부 살펴서 해당 '범위 내 숫자중' 가장 큰 수
from employees;

--sum() over(): 특정 칼럼 기준에 따라 그룹의 누적합을 구함
select department_id, last_name, salary,
sum(salary) over(order by department_id) "연봉 누적합"
from employees;

--INSERT: 데이터 입력 방법 2가지/ 한 번에 한 건만 입력 가능
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUMN_LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);
select * from member;
insert into member(id, pwd, name) values('200903','113','김연아');
insert into member values('200903','113','김연아','여',20,'2001-12-30','110-2134-5423',sysdate);

--UPDATE
--UPDATE 수정할 테이블명, SET 수정할 칼럼명=수정(새로운) 값
--[예제] UPDATE PLAYER SET POSITION = 'MF’;
select * from member1;
update member1 set phone='010-3233-0303' where id='ghi3';

select * from member;
update member set name='추신수' where id='200903' and age is null;
update member set id='200902' where name='추신수';

--DELETE
--DELETE FROM 테이블명 (이때 FROM 문구는 생략이 가능)
--[예제] DELETE FROM PLAYER;
select * from member;
update member set phone='010-3233-0303' where id='ghi3';

insert into member(id) values('200902');
alter table member add constraint m_pk primary key(id);
--겹치는 id가 있어서 기본키로 설정할 수 없음
delete member where name is null;

--commit: 지금까지 업데이트 한 사항들을 DB에 반영
commit;

--union: 합집합/ intersect: 교집합/ minus: 차집합/ union all: 겹치는 것까지 포함
--두 개의 쿼리문을 사용/ 데이터 타입을 일치 시켜야 한다.
select first_name 이름, hire_date 입사일, salary 급여 from employees
where salary < 5000;

select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date < '05/01/01'
order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees where salary < 5000
union  --합집합: 둘 중 한쪽에라도 있으면 출력
select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date < '05/01/01' order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees where salary < 5000
intersect  --교집합: 양쪽에 모두 있어야만 출력
select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date < '05/01/01' order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees where salary < 5000
minus  --차집합:  그룹1에서 그룹2와 공통된 부분 빼고 출력
select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date < '05/01/01' order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees where salary < 5000
union all   --중복 포함 합집합
select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date < '05/01/01' order by 입사일;

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
--join test6 on test5.id(+) = test6.id;   --left 대신 (+)를 붙여줘도 ok

select * from test5
right outer join test6 on test5.id = test6.id;

select * from test5
full outer join test6 on test5.id = test6.id;

--과제(2): test5, test6의 합집합/교집합 차이를 where를 이용해 구하기
--합집합 모르겠음~~~
select *
from test5, test6
where test5.id=test6.id;    --교집합

--교집합(예슬언니)
select * from test5
where id in (select id from test6);

--차집합(예슬언니)
select * from test6
where id not in (select id from test5);

SELECT * FROM test5  --정인언니 코드
WHERE EXISTS (SELECT * FROM test6 WHERE test6.id = test5.id);

--과제(3): 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title) 출력
--join~on / where 2가지 방법으로
select e.employee_id, first_name, last_name, e.job_id, j.job_title
from employees e, jobs j
where e.job_id=j.job_id and employee_id=120;

select e.employee_id, first_name, last_name, e.job_id, j.job_title
from employees e
inner join jobs j on e.job_id=j.job_id
where employee_id=120;

--과제(4): employees, jobs, departments 3개 테이블 조인
--employee_id, job_title, department_name출력
select e.employee_id, d.department_name, j.job_title
from employees e
inner join jobs j on e.job_id=j.job_id
inner join departments d on e.manager_id = d.manager_id;

--과제(5): hr의 6개 테이블들을 분석해서 인사이트를 5개 이상 출력
--(ex. 부서별 평균 salary순위)
select d.department_name, round(avg(e.salary)) avg
from departments d, employees e
where d.department_id=e.department_id
group by department_name
order by avg desc;

--<countries>
--country_id(국가코드), country_name(국가명), region_id(지역코드)

--<departments>
--department_id(부서코드), department_name(부서명), manager_id(관리코드), 
--location_id(구역관리id)

--<employees>
--employee_id(사원id), first_name, last_name, email, phone_number, 
--hire_date(입사일), job_id(직업코드), salary(급여), commision_pct,
--manager_id(관리코드), department_id(부서코드)

--<jobs>
--job_id(직업코드), job_title(직업명), min_salary(최소임금), max_salary(최대임금)

--<locations>
--location_id(구역관리id), street_address(도로명), postal_code(우편번호), 
--city(도시), state_province(도시>시/도), country_id(국가코드)

select e.job_id, job_title, salary, hire_date
from employees e, jobs j
where e.job_id=j.job_id
order by job_title, hire_date; 
--직업별, 입사일에 따른 월급 추이 -> 입사한지 오래됐을 수록 월급 높아지는 경향
--일부 예외가 있지만 너무 소수에다 액수 차이도 커서, 입사일과는 관계없을 거라 예상



select * from locations;
