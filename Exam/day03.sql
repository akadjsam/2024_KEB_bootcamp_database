use madang;

SELECT * FROM customer;


SELECT custid FROM orders;
SELECT name FROM customer WHERE custid IN (1,2,3,4);
SELECT name FROM customer WHERE address LIKE '대한민국%' AND name NOT IN (SELECT name FROM customer WHERE custid IN (1,2,3,4));

#같은 내용 부속질의로 작성
SELECT name 
	FROM customer
		WHERE address LIKE '대한민국%' AND
			name NOT IN (SELECT name 
						 FROM customer
						 WHERE custid IN (SELECT custid FROM orders));
                 
		
SELECT name 
	FROM customer 
		WHERE address LIKE '대한민국%' AND
			name IN (SELECT name 
					 FROM customer
					 WHERE custid IN (SELECT custid FROM orders));
                     
SELECT name, address
	FROM customer
		WHERE
			EXISTS (SELECT * FROM orders WHERE customer.custid = orders.custid);

-- CREATE TABLE 	NewBook (
--   bookname		VARCHAR(20)	NOT NULL,
--   publisher		VARCHAR(20)	UNIQUE,
--   price		INTEGER DEFAULT 10000 CHECK(price > 1000),
--   PRIMARY KEY	(bookname, publisher)
--   );
--   
--   
-- CREATE TABLE	NewBook (
--   bookid		INTEGER,
--   bookname		VARCHAR(20),
--   publisher		VARCHAR(20),
--   price		INTEGER,
--   PRIMARY KEY	(bookid)
--   );

-- CREATE TABLE newbook (
-- 	bookname		VARCHAR(20),
-- 	publisher		VARCHAR(20),
-- 	price 		INTEGER,
-- 	PRIMARY KEY	(bookname, publisher)
-- );

CREATE TABLE	newbook (
  bookid		INTEGER	PRIMARY KEY,
  bookname		VARCHAR(20),
  publisher		VARCHAR(20),
  price		INTEGER
  );
    
CREATE TABLE newcustomer (
	custid INTEGER PRIMARY KEY,
	name VARCHAR(40),
	address VARCHAR(40),
	phone VARCHAR(30)
);
  
CREATE TABLE neworders (
	orderid	INTEGER,
	custid	INTEGER	NOT NULL,
	bookid	INTEGER	NOT NULL,
	saleprice INTEGER,
	orderdate DATE,
	PRIMARY KEY(orderid),
	FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE,
    FOREIGN KEY(bookid) REFERENCES newbook(bookid) ON DELETE CASCADE
);
SELECT * FROM newbook;

ALTER TABLE newbook ADD isbn VARCHAR(20); #테이블에 isbn 속성 추가

SELECT * FROM newbook;

ALTER TABLE newbook MODIFY isbn INTEGER; #isbn을 int 타입으로 변경 

ALTER TABLE newbook DROP COLUMN isbn;

ALTER TABLE newbook MODIFY bookname varchar(20) NOT NULL; 

#기본키 변경
DROP TABLE neworders;
DROP TABLE newbook;

CREATE TABLE newbook(
	bookname VARCHAR(20) PRIMARY KEY,
	bookid INTEGER,  
	publisher VARCHAR(20),
	price INTEGER
);
#ALTER TABLE newbook ADD PRIMARY KEY(bookid); #bookname이 primary key이기 때문에 bookid를 기본키로 설정할 수 없음

ALTER TABLE newbook DROP PRIMARY KEY;
ALTER TABLE newbook ADD PRIMARY KEY(bookid);

INSERT INTO Book(bookid, bookname, publisher, price) VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
INSERT INTO Book VALUES (12, '스포츠 의학', '한솔의학서적', 90000);
INSERT INTO Book(bookid, bookname, price, publisher) VALUES (13, '스포츠 의학', 90000, '한솔의학서적');
INSERT INTO Book(bookid, bookname, publisher) VALUES (14, '스포츠 의학', '한솔의학서적');

SELECT * FROM book;

CREATE TABLE Imported_Book (
  bookid		INTEGER,
  bookname	VARCHAR(40),
  publisher	VARCHAR(40),
  price		INTEGER
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

SELECT * FROM Imported_Book;

SELECT publisher FROM imported_book WHERE bookid = 21;
INSERT INTO book(bookid, bookname, publisher, price) SELECT * FROM imported_book;

# 여기서 WHERE 조건을 붙이지 않으면 address가 전부 '대한민국 부산'으로 값이 바뀐다.
UPDATE customer SET address = '대한민국 부산' WHERE custid = 5;
select * from customer;

select * from book;
UPDATE book SET publisher = (SELECT publisher FROM imported_book WHERE bookid = 21) WHERE bookid = 14;