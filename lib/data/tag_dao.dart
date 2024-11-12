import 'package:sqflite/sqflite.dart';
import 'package:zen/data/dao.dart';
import 'package:zen/data/task_database.dart';
import 'package:zen/mappers/tag_mapper.dart';
import 'package:zen/model/tag.dart';

class TagDao implements Dao<Tag> {
  late TaskDataBase _taskDatabase;

  TagDao() {
    _taskDatabase = TaskDataBase.instance;
  }

  Future<bool> insert(Tag tag) async {
    Database database = await _taskDatabase.database;
    int savedId = await database
        .insert("TAG", {"tagName": tag.tagName, "color": tag.tagColor.value});
    if (savedId < 1) {
      return false;
    }
    tag.id = savedId;
    return true;
  }

  Future<bool> delete(int id) async {
    Database database = await _taskDatabase.database;
    database.delete("TASK_TAGS", where: "tagId=?", whereArgs: [id]);
    int rowsDeleted =
        await database.delete("TAG", where: "id=?", whereArgs: [id]);
    if (rowsDeleted == 1) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteAll() {
    throw UnimplementedError();
  }

  @override
  Future<List<Tag>> findAll() {
    throw UnimplementedError();
  }

  @override
  Future<Tag> find(int id) async {
    Database database = await _taskDatabase.database;
    List<Map<String, Object?>> tagMap =
        await database.query("TAG", where: "id=?", whereArgs: [id]);
    TagMapper tagMapper = TagMapper();
    return tagMapper.map(tagMap.first);
  }
}
