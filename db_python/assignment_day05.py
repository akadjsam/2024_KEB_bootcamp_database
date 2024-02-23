import pymysql


#data base connect values reset
# my_host = 'localhost'
# my_port = 3306
# my_database = 'madang'
# username = 'root'
# my_password = 'a0b5c6d0@'

def connect_db():#my_host, username, my_password, my_database, my_port): #checking connection
    """
    params : host, port, database, username, passwd
    params type : str, int, str, str, str
    return : tuple
    """
    my_host = 'localhost'
    my_port = 3306
    my_database = 'madang'
    username = 'root'
    my_password = 'a0b5c6d0@'
    conflag = True
    try:
        print('Try connecting database')
        conn = pymysql.connect(host=my_host, user=username, 
                            passwd=my_password, db=my_database,port=my_port, charset='utf8') # mysql에 접속하는 함수
        print('Success connecting database')
        return conflag, conn
    except Exception as error:
        print('Fail connecting database : ',end='')
        conflag = False
        print(error)
        return

    

def get_view(number,db_data): 
    """
    this function excute 'create, replace, print view'
    params : number, (conflag, conn)
    params type : int, tuple
    return : void
    """
    def execute_quary(): #inner function
        res = cursor.execute(sql_str) # execute squary
        data = cursor.fetchall() # all record
        return data
    
    #if success connecting database
    if db_data[0]:
        #create cursor object
        cursor = db_data[1].cursor()
        if number == 1:
            sql_str = create_view()
            execute_quary()

        elif number == 2:
            sql_str = print_bk_cs_name()
            print_record(execute_quary())

        elif number == 3:
            sql_str = replace_view()
            execute_quary()

    cursor.close
    db_data[1].close

def create_view(): #create view (1)
    """
    return : str
    """
    return f'CREATE VIEW highorders (bookid,bookname,name,publisher,saleprice)\
            AS SELECT od.bookid, bookname, name, publisher, saleprice\
            FROM customer cs, orders od, book bk\
            WHERE od.custid = cs.custid AND od.bookid = bk.bookid AND saleprice = 20000;'

def print_bk_cs_name(): # print book and customer's name (2)
    """
    return : str
    """
    return f'SELECT bookname, name FROM highorders;'

def replace_view(): #replace (3)
    """
    return : str
    """
    return 'CREATE OR REPLACE VIEW highorders (bookid,bookname,name,publisher)\
            AS SELECT od.bookid, bookname, name, publisher \
            FROM customer cs, orders od, book bk \
            WHERE od.custid = cs.custid AND od.bookid = bk.bookid AND saleprice = 20000;'    
    
def print_record(data)->tuple: # print view or table
        """
        params : tuple
        return : void
        """
        print('{0}\t{1:<}\t{2:<}\t{3:>}'.format('bookid','bookname','publisher','price'))
        # print record
        for rowdata in data:
            for i in range(len(rowdata)):
                print(rowdata[i],end="\t")
            print()


if __name__ == '__main__':
    db_data = connect_db()#'localhost', 'root',' a0b5c6d0@', 'madang', 3306) # data base connect values reset
    print(db_data)
    while True:
        value = input("Input number     1)create view     2)print book name, customer name     3)replace view : ")
        if value == '1':
             get_view(1, db_data)
        elif value == '2':
            get_view(2, db_data)
        elif value == '3':
            get_view(3, db_data)
            break
        else:
            print("retry!!")
   
