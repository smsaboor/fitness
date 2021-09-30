// import 'package:flutter/cupertino.dart';
// import 'package:fitness/model/model_setting.dart';
// import 'package:fitness/model/model_user.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
//
//
// class DataHelper {
//   //--------------------------- Common implementation for all Assets (Gold, Silver, Cash-in-hand, Cash-in-Bank)------------
//   static DataHelper _databaseHelper; // Define Singleton DatabaseHelper object
//   static Database _database; // Define Singleton Database object
//   static var total;
//   DataHelper._createInstance();
//   factory DataHelper() {
//     if (_databaseHelper == null) {
//       _databaseHelper = DataHelper._createInstance();
//     }
//     return _databaseHelper;
//   }
//
//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await initializeDatabase();
//     }
//     return _database;
//   }
//
//   Future<Database> initializeDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = directory.path + 'fitness1.db';
//     var assetDatabase = await openDatabase(path,
//         version: 3,
//         onCreate: _createDb,
//         onUpgrade: _upgradeDb,
//         onOpen: _openDb);
//
//     return assetDatabase;
//   }
//
//   var resultsettion;
//   void _createDb(Database db, int newVersion) async {
//     await db.execute(
//         'CREATE TABLE user(userId INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT NOT NULL UNIQUE, password TEXT, registrationDate TEXT, isPaid TEXT, age INTEGER, paymentDate TEXT, city TEXT, pin INTEGER, familyId  INTEGER, photoUrl TEXT)');
//     await db.execute(
//         'CREATE TABLE setting2(settingId INTEGER PRIMARY KEY AUTOINCREMENT, country TEXT, currency TEXT, nisab DOUBLE, startDate TEXT, endDate TEXT, goldRate18C DOUBLE, goldRate20C DOUBLE, goldRate22C DOUBLE, goldRate24C DOUBLE, silverRate18C DOUBLE, silverRate20C DOUBLE, silverRate22C DOUBLE, silverRate24C DOUBLE, userId INTEGER)');
//   }
//
//   void _upgradeDb(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion == 1) {
//       await db.execute("DROP TABLE IF EXISTS zakatPayed");
//       await db.execute("DROP TABLE IF EXISTS zakat");
//     }
//     if (oldVersion <= 2) {
//       await db.execute("ALTER TABLE metal RENAME TO tmp_metal");
//       await db.execute(
//           'CREATE TABLE metal(metalId INTEGER PRIMARY KEY AUTOINCREMENT, item TEXT, weight DOUBLE,carat DOUBLE, date TEXT, note TEXT, type TEXT, userId INTEGER)');
//       await db.execute(
//           "INSERT INTO metal(metalId, item, weight, carat, date, note, type, userId) SELECT metalId, item, weight, carat, dateOfPurchase, note, type, userId FROM tmp_metal");
//       await db.execute("DROP TABLE tmp_metal");
//       await db.execute("ALTER TABLE user ADD COLUMN name TEXT");
//       await db.execute("ALTER TABLE user ADD COLUMN photoUrl TEXT");
//     }
//   }
//
//   void _openDb(Database db) async {
//     //await db.execute("ALTER TABLE user ADD COLUMN name TEXT");
//     //await db.execute("ALTER TABLE user ADD COLUMN photoUrl TEXT");
//     debugPrint('Open Database called @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
//   }
//
//   Future<List<Map<String, dynamic>>> getUserMapList() async {
//     Database db = await this.database;
//     var result = await db.rawQuery('SELECT * FROM user');
//     return result;
//   }
//
//   Future<List<ModelUser>> getUserList() async {
//     var userMapList =
//         await getUserMapList(); // first Get 'Map List' from database
//     int count = userMapList
//         .length; // second Count the number of map entries fetched from  db table
//     List<ModelUser> userList =
//         List<ModelUser>(); //third create empty List of Gold
//     // For loop to copy all the 'Map list object' into our UsersList'
//     for (int i = 0; i < count; i++) {
//       userList.add(ModelUser.fromMapObject(userMapList[i]));
//     }
//     int lnght = userList.length;
//     String lenght = lnght.toString();
//     for (int i = 0; i <= userList.length - 1; i++) {
//       debugPrint(lenght);
//     }
//     return userList; // finally return our Users list
//   }
//
//   Future<List<Map<String, dynamic>>> getUserAuthenticationMapList(
//       String paremail, String pwd) async {
//     Database db = await this.database;
// //    var result = await db.rawQuery('SELECT * FROM user WHERE email=?', ['$paremail']);
//     var result = await db.rawQuery(
//         'SELECT * FROM user WHERE email=? AND password=?',
//         ['$paremail', '$pwd']);
//     return result;
//   }
//
//   Future<List<ModelUser>> getUserAuthentication(
//       String email, String pwd) async {
//     var userAuthenticationMapList = await getUserAuthenticationMapList(
//         email, pwd); // first Get 'Map List' from database
//     int count = userAuthenticationMapList
//         .length; // second Count the number of map entries fetched from  db table
//     List<ModelUser> userList =
//         List<ModelUser>(); //third create empty List of Gold
//     // For loop to copy all the 'Map list object' into our UsersList'
//     for (int i = 0; i < count; i++) {
//       userList.add(ModelUser.fromMapObject(userAuthenticationMapList[i]));
//     }
//
//     int lnght = userList.length;
//     String lenght = lnght.toString();
//     for (int i = 0; i <= userList.length - 1; i++) {
//       debugPrint(lenght);
//     }
//     return userList; // finally return our Users list
//   }
//
//   Future<List<Map<String, dynamic>>> getUserMapByEmail(String email) async {
//     Database db = await this.database;
//     var result =
//         await db.rawQuery('SELECT * FROM user where email=?', ['$email']);
//     return result;
//   }
//
//   Future<ModelUser> getUserByEmail(String email) async {
//     var userMap = await getUserMapByEmail(email);
//     if (userMap != null && userMap.isNotEmpty) {
//       ModelUser user = ModelUser.fromMapObject(userMap[0]);
//       return user;
//     }
//     return null;
//   }
//
//   Future<int> insertUser(ModelUser user) async {
//     Database db = await this.database;
//     var result = await db.insert('user', user.toMap());
//     if (result != 0) {
//       debugPrint('User created in local DB');
//     }
//     else
//       debugPrint('Failed to create user in local DB');
//     return result;
//   }
//
//   Future<int> updateUser(
//     ModelUser user,
//   ) async {
//     var db = await this.database;
//     var result = await db.update('user', user.toMap(),
//         where: 'userId = ?', whereArgs: [user.userId]);
//     return result;
//   }
//
//   Future<int> deleteUser(int id) async {
//     var db = await this.database;
//     int result = await db.rawDelete('DELETE FROM user WHERE userId = $id');
//     return result;
//   }
//
//   Future<int> getUserCount() async {
//     Database db = await this.database;
//     List<Map<String, dynamic>> x =
//         await db.rawQuery('SELECT COUNT (*) from user');
//     int result = Sqflite.firstIntValue(x);
//     return result;
//   }
//
//   //-----------------------------------------------------------------Setting Functions--------------------------------------------------------------------------
//   Future<List<Map<String, dynamic>>> getSettingMapList(int userid) async {
//     Database db = await this.database;
//     var result =
//         await db.rawQuery('SELECT * FROM setting2 WHERE userId=?', ['$userid']);
//     return result;
//   }
//
//   // Get the 'Map List' [ List<Map> ] from the database and convert it to 'Gold List' [ List<ModelGold> ]
//   Future<ModelSetting> getSettingList(int userId) async {
//     var settingMapList =
//         await getSettingMapList(userId); // first Get 'Map List' from database
//     int count = settingMapList
//         .length; // second Count the number of map entries fetched from  db table
//     List<ModelSetting> settingList =
//         List<ModelSetting>(); //third create empty List
//     // For loop to copy all the 'Map list object' into our UsersList'
//     for (int i = 0; i < count; i++) {
//       settingList.add(ModelSetting.fromMapObject(settingMapList[i]));
//     }
//     return settingList.isNotEmpty? settingList.elementAt(0):null; // finally return our Users list
//   }
//
//   Future<int> insertSetting(ModelSetting setting) async {
//     Database db = await this.database;
//     var result = await db.insert('setting2', setting.toMap());
//     return result;
//   }
//
//   Future<int> updateSetting(ModelSetting setting) async {
//     var db = await this.database;
//     var result = await db.update('setting2', setting.toMap(),
//         where: 'settingId = ?', whereArgs: [setting.settingId]);
//     return result;
//   }
//
//   Future<int> deleteSetting(int id) async {
//     var db = await this.database;
//     int result =
//         await db.rawDelete('DELETE FROM setting2 WHERE settingId = $id');
//     return result;
//   }
//
//   Future<int> getSettingCount() async {
//     Database db = await this.database;
//     List<Map<String, dynamic>> x =
//         await db.rawQuery('SELECT COUNT (*) from setting2');
//     int result = Sqflite.firstIntValue(x);
//     return result;
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//   // Get the 'Map List' [ List<Map> ] from the database and convert it to 'Gold List' [ List<ModelGold> ]
//
//
//
//
//
//
//
// } // End of Class
