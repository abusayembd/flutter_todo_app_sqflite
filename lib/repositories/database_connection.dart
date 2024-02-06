
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
setDatabase() async {
  var directory = await getApplicationDocumentsDirectory();
  var path = join(directory.path, 'db_todolist_sqflite');
  var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
  return database;
}

  FutureOr<void> _onCreatingDatabase(Database database, int version)async {
  await database.execute('CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)');
    //create table todos
    await database.execute('CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, category TEXT, todoDate TEXT, isFinished INTEGER)');
}



}