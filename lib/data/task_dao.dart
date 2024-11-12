import 'package:sqflite/sqflite.dart';
import 'package:zen/data/dao.dart';
import 'package:zen/data/tag_dao.dart';
import 'package:zen/data/task_database.dart';
import 'package:zen/mappers/tag_mapper.dart';
import 'package:zen/mappers/task_mapper.dart';
import 'package:zen/model/composed_task.dart';
import 'package:zen/model/individual_task.dart';
import 'package:zen/model/predefinedTags/difficulty.dart';
import 'package:zen/model/tag.dart';
import 'package:zen/model/task.dart';
import 'package:zen/model/task_list_item_dto.dart';

class TaskDao implements Dao<Task> {
  late TaskDataBase _taskDatabase;

  TaskDao() {
    _taskDatabase = TaskDataBase.instance;
  }

  @override
  Future<bool> insert(Task task) async {
    Database database = await _taskDatabase.database;
    int lastInsertedId = await database.insert("TASK", {
      "title": task.title,
      "description": task.description,
      "difficulty": task.difficulty.difficulty,
      "isRoot": task.isRoot() == true ? 1 : 0,
      "isComplete": task.completed,
      "forToday": task.forToday,
    });
    if (lastInsertedId < 1) {
      return false;
    }
    task.id = lastInsertedId;
    if (task.father != null) {
      database.insert(
          "COMPOSED_TASK", {"taskId": task.father!.id, "childTaskId": task.id});
    }
    for (var tag in task.tags) {
      database.insert("TASK_TAGS", {"taskId": task.id, "tagId": tag.id});
    }
    if (task is ComposedTask) {
      for (var childTask in task.tasks) {
        await insert(childTask);
      }
    }
    return true;
  }

  @override
  Future<Task> find(int id) async {
    Task task = await findIndividualTask(id);
    Task? aux = await _addChilds(task);
    if (aux != null) {
      task = aux;
    }
    return task;
  }

  Future<Task> findIndividualTask(int id) async {
    Database database = await _taskDatabase.database;
    List<Map<String, Object?>> queryList =
        await database.query("TASK", where: "id=?", whereArgs: [id]);
    Map<String, Object?> result = Map.from(queryList.first);
    List<Map<String, Object?>> tagIds =
        await database.query("TASK_TAGS", where: "taskId=?", whereArgs: [id]);
    List<Tag> tags = [];
    TagDao tagDao = TagDao();
    for (var tag in tagIds) {
      tags.add(await tagDao.find(tag["tagId"] as int));
    }
    result.putIfAbsent("tags", () => tags);
    return IndividualTask(
        id: result["id"] as int,
        result["title"] as String,
        result["description"] as String,
        tags,
        Difficulty.findByDifficulty(result["difficulty"] as int));
  }

  Future<Task?> _addChilds(Task task) async {
    Database database = await _taskDatabase.database;
    List<Map<String, Object?>> queryList = await findChilds(task);
    if (queryList.isEmpty) {
      return null;
    }
    List<int> childsIds =
        queryList.map((taskMap) => taskMap["childTaskId"] as int).toList();
    for (var id in childsIds) {
      Task? auxTask = task.addTask(await find(id));
      if (auxTask != null) {
        task = auxTask;
      }
    }
    return task;
  }

  Future<List<Map<String, Object?>>> findChilds(Task task) async {
    Database database = await _taskDatabase.database;
    return await database
        .query("COMPOSED_TASK", where: "taskId=?", whereArgs: [task.id]);
  }

  @override
  Future<bool> delete(int id) async {
    Database database = await _taskDatabase.database;
    List<Map<String, Object?>> composedTask = await database
        .query("COMPOSED_TASK", where: "taskId=?", whereArgs: [id]);
    List<int> childsIds =
        composedTask.map((task) => task["childTaskId"] as int).toList();
    for (var childId in childsIds) {
      delete(id);
    }
    await database.delete("COMPOSED_TASK", where: "taskId=?", whereArgs: [id]);
    int rowsDeleted =
        await database.delete("TASK", where: "id=?", whereArgs: [id]);
    if (rowsDeleted == 1)
      print("id eliminado correctamente");
    else
      print("no se pudo elimnar el id ${id}");
    return false;
  }

  @override
  Future<bool> deleteAll() async {
    Database database = await _taskDatabase.database;
    database.delete("TASK");
    return true;
  }

  @override
  Future<List<Task>> findAll() async {
    List<int> rootIds = await findRootIds();
    List<Task> tasks = [];
    for (var id in rootIds) {
      tasks.add(await find(id));
    }
    return tasks;
  }

  Future<List<int>> findRootIds() async {
    Database database = await _taskDatabase.database;
    return (await database.query("TASK", where: "isRoot=?", whereArgs: [1]))
        .map((task) => task["id"] as int)
        .toList();
  }

  Future<List<TaskListItemDto>> findRootTasks() async {
    List<int> rootIds = await findRootIds();
    List<Task> rootTasks = [];
    for (var rootId in rootIds) {
      rootTasks.add(await findIndividualTask(rootId));
    }
    List<TaskListItemDto> taskListItemDtos = [];
    for (var task in rootTasks) {
      taskListItemDtos
          .add(TaskListItemDto(task, (await findChilds(task)).isNotEmpty));
    }
    return taskListItemDtos;
  }
}
