--과제(1): 사번, 이름, 직급 출력 (단, 직급은 아래 기준에 의함)
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'
select employee_id 사번, first_name 성, last_name 이름, 
case when salary > 20000 then '대표이사'
    when salary > 15000 then '이사' 
    when salary > 10000 then '부장' 
    when salary > 5000 then '과장' 
    when salary > 3000 then '대리'
    else '사원' end as 직급
from employees;

--과제(2): 부서별 연봉 순위를 출력
select e.department_id 부서코드, d.department_name 부서명, round(avg(e.salary),0) 평균연봉
from employees e, departments d
where e.department_id=d.department_id
group by e.department_id, d.department_name
order by 평균연봉 desc;

--과제(3): employees 테이블에서 employee_id와 salary만 추출해서 employee_salary 테이블을 생성
create table employee_salary
as select employee_id, salary from employees;

select * from employee_salary;

--과제(4): employees_salary 테이블에 first_name, last_name 컬럼을 추가하세요.
alter table employee_salary add(first_name varchar2(20), last_name varchar2(30));
alter table employee_salary add(first_name varchar2(20), last_name varchar2(30));
update employee_salary a set 
    first_name = (select first_name from employees b where a.employee_id=b.employee_id);
update employee_salary a set 
    last_name = (select last_name from employees b where a.employee_id=b.employee_id);

select * from employee_salary;

--과제(5): last_name을 name으로 변경하세요.
alter table employee_salary rename column last_name to name;
select * from employee_salary;

--과제(6): employees_salary 테이블의 employee_id에 기본키를 적용하고 CONSTRAINT_NAME을 ES_PK로 지정 후 출력하세요.
alter table employee_salary add constraint ES_PK primary key(employee_id);
desc employee_salary;

--과제(7) employees_salary 테이블의 employee_id에서 CONSTRAINT_NAME을 삭제후 삭제 여부를 확인
alter table employee_salary drop constraint ES_PK;
desc employee_salary;

--과제(8): lm데이터 테이블 6개로 l사의 현황을 파악할 수 있는 요약 테이블을 5개 이상 생성
select p.제휴사, sum(p.구매금액)
from channel c, pur p
where p.제휴사=c.제휴사
group by p.제휴사;

--거주지역별 
--제휴사: 알파벳 하나(compet, pur)
--경쟁사: 알파벳+숫자조합(compet)
--제휴사: 알파벳_모바일/앱(channel)   --n사의 구매고객_모바일/pc

select * from compet;    --2015년 데이터만 있음
select min(이용년월), max(이용년월) from compet;    --2015/1 ~ 2015/12

select * from channel;
select * from pur;

select 제휴사, 경쟁사, count(*)
from compet
group by 제휴사, 경쟁사
order by 제휴사, 경쟁사;
--------------------------------------------------------------------------
--2015 제휴사만 이용한 고객들의 평균 구매
select 제휴사, count(*) "제휴사 구매자 수", sum(구매금액) "제휴사별 구매 총액", round(avg(구매금액),0) "평균 구매액"
from pur
where 고객번호 not in (select 고객번호 from compet) and 구매일자 like '2015%'
group by 제휴사
order by 제휴사, sum(구매금액);

--2015 제휴사와 경쟁사를 모두 이용한 고객들
select 제휴사, count(*) "경쟁사 구매자 수", sum(구매금액) "경쟁사별 구매 총액", round(avg(구매금액),0) "평균 구매액"
from pur
where 고객번호 in (select 고객번호 from compet) and 구매일자 like '2015%'
group by 제휴사
order by 제휴사, sum(구매금액);

--구매 평균 액수는 비슷한 편(대략 10% 정도 차이)
--이용자 수 및 구매액은 제휴사만 이용한 고객들이 더 많음
--A: 이용자 수 약 1.4배, 구매액 약 1.6배
--B: 이용자 수, 구매액 약 3배
--C: 이용자 수 약 3.7배, 구매액 약 3배
--D: 이용자 수 2배 좀 안 됨, 구매액 1.5배 정도
-----------------------------------------------------------------------------
--경쟁사를 이용한 고객들의 구매 데이터 (구매수2: 제휴사만 이용한 고객들)
--어떤 물건을 샀는지 -> 해당 물건보다 경쟁사 물건이 더 좋으니 그걸 사는거 -> 상품 보완 필요
select a.제휴사, a.대분류코드, a.p "구매 수(경쟁사)", b.p "구매 수(제휴사만)", round((a.p/(a.p+b.p))*100,0) "경쟁사 상품 구매 비율"
from (select 제휴사, 대분류코드, count(*) p from pur
    where 고객번호 in (select 고객번호 from compet) and 구매일자 like '2015%'
    group by 제휴사, 대분류코드) a
join (select 제휴사, 대분류코드, count(*) p from pur
    where 고객번호 not in (select 고객번호 from compet) and 구매일자 like '2015%'
    group by 제휴사, 대분류코드) b
on a.제휴사=b.제휴사 and a.대분류코드=b.대분류코드
order by a.제휴사, "경쟁사 상품 구매 비율" desc;
--A: 

