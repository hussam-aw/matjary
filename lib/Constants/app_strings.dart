// Database Strings
const String appDatabaseName = 'MatjaryDatabase.db';
const String accountsTableName = 'Accounts';
const String productsTableName = 'Products';
const String ordersTableName = 'Orders';
const String transactionsTableName = 'Transactions';
const List<String> createTableQueries = [
  '''CREATE TABLE $accountsTableName 
        (id integer primary key autoincrement, 
        name TEXT NOT NULL, 
        email TEXT, 
        address TEXT, 
        phone TEXT,
        balance REAL NOT NULL,
        type INTEGER NOT NULL,
        style INTEGER NOT NULL,
        avatar TEXT)''',
  '''CREATE TABLE $productsTableName 
        (id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL, 
        category INTEGER, 
        wholesale_price REAL NOT NULL, 
        retail_price REAL NOT NULL, 
        supplier_price REAL NOT NULL,
        quantity REAL NOT NULL,
        initial_price REAL NOT NULL,
        affected_exchange TEXT NOT NULL, 
        images TEXT)''',
  '''CREATE TABLE $ordersTableName 
        (id INTEGER PRIMARY KEY AUTOINCREMENT, 
        total REAL NOT NULL, 
        customer_id INTEGER NOT NULL, 
        notes TEXT NOT NULL, 
        type TEXT NOT NULL, 
        paid_up REAL NOT NULL, 
        rest_of_the_bill REAL NOT NULL,
        ware_id INTEGER NOT NULL,
        bank_id INTEGER NOT NULL,
        sell_type TEXT NOT NULL, 
        status INTEGER NOT NULL,
        expenses REAL,  
        discount REAL, 
        discountType TEXT NOT NULL,  
        marketerId INTEGER, 
        marketerFee REAL, 
        marketerFeeType TEXT NOT NULL,   
        details TEXT NOT NULL)''',
  '''CREATE TABLE $transactionsTableName 
        (id INTEGER PRIMARY KEY AUTOINCREMENT, 
        firstSideId INTEGER NOT NULL, 
        secondSideId INTEGER NOT NULL, 
        statement TEXT NOT NULL, 
        amount REAL NOT NULL, 
        date TEXT NOT NULL)'''
];
