use madang;
select * from orders;
SELECT custid, ROUND(SUM(saleprice)/COUNT(*), -2) '평균금액' FROM orders GROUP BY custid;

-- 대상 문자열을 모두 소문자로 변환함
select LOWER('MR. SCOTT');

-- 대상 문자열의 왼쪽부터 지정한 자릿수까지 지정한 문자로 채움
select  LPAD('Page 1', 10, '*');

-- 대상 문자열의 지정한 문자를 원하는 문자로 변경함
select  REPLACE('JACK & JUE', 'J', 'BL');

-- 대상 문자열의 오른쪽부터 지정한 자릿수까지 지정한 문자로 채움
select  RPAD('AbC', 5, '*');

-- 대상 문자열의 지정된 자리에서부터 지정된 길이만큼 잘라서 반환함
select  SUBSTR('ABCDEFG', 3, 4);

-- 대상 문자열의 양쪽에서 지정된 문자를 삭제함(문자열만 넣으면 기본값으로 공백 제거)
select  TRIM('=' FROM '==BROWNING==');

-- 대상 문자열을 모두 대문자로 변환함
select  UPPER('mr. scott');

-- 대상 알파벳 문자의 아스키코드 값을 반환함
select  ASCII('D') ;

-- 대상 문자열의 byte를 반환함(알파벳은 1byte, 한글은 3byte(UTF-8))
select  LENGTH('CANDIDE');
select  LENGTH('대한 민국'); # 공백은 아스키코드로 인식하여 1byte

-- 문자열의 문자 수를 반환함
select  CHAR_LENGTH('데이터');
select  CHAR_LENGTH('APPLE');

select * from Book;

SELECT	bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, 
		price
FROM	Book;

#[4-5]
SELECT 	bookname '제목', CHAR_LENGTH(bookname) '문자수',	
		LENGTH(bookname) '바이트수'
FROM 	Book
WHERE 	publisher='굿스포츠';
select * from Book;

SELECT	bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, 
		price
FROM	Book;

#[4-5]
SELECT 	bookname '제목', CHAR_LENGTH(bookname) '문자수',	
		LENGTH(bookname) '바이트수'
FROM 	Book
WHERE 	publisher='굿스포츠';

select * from  Customer;

SELECT	SUBSTR(name, 1, 1) '성', COUNT(*) '인원'
FROM	Customer
GROUP BY	SUBSTR(name, 1, 1); #sql의 index 카운트는 1번부터 시작한다.

SELECT * FROM ORDERS;

SELECT	orderid '주문번호', orderdate '주문일', 
ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
FROM	Orders;

#[4-8]
SELECT	orderid '주문번호', DATE_FORMAT(orderdate, '%Y-%m-%d') '주문일', 
custid '고객번호', bookid '도서번호'
FROM	Orders
WHERE	orderdate= STR_TO_DATE('20240707', '%Y%m%d');

SELECT SYSDATE(),
DATE_FORMAT(SYSDATE(), '%Y/%m/%d %a %h:%i')  'SYSDATE_시스템날짜시간';

select * from Customer ;

SELECT	name '이름', IFNULL(phone, '연락처없음') '전화번호' 
FROM	Customer;

-- Mybook 스키마 생성 -- MySQL
CREATE TABLE Mybook (
  bookid      INTEGER,
  price       INTEGER 
);

-- Mybook 데이터 생성
INSERT INTO Mybook VALUES(1, 10000);
INSERT INTO Mybook VALUES(2, 20000);
INSERT INTO Mybook VALUES(3, NULL);

COMMIT;

SELECT SUM(price), AVG(price), COUNT(*), COUNT(price) FROM mybook;

SELECT SUM(price), AVG(price), COUNT(*), COUNT(price) FROM mybook WHERE bookid >= 4;

SELECT * FROM mybook WHERE price IS NULL; #NULL과 공백은 다름

SELECT name '이름', IFNULL(phone, '연락처없음,') FROM customer;

SET @seq:=0; #@룰 붙이면 변수가 되고 SET 과 := 를 이용하면 치환문이 된다.
SELECT (@seq:=@seq+1) '연번', custid, name, phone FROM customer WHERE @seq < 2;

SELECT orderid, saleprice FROM orders WHERE saleprice < (SELECT AVG(saleprice) FROM orders);

SELECT orderid, custid, saleprice FROM orders o1 WHERE saleprice > (
SELECT AVG(saleprice) FROM orders o2 WHERE o1.custid = o2.custid);

SELECT SUM(saleprice) 'total' FROM orders WHERE custid IN (
SELECT custid FROM customer WHERE address LIKE '%대한민국%');

SELECT orderid, saleprice FROM orders WHERE saleprice > ALL (SELECT saleprice FROM orders WHERE custid=3);

SELECT SUM(saleprice) 'total' FROM orders od WHERE EXISTS 
(SELECT * FROM customer cs WHERE address LIKE '%대한민국%' AND od.custid = cs.custid);

SELECT (SELECT name FROM customer cs WHERE cs.custid = od.custid) 'name' , SUM(saleprice) 'total' FROM orders od GROUP BY od.custid;

ALTER TABLE orders ADD bname VARCHAR(40);

UPDATE orders SET bname = '피겨 교본'
WHERE bookid = 1;
select * from book;
select * from orders;
UPDATE orders SET bname = (SELECT bookname FROM book WHERE book.bookid = orders.bookid);

SELECT cs.name, SUM(od.saleprice) 'total' FROM 
(SELECT custid, name FROM customer WHERE custid<=2) cs, orders od WHERE od.custid = cs.custid GROUP BY cs.custid;