import 'package:introflutter_dayone/db_helper.dart';
import 'package:introflutter_dayone/task.dart';
import 'package:sqflite/sqflite.dart';

class Operation{

  DatabaseHelper helper = DatabaseHelper();
  static const table_name = 'task';
  static const col_id = 'id';
  static const col_title = 'title';
  static const col_desc = 'description';

  Future<List<Task>> getAllSelect() async{
    Database db = await helper.initDb();
    List<Map<String, dynamic>> mapList = await db.query(table_name);
    List<Task> listTask = List<Task>();
    for(int i = 0; i < mapList.length; i++){
      listTask.add(Task.fromJson(mapList[i]));
    }
    return listTask;
  }

  Future<int> insertData(Task task) async{
    Database db = await helper.initDb();
    int result = await db.insert(table_name, task.toJson());
    return result;
  }

  Future<int> deleteData(Task task) async{
    Database db = await helper.initDb();
    int result = await db.delete(table_name, where: "id=?", whereArgs: [task.id],);
    return result;
  }

  Future<int> updateData(Task task) async{
    Database db = await helper.initDb();
    int result = await db.update(table_name, task.toJson(), where: "id=?", whereArgs: [task.id]);
    return result;
  }
}