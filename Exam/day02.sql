use madang;

SELECT * FROM Book;

SELECT * FROM Book WHERE publisher IN('굿스포츠','대한미디어'); # 굿스포츠, 대한미디어에 속하는 모든 필드를 가져오기

SELECT * FROM Book WHERE publisher NOT IN('굿스포츠', '대한미디어'); # 굿스포츠, 대한미디어가 아닌 필드가 출력

SELECT bookname, publisher FROM BooK WHERE bookname LIKE '축구의 역사'; # 해당 책 이름을 가지고있는 책과 출판사를 출력

SELECT bookname, publisher FROM Book WHERE bookname LIKE '%축구%'; # 축구라는 문자열을 포함하는 책과 출판사 출력

SELECT bookname, publisher FROM Book WHERE bookname LIKE '%축구%';

SELECT * FROM Book WHERE bookname LIKE '%축구%' AND price >= 20000;

SELECT * FROM Book;

SELECT * FROM Book WHERE publisher = '굿스포츠' OR publisher = '대한미디어'; 

SELECT * FROM Book ORDER BY bookname ASC; # 책이름 기준으로 오름차순정렬(기본)
SELECT * FROM Book ORDER BY bookname DESC; # 책이름 기준으로 내림차순정렬

SELECT * FROM Book ORDER BY price, bookname; # 가격순으로 오름차순정렬, 가격이 같다면 책 이름 순서로 정렬

SELECT * FROM Book ORDER BY price DESC, bookname ASC;

SELECT SUM(price) FROM Book;
SELECT AVG(price) FROM Book;

CREATE TABLE Customer
(
	custid Integer primary key,
    name varchar(40),
    address varchar(50),
    phone varchar(20)
);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스터', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '김연경', '대한민국 경기도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);
SELECT * FROM Customer;

CREATE TABLE Orders
(
	orderid Integer primary key,
    custid Integer REFERENCES Customer(custid),
    bookid Integer REFERENCES Book(bookid),
    saleprice Integer,
    orderdate DATE
);

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2024-07-01','%Y-%m-%d'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2024-07-04','%Y-%m-%d'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2024-07-05','%Y-%m-%d'));

INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2024-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2024-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2024-07-08','%Y-%m-%d'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2024-07-09','%Y-%m-%d'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2024-07-10','%Y-%m-%d'));

SELECT * FROM Orders;
SELECT SUM(saleprice) AS '총매출' FROM Orders;

SELECT SUM(saleprice) AS '총매출' FROM Orders WHERE custid = 2;

SELECT SUM(saleprice) AS Total, AVG(saleprice) AS Avarage, MIN(saleprice) AS Minimun, MAX(saleprice) AS MAXIMUN FROM Orders;

SELECT COUNT(*) FROM Orders;

SELECT custid, COUNT(*) as 도서수량, SUM(saleprice) as 총액 FROM Orders GROUP BY custid ORDER BY custid desc; # order by는 group by 뒤에 위치한다.

SELECT custid, COUNT(*) as 도서수량, SUM(saleprice) as 총액 FROM Orders GROUP BY custid ORDER BY SUM(saleprice) desc; 

# SELECT * FROM Orders GROUP BY custid; # 에러 -> group by를 기준으로 그룹화 했기 때문에 select 뒤에는 custid만 올 수 있다. 그러나 sum,avg,count와 같은 집계 함수들은 올 수 있다. 

-- group by는 기준이고, having은 group by와 같이 쓰여진다.
SELECT custid, count(*) AS 도서수량 FROM Orders WHERE saleprice >=8000 GROUP BY custid HAVING COUNT(*) >= 2;

SELECT custid, count(*) AS 도서수량 FROM Orders WHERE saleprice >=8000 AND COUNT(*) >= 2 order by custid;

SELECT * FROM Customer, orders; # 5 * 10 해서 50개의 레코드가 출력된다.(cross join)

SELECT * FROM Customer, orders WHERE Customer.custid = Orders.custid;

SELECT * FROM Customer, orders WHERE Customer.custid = Orders.custid ORDER BY Customer.custid;

-- customer.name에서 .name은 생략 가능
SELECT Customer.name, Orders.saleprice FROM Customer, Orders WHERE Customer.custid = Orders.custid;

SELECT Customer.name, SUM(Orders.saleprice) FROM Customer, Orders WHERE Customer.custid = Orders.custid GROUP BY Customer.name ORDER BY Customer.name;

SELECT Customer.name, Book.bookname FROM Customer, Orders, Book WHERE Customer.custid = Orders.custid AND Orders.bookid = Book.bookid;

SELECT Customer.name, Book.bookname FROM Customer, Orders, Book WHERE Customer.custid = Orders.custid AND Orders.bookid = Book.bookid AND Book.price = 20000;

SELECT Customer.name, saleprice FROM Customer LEFT OUTER JOIN Orders ON Customer.custid = Orders.custid;

SELECT Book.bookname FROM Book WHERE price = (SELECT MAX(price) FROM Book); # 책 중 가장 비싼 책 출력. 부속질의

SELECT bookid FROM Book WHERE publisher = '대한미디어';
SELECT custid FROM Orders WHERE bookid IN (3,4);
SELECT name FROM Customer WHERE custid = 1;

SELECT name FROM Customer WHERE custid IN 
(SELECT custid FROM Orders WHERE bookid IN
(SELECT bookid FROM Book WHERE publisher = '대한미디어'));


SELECT avg(price) FROM Book;

SELECT b1.bookname FROM Book b1 WHERE b1.price > (SELECT AVG(b2.price) FROM Book b2 WHERE b2.publisher = b1.publisher); #상관 부속질의

SELECT Customer.name FROM Customer WHERE Customer.address LIKE '대한민국%'; #대한민국으로 시작하는 주소의 고객 출력
SELECT name from Customer WHERE custid IN (SELECT custid FROM Orders); # 주문한 적이 있는 고객 출력

SELECT Customer.name FROM Customer WHERE Customer.address LIKE '대한민국%' UNION
SELECT name from Customer WHERE custid IN (SELECT custid FROM Orders); # 합집합, 김연아 김연경이 중복되므로 한개만 표시

SELECT Customer.name FROM Customer WHERE Customer.address LIKE '대한민국%' UNION ALL
SELECT name from Customer WHERE custid IN (SELECT custid FROM Orders); # ALL 붙이면 중복을 포함한 모든 결과 표시