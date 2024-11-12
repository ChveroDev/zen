import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDataBase {
  static final TaskDataBase instance = TaskDataBase._internal();

  static Database? _database;

  TaskDataBase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/task.db';
    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDatabase,
    );
  }

  Future<void> _dropTables() async {
    return await _database!.execute("DROP TABLE iF EXISTS TASK");
  }

  FutureOr<void> _createDatabase(Database db, int version) async {
    await db.execute('''
        CREATE TABLE TASK (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          difficulty INTEGER NOT NULL,
          isRoot INTEGER NOT NULL,
          isComplete INTEGER NOT NULL,
          forToday INTEGER NOT NULL
        )
      ''');
    await db.execute('''
        CREATE TABLE TASK_CALENDAR (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taskId INTEGER,
          deadline INTEGER NOT NULL,
          FOREIGN KEY(taskId) REFERENCES TASK(id)
        )
      ''');
    print('TASK table created');
    await db.execute('''
        CREATE TABLE COMPOSED_TASK (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taskId INTEGER,
          childTaskId INTEGER,
          FOREIGN KEY(taskId) REFERENCES TASK(id),
          FOREIGN KEY(childTaskId) REFERENCES TASK(id)
        )
      ''');
    await db.execute('''
        CREATE TABLE TAG (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tagName TEXT NOT NULL,
          color INTEGER NOT NULL
        )
      ''');
    await db.execute('''
        CREATE TABLE TASK_TAGS (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taskId INTEGER,
          tagId INTEGER,
          FOREIGN KEY(taskId) REFERENCES TASK(id),
          FOREIGN KEY(tagId) REFERENCES TAG(id)
        )
      ''');
    await db.insert("TAG", {"tagName": "tag", "color": 4294967295});
    await db.insert("TASK", {
      "title": "Titulo",
      "description": "descripcion",
      "difficulty": 1,
      "isRoot": 1,
      "isComplete": 0,
      "forToday": 0
    });
    await db.insert("TASK", {
      "title": "hijo",
      "description": "descripcion",
      "difficulty": 2,
      "isRoot": 0,
      "isComplete": 0,
      "forToday": 0
    });
    await db.insert("TASK", {
      "title": "Compra",
      "description": "descripcion",
      "difficulty": 2,
      "isRoot": 1,
      "isComplete": 0,
      "forToday": 0
    });
    await db.insert("COMPOSED_TASK", {"taskId": 1, "childTaskId": 2});
    await db.insert("TASK_TAGS", {"taskId": 1, "tagId": 1});
    await db.insert("TASK_CALENDAR", {"taskId": 1, "deadline": 1729769476});
  }

  Future<void> deleteDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/task.db';
    //TODO
  }
}
