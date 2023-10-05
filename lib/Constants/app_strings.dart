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
        categoryId INTEGER, 
        wholesalePrice REAL NOT NULL, 
        retailPrice REAL NOT NULL, 
        supplierPrice REAL NOT NULL,
        quantity REAL NOT NULL,
        initial_price REAL NOT NULL,
        affectedExchange TEXT NOT NULL, 
        images TEXT)''',
  '''CREATE TABLE $ordersTableName 
        (id INTEGER PRIMARY KEY AUTOINCREMENT, 
        total REAL NOT NULL, 
        customerId INTEGER NOT NULL, 
        notes TEXT NOT NULL, 
        type TEXT NOT NULL, 
        paidUp REAL NOT NULL, 
        restOfTheBill REAL NOT NULL,
        wareId INTEGER NOT NULL,
        bankId INTEGER NOT NULL,
        sellType TEXT NOT NULL, 
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
