SELECT * FROM BOOK;
SELECT * FROM ORDERS;
SELECT * FROM customer;

SELECT bookname FROM book WHERE bookid = 1; #1-1
SELECT bookname FROM book WHERE price > 20000; #1-2
SELECT SUM(saleprice) FROM customer, orders WHERE orders.custid = (SELECT custid FROM customer WHERE name = '박지성');#1-3
SELECT COUNT(*) FROM orders WHERE orders.custid = (SELECT custid FROM customer WHERE name = '박지성'); #1-4
SELECT COUNT(bookid) FROM orders WHERE orders.custid = (SELECT custid FROM customer WHERE name = '박지성'); #1-5

SELECT DISTINCT bookname, saleprice, (price - saleprice) 
	FROM book,customer,orders 
    WHERE orders.custid = (SELECT custid FROM customer WHERE name = '박지성') 
    AND orders.bookid = book.bookid; #1-6


SELECT bookname 
	FROM book
	WHERE book.bookid NOT IN (SELECT orders.bookid FROM orders WHERE orders.custid = (SELECT custid FROM customer WHERE name = '박지성'));
--------------------------------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(*) FROM BOOK; #2-1
SELECT COUNT(DISTINCT publisher) FROM BOOK; #2-2
SELECT name, address FROM customer; #2-3
SELECT orderid FROM orders WHERE orderdate BETWEEN '2024-07-04' AND '2024-07-07'; #2-4
SELECT orderid FROM orders WHERE orderdate NOT IN (SELECT orderdate FROM orders WHERE orderdate BETWEEN '2024-07-04' AND '2024-07-07'); #2-5
SELECT name, address FROM customer WHERE name LIKE '김%'; #2-6
SELECT name, address FROM customer WHERE name LIKE '김%' AND name LIKE '%아'; #2-7
SELECT name FROM customer WHERE custid NOT IN (SELECT custid FROM orders); #2-8
SELECT SUM(saleprice), AVG(saleprice) FROM orders; #2-9
SELECT name, SUM(saleprice) FROM customer JOIN orders ON customer.custid = orders.custid GROUP BY name; #2-10
SELECT name, bookname FROM customer JOIN orders ON customer.custid = orders.custid JOIN book ON book.bookid = orders.bookid GROUP BY name,bookname; #2-11
SELECT bookname, MAX(price-saleprice) AS result FROM book JOIN orders ON orders.bookid = book.bookid GROUP BY bookname order by MAX(price-saleprice) desc; #2-12

SELECT name FROM customer JOIN orders ON customer.custid = orders.custid GROUP BY name, customer.custid
HAVING AVG(saleprice) > (SELECT AVG(saleprice) FROM orders); #2-13

--------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM BOOK;
SELECT * FROM ORDERS;
SELECT * FROM customer;

SELECT DISTINCT name 
FROM customer,book,orders
WHERE name NOT LIKE '박지성' AND book.bookid=orders.bookid AND customer.custid=orders.custid AND book.publisher IN
(
    SELECT DISTINCT publisher
	FROM book,customer,orders 
    WHERE orders.custid = (SELECT custid FROM customer WHERE name = '박지성') 
    AND orders.bookid = book.bookid); #3-1
    

SELECT DISTINCT name FROM customer, book, orders WHERE customer.custid = orders.custid AND book.bookid = orders.bookid GROUP BY name HAVING COUNT(DISTINCT publisher) >= 2; #3-2
SELECT bookname FROM book b1 WHERE (SELECT count(book.bookid) FROM book JOIN orders ON book.bookid = orders.bookid WHERE book.bookid = b1.bookid) >= 0.3 * (SELECT count(*) FROM customer);
USE MADANG;
--------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM BOOK;
SELECT * FROM ORDERS;
SELECT * FROM customer;
# INSERT INTO book VALUES ('스포츠 세계','대한미디어',10000) #4-1 bookid가 있어야 한다.
DELETE FROM book WHERE publisher = '삼성당'; #4-2
DELETE FROM book WHERE publisher = '이상미디어'; #4-3
UPDATE book SET publisher = '대한출판사' WHERE publisher = '대한미디어'; #4-4
--------------------------------------------------------------------------------------------------------------------------------------------------
create database madang;
use madang;
drop table 극장;
drop table 상영관;
drop table 예약;
drop table 고객;

CREATE TABLE 극장(극장번호 INTEGER,
	극장이름 VARCHAR(30),
	위치 VARCHAR(30)
) ;
CREATE TABLE 상영관
(극장번호 INTEGER,
상영관번호 INTEGER,
영화제목 VARCHAR(30),
가격 INTEGER,
좌석수 INTEGER
);
CREATE TABLE 예약
(극장번호 INTEGER,
상영관번호 INTEGER,
고객번호 INTEGER,
가격번호 INTEGER,
날짜 DATE
);
CREATE TABLE 고객
(고객번호 INTEGER,
이름 VARCHAR(30),
주소 VARCHAR(30)
);
INSERT INTO 극장 VALUES (1, '롯데', '잠실');
INSERT INTO 극장 VALUES (2, '메가', '강남');
INSERT INTO 극장 VALUES (3, '대한', '잠실');
INSERT INTO 상영관 VALUES (1, 1, '어려운 영화', 15000, 48);
INSERT INTO 상영관 VALUES (3, 1, '멋진 영화', 7500, 120);
INSERT INTO 상영관 VALUES (3, 2, '재밌는 영화', 8000, 110);
INSERT INTO 예약 VALUES (3, 2, 3, 15, '2020-09-01');
INSERT INTO 예약 VALUES (3, 1, 4, 16, '2020-09-01');
INSERT INTO 예약 VALUES (1, 1, 9, 48, '2020-09-01');
INSERT INTO 예약 VALUES (1, 1, 9, 49, '2020-09-01'); -- group by 테스팅용
INSERT INTO 고객 VALUES (3, '홍길동', '강남');
INSERT INTO 고객 VALUES (4, '김철수', '잠실');
INSERT INTO 고객 VALUES (9, '박영희', '강남');
COMMIT;
INSERT INTO 극장 VALUES (4, '낭만', '인천');
INSERT INTO 상영관 VALUES (4, 3, '그냥 영화', 5000, 50);
INSERT INTO 예약 VALUES (3, 2, 1, 17, '2020-09-01');
INSERT INTO 고객 VALUES (1, '김현일', '인천');
SELECT 극장이름, 위치 FROM 극장;
SELECT 극장이름 FROM 극장 WHERE 위치 = '잠실';
SELECT 이름 FROM 고객 WHERE 주소 = '잠실' ORDER BY 주소 DESC;
SELECT 극장번호, 상영관번호, 영화제목 FROM 상영관 WHERE 가격 <= 6000;
SELECT DISTINCT 이름 FROM 고객,극장 WHERE 주소 = 위치;

SELECT COUNT(*) FROM 극장;
SELECT AVG(가격) FROM 상영관;
SELECT COUNT(*) FROM 예약 WHERE 날짜 = '2020-09-01';

SELECT 영화제목 FROM 상영관 WHERE 상영관.극장번호 = (SELECT 극장번호 FROM 극장 WHERE 극장이름 = '대한');
SELECT 이름 FROM 고객 WHERE 고객번호 IN (SELECT 고객번호 FROM 예약 WHERE 예약.극장번호 = (SELECT 극장번호 FROM 극장 WHERE 극장이름 = '대한'));
SELECT SUM(가격) FROM 상영관 WHERE 상영관번호 IN (SELECT 상영관번호 FROM 예약 WHERE 극장번호 = (SELECT 극장번호 FROM 극장 WHERE 극장이름 = '대한'));

SELECT 극장.극장번호, COUNT(*) FROM 상영관 JOIN 극장 ON 상영관.극장번호 = 극장.극장번호 GROUP BY 상영관.극장번호;

SELECT * FROM 상영관 WHERE 극장번호 IN (SELECT 극장번호 FROM 극장 WHERE 위치 = '잠실');


SELECT 극장.극장번호, COUNT(*) FROM 예약 JOIN 극장 ON 예약.극장번호 = 극장.극장번호 WHERE 예약.날짜 = '2020-09-01' GROUP BY 예약.극장번호;


SELECT 영화제목 FROM 상영관, 예약 WHERE 상영관.극장번호 = 예약.극장번호 AND 상영관.상영관번호 = 예약.상영관번호 AND 날짜 LIKE '2020-09-01' GROUP BY 예약.극장번호, 예약.상영관번호;

SELECT 영화제목 FROM 상영관, 예약 WHERE 상영관.극장번호 = 예약.극장번호 AND 상영관.상영관번호 = 예약.상영관번호 AND 날짜 LIKE '2020-09-01' GROUP BY 영화제목 ORDER BY COUNT(예약.극장번호) DESC LIMIT 1;
# 6-(5)-1 생략

UPDATE 상영관 SET 가격 = 가격 + (가격 * 0.1);