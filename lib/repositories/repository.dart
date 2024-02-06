import 'package:flutter_todolist_sqflite_app/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  //initialize Repository class
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  //check if database exists or not
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _databaseConnection.setDatabase();
    return _database!;
  }

  //insert data to table
  Future<int> insertData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    // Remove the 'id' from the data if it's not null
    if (data['id'] != null) {
      data.remove('id');
    }
    return await connection.insert(table, data);
  }

  //read data from table
  Future<List<Map<String, dynamic>>> readData(String table) async {
    var connection = await database;
    return await connection.query(table);
  }

  // Read a category by its ID from the table
  readDataById(table, itemID) async {
    var connection = await database;
    return await connection.query(table, where: 'id = ?', whereArgs: [itemID]);
  }

  // Update data from table
  updateData(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  // Delete data from table
  deleteData(table, itemId)async {
    var connection = await database;
    return await connection.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }

  // Read data from table by column name
  readDataByColumnName(String table, String columnName, String columnValue) async {
    var connection = await database;
    return await connection.query(table, where: '$columnName = ?', whereArgs: [columnValue]);
  }
}
