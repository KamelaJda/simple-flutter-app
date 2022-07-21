import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/idatabasemodel.dart';

class DatabaseUtils {

  static Database? database;

  static Future<void> insert(IDatabaseModel dbm) async {
    try {
      await database!.insert(dbm.getTableName(),
          dbm.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace
      );
    } catch (e) {
      print("ERROR! $e");
    }
  }

  static Future<List<T?>> retrieveAll<T extends IDatabaseModel>(String tableName, Function fun) async {
    final List<Map<String, dynamic>> maps = await database!.query(tableName);

    return List.generate(maps.length, (i) {
      return fun(maps[i]);
    });
  }

  static Future<int> getNextId(String tableName) async {
    final List<Map<String, dynamic>> maps = await database!.query(tableName, columns: ["id"], orderBy: "id DESC", limit: 1);
    var nextId = maps[0]['id'];
    for (var v in maps) {
      print("FIRST: ${v.values.toSet()}");
    }
    print("nextId: ${maps}");
    return nextId + 1;
  }

  static Future<void> delete(IDatabaseModel databaseModel) async {
    await database!.delete(databaseModel.getTableName(),
        where: 'id = ?',
        whereArgs: [databaseModel.getId()]
    );
  }

  static void configure() async {
    try {
      var databasesPath = await getDatabasesPath();
      try {
        await Directory(databasesPath).create(recursive: true);
      } catch (_) {}

      database = await openDatabase(
        join(databasesPath, 'tak.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE IF NOT EXISTS shops(id INTEGER PRIMARY KEY, name TEXT, address TEXT);',
          );
        },

        version: 1,

      );
    } catch (e) {
      print("Error $e");
    }

    print("Database is configured: " + database.toString());
  }


}