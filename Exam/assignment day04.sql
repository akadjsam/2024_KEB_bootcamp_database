use madang;

1.  Mybook 테이블을 생성하고 NULL에 관한 다음 SQL 문에 답하시오. 질의의 결과를 보면서 NULL에 대한 개념을 정리해보시오.
(1) SELECT *    FROM Mybook
    WHERE price IS NULL;
SELECT *    FROM Mybook;
    (답안)
(4)
 SELECT *
    FROM Mybook
    WHERE price ='';
       (답안)

(5) SELECT bookid, price+100
    FROM Mybook;
       (답안)
(6) SELECT SUM(price), AVG(price), COUNT(*)
    FROM Mybook
    WHERE bookid >= 4 ;
        (답안)

(7) SELECT COUNT(*), COUNT(price)
    FROM Mybook;
        (답안)

(8) SELECT SUM(price), AVG(price)
    FROM Mybook;
        (답안)

2. 부속질의에 관한 다음 SQL 문에 답하시오. 데이터베이스는 Madang 데이터베이스를 이용한다. 부속질의는 SELECT, FROM, WHERE 절에 각각 포함되어 있다.
(1) 주문이 있는 고객에 대하여 고객별로 custid, address, 총주문액을 구하는 sql문을 작성하시오.
(답안)
-- SELECT name, od.custid, address, SUM(od.saleprice) 
-- FROM orders od, customer cs WHERE cs.custid = od.custid GROUP BY od.custid;

SELECT (SELECT custid FROM customer cs WHERE cs.custid = od.custid) 'custid', 
	   (SELECT address FROM customer cs WHERE cs.custid = od.custid) 'address', 
       SUM(saleprice) 'total' 
	   FROM orders od GROUP BY od.custid;

select * from orders;
(2) 주문을 한 고객별 name, 평균 구매가격을 구하는 sql문을 작성하시오.
-- SELECT name, AVG(od.saleprice) 
-- FROM orders od, customer cs WHERE cs.custid = od.custid GROUP BY od.custid;

SELECT (SELECT name FROM customer cs WHERE cs.custid = od.custid) 'name', 
       AVG(od.saleprice) 'total' 
	   FROM orders od GROUP BY od.custid;
(답안)


(3) 고객번호가 3보다 작은 고객들의 총 판매금액을 구하는 sql문을 EXISTS 연산자를 이용하여 작성하시오.

(답안)
-- SELECT cs.name,cs.custid, SUM(od.saleprice) 'total' FROM 
-- (SELECT custid, name FROM customer WHERE custid<=2) cs, orders od WHERE od.custid = cs.custid GROUP BY cs.custid;

SELECT SUM(saleprice) as 'total'
FROM orders od WHERE EXISTS (SELECT * FROM customer cs WHERE cs.custid<=2 AND od.custid = cs.custid);