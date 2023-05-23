import 'package:flutter/foundation.dart';
import 'package:flutter_database/database/transection_db.dart';
import 'package:flutter_database/models/transections.dart';

class TransectionProvider with ChangeNotifier{
  List<transections> transection = [];


  List<transections> getTransection(){
    return transection;
  }
  void initData() async{
    var db = TransectionDB(dbName: "transections.db");
    //ดึงข้อมูลมาแสดงผล
    transection = await db.loadAllData();
    notifyListeners();
  }

  void addTransection(transections statement) async{
    var db = TransectionDB(dbName: "transections.db");
    //บันทึกข้อมูล
    await db.InsertData(statement);
    
    //ดึงข้อมูลมาแสดงผล
    transection = await db.loadAllData();
    //transection.insert(0,statement);

    //แจ้งเตือน consumer
    notifyListeners();
  }
}