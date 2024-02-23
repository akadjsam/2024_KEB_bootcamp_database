import pymysql


#data base connect values reset
my_host = 'localhost'
my_port = 3306
my_database = 'madang'
username = 'root'
my_password = 'a0b5c6d0@'

#checking connection
conflag = True

try:
    print('Try connecting database')
    conn = pymysql.connect(host=my_host, user=username, 
                        passwd=my_password, db=my_database,port=my_port, charset='utf8') # mysql에 접속하는 함수
    print('Success connecting database')
except Exception as error:
    print('Fail connecting database : ',end='')
    conflag = False
    print(error)
    pass

def get_book_by_id(pbookid):
    #if success connecting database
    if conflag:
        #create cursor object
        cursor = conn.cursor()
        sql_str = f'SELECT bookname FROM book WHERE bookid = {pbookid};' # mysql quary
        res = cursor.execute(sql_str) # execute squary
        data = cursor.fetchall() # all record

        if data == ():
            return
        
        print('{0}\t{1:<}\t{2:<}\t{3:>}'.format('bookid','bookname','publisher','price'))
        
        # print record
        for rowdata in data:
            for i in range(len(rowdata)):
                print(rowdata[i],end="\t")
            print()

    cursor.close
    conn.close

def get_book_by_name(pbookname):
    pbookname = " ".join(pbookname)
    #if success connecting database
    if conflag:
        #create cursor object
        cursor = conn.cursor()
        sql_str = f'SELECT * FROM book WHERE bookname = "{pbookname}";' # mysql quary
        res = cursor.execute(sql_str) # execute squary
        data = cursor.fetchall() # all record

        if data == ():
            return
        
        print('{0}\t{1:<}\t{2:<}\t{3:>}'.format('bookid','bookname','publisher','price'))
        
        # print record
        for rowdata in data:
            for i in range(len(rowdata)):
                print(rowdata[i],end="\t")
            print()

    cursor.close
    conn.close

if __name__ == '__main__':
    #bookid = int(input('Input bookid : '))
    #get_book_by_id(bookid)
    bookname = input('Input bookname : ').split()
    get_book_by_name(bookname)
