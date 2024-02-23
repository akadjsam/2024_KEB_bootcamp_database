use madang;
CREATE VIEW vorders 
AS SELECT orderid ,o.custid, name,  o.bookid, bookname, saleprice, orderdate 
FROM customer c, orders o, book b
WHERE o.custid = c.custid AND o.bookid = b.bookid; #책을 주문한 사람과 한번이라도 주문된적이 있는책
SELECT * FROM vorders;

CREATE VIEW vw_book 
AS SELECT * 
FROM book WHERE bookname LIKE "%축구%";

select * from vw_book;

CREATE VIEW vw_customer AS SELECT * FROM customer WHERE address LIKE '%대한민국%';
select * from vw_customer;

CREATE VIEW vw_orders (orderid,custid,name,bookid,bookname,saleprice,orderdate)
AS SELECT orderid ,od.custid, cs.name, od.bookid, bookname, saleprice, orderdate 
FROM customer cs, orders od, book bk
WHERE od.custid = cs.custid AND od.bookid = bk.bookid; #책을 주문한 사람과 한번이라도 주문된적이 있는책

SELECT * FROM vw_orders;

SELECT orderid, bookname, saleprice
FROM vw_orders
WHERE name = '김연아';

select * from vw_customer;

CREATE OR REPLACE VIEW vw_customer(custid, name, address) #() 안에 있는 내용은 필드 이름. 기존의 view 테이블 수정
AS SELECT custid, name, address
FROM customer
WHERE address LIKE '%영국%';

DROP VIEW vw_customer;
USE MADANG;
SELECT * FROM BOOK;

#1
CREATE VIEW highorders (bookid,bookname,name,publisher,saleprice)
AS SELECT od.bookid, bookname, name, publisher, saleprice
FROM customer cs, orders od, book bk
WHERE od.custid = cs.custid AND od.bookid = bk.bookid AND saleprice = 20000;

#2
SELECT bookname, name FROM highorders;

#3
CREATE OR REPLACE VIEW highorders (bookid,bookname,name,publisher)
AS SELECT od.bookid, bookname, name, publisher
FROM customer cs, orders od, book bk
WHERE od.custid = cs.custid AND od.bookid = bk.bookid AND saleprice = 20000;

DROP VIEW highorders;
SELECT * FROM highorders;