import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:flutter_database/models/transactions.dart';

class TransactionDB {
  String dbName; // เก็บชื่อฐานข้อมูล

  // Constructor บังคับใส่ชื่อ dbName
  TransactionDB({required this.dbName});

  // ฟังก์ชันเปิดฐานข้อมูล
  Future<Database> openDatabase() async {
    // ใช้ getApplicationDocumentsDirectory เพื่อเก็บข้อมูลถาวร
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  // ฟังก์ชันบันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    // ต้องใส่ await เพื่อรอให้การบันทึกสำเร็จและคืนค่า Key กลับมา
    var keyID = await store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String(),
    });

    return keyID;
  }

  // ฟังก์ชันดึงข้อมูลทั้งหมด
  Future<List<Transactions>> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    // เรียงลำดับข้อมูลจากใหม่ไปเก่า (ตามวันที่)
    var finder = Finder(sortOrders: [SortOrder('date', false)]);
    var snapshot = await store.find(
      db,
      finder: Finder(sortOrders: [SortOrder(Field.key, false)]),
    );

    // ประกาศ List รูปแบบใหม่แทน List<Transactions>() ที่เลิกใช้แล้ว
    List<Transactions> transactionList = [];

    for (var record in snapshot) {
      transactionList.add(
        Transactions(
          title: record["title"].toString(),
          amount: double.parse(record["amount"].toString()),
          date: DateTime.parse(record["date"].toString()),
        ),
      );
    }

    return transactionList;
  }
}
