import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zen/data/tag_dao.dart';
import 'package:zen/data/task_dao.dart';
import 'package:zen/model/individual_task.dart';
import 'package:zen/model/predefinedTags/difficulty.dart';
import 'package:zen/model/tag.dart';
import 'package:zen/model/task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test("save task", () async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final databasePath = await getDatabasesPath();
    final path = '$databasePath\\task.db';
    Tag tag = Tag("tag", Colors.white);
    TagDao tagDao = TagDao();
    tagDao.insert(tag);
    Task task =
        IndividualTask("titulo", "descripcion", [tag], Difficulty.difficult);
    Task secondTask = IndividualTask(
        "segundo nivel", "descripcion 2", [tag], Difficulty.medium);
    Task thirdTask =
        IndividualTask("tercera", "descripcion 2", [tag], Difficulty.easy);
    Task thirdTaskInner = IndividualTask(
        "segundo inner", "descripcion 3", [tag], Difficulty.easy);
    Task fourthTask = IndividualTask(
        "tercero inner", "descripcion 3", [tag], Difficulty.easy);
    Task fithTask = IndividualTask(
        "tercero inner 2", "descripcion 3", [tag], Difficulty.easy);
    Task? auxTask = thirdTask.addTask(fourthTask);
    if (auxTask != null) {
      thirdTask = auxTask;
    }
    thirdTask.addTask(fithTask);
    auxTask = task.addTask(secondTask);
    auxTask = secondTask.addTask(thirdTaskInner);
    task.addTask(thirdTask);
    TaskDao taskDao = TaskDao();
    bool result = await taskDao.insert(task);
    Task finded = await taskDao.find(task.id!);
    finded.printChildsFromRoot();
  });
  test("find task", () async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    TaskDao taskDao = TaskDao();
    Task finded = await taskDao.find(1);
    finded.printChildsFromRoot();
  });
}
