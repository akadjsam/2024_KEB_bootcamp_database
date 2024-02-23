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

#if success connecting database
if conflag:
    #create cursor object
    cursor = conn.cursor()
    sql_str = 'SELECT * FROM book;' # mysql quary
    res = cursor.execute(sql_str) # execute squary
    data = cursor.fetchall() # all record
    print(type(data))

    print('{0}\t{1:<}\t{2:<}\t{3:>}'.format('bookid','bookname','publisher','price'))

    # print record
    for rowdata in data:
        for i in range(len(rowdata)):
            print(rowdata[i],end="\t")
        print()

cursor.close
conn.close

