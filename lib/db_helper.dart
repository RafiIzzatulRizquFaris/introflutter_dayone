import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "task.db";
    var createDb = openDatabase(path, version: 1, onCreate: onCreateDatabase,);
    return createDb;
  }

  FutureOr<void> onCreateDatabase(Database db, int version) async {
    await db.execute('''
    create table task (
    id integer primary key autoincrement,
    title text not null,
    description text not null
    )
    ''');
  }
}