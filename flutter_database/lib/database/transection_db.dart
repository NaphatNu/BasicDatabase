import 'dart:io';

import 'package:flutter_database/models/transections.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransectionDB {
  //บริการเกี่ยวกับฐานข้อมูล

  String dbName; //เก็บชื่อฐานข้อมูล

  //ถ้ายังไม่ถูกสร้าง => สร้าง
  //ถูกสร้างไว้แล้ว => เปิด
  TransectionDB({required this.dbName});

  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //สร้าง database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(transections statement) async {
    //ฐานข้อมูล => Store
    //Transection.db => expense
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String(),
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมูล
  Future<List<transections>> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db);
    List<transections> transectionList = [];
    for (var Record in snapshot) {
      transectionList.add(transections(
          title: Record["title"].toString(),
          amount: double.parse(Record["amount"].toString()),
          date: DateTime.parse(Record["date"].toString())));
          print(snapshot);
    }

    return transectionList;
  }
}
