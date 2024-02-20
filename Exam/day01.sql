# 주석처리방법 : # 또는 --

create database madang;
use madang;

-- book 이라는 테이블 생성. primary key는 고유 번호를 뜻한다.
create TABLE Book
(
	bookid integer primary key,
    bookname varchar(40),
    publisher varchar(40),
    price integer
);

-- 새로운 계정 생성(root 계정에서 로그인 한 상태에서 생성이 가능함.)
-- identified는 계정의 암호를 생성하는 예약어
create user madang@localhost identified by 'madang';

-- 환경설정 파일들은 끝에 db가 붙는다. 생성한 계정에 마당 테이블에 접속할 수 잇는 권한을 주는 과정
grant all privileges on madangdb.* to madang@localhost;

-- 위에있는 명령 실행을 완료한다는 뜻. 오라클에서는 commit 실행을 안해주면 반영이 안된다.
commit;

-- Book 테이블에 투플(레코드,row) 삽입, 문장이 길기 때문에 2줄로 작성
INSERT INTO Book(bookid, bookname, publisher, price)
values(1, '축구의 역사', '굿스포츠', 7000);

#SELECT bookid,bookname,publisher,price FROM book;
-- * : Book 테이블에 있는 모든 속성을 불러온다.
SELECT * FROM madang.Book;


-- INSERT INTO madang.Book(bookid, bookname) # 2개만 값을 대입시 ()를 무조건 사용해야 함, bookid는 primary key이기 때문에 null값이 들어가면 안됨
-- values(2, '축구하는 여자'); # 2개만 값을 대입했기 떄문에 values에도 마찬가지로 2개 입력

INSERT INTO madang.Book
values(2, '축구하는 여자','나무수', 13000); 

SELECT * FROM book;

INSERT INTO madang.book values(3, '축구의 이해', '대한미디어', 22000);
SELECT * FROM madang.book;

INSERT INTO madang.book values(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO madang.book values(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO madang.book values(6, '배구 단계별기술', '굿스포츠', 6000);
INSERT INTO madang.book values(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO madang.book values(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO madang.book values(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO madang.book values(10, 'Olympic Champions', 'Pearson', 13000);
SELECT * FROM madang.book;
SELECT publisher, bookname FROM madang.book; #불러올때는 순서가 상관없다.

SELECT DISTINCT publisher FROM Book; #중복된 값을 한개씩만 불러오기 DISTINCT

SELECT * FROM Book WHERE price < 10000; #WHERE 조건으로 1만원 이하의 값들만 불러오기
 
SELECT * FROM Book WHERE price BETWEEN 10000 AND 20000;

SELECT * FROM Book WHERE price >= 10000 AND price <=20000;
