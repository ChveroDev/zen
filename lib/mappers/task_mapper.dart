import 'package:zen/mappers/mapper.dart';
import 'package:zen/model/individual_task.dart';
import 'package:zen/model/predefinedTags/difficulty.dart';
import 'package:zen/model/tag.dart';
import 'package:zen/model/task.dart';

class TaskMapper implements Mapper<Map<String, Object?>, Task> {
  @override
  Task map(Map<String, Object?> input) {
    return IndividualTask(
        input["title"] as String,
        input["description"] as String,
        input["tags"] as List<Tag>,
        Difficulty.findByDifficulty(input["difficulty"] as int),
        id: input["id"] as int);
  }
}
