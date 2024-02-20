use madang;

SELECT * FROM Book;

SELECT * FROM Book WHERE publisher IN('굿스포츠','대한미디어'); # 굿스포츠, 대한미디어에 속하는 모든 필드를 가져오기

SELECT * FROM Book WHERE publisher NOT IN('굿스포츠', '대한미디어'); # 굿스포츠, 대한미디어가 아닌 필드가 출력