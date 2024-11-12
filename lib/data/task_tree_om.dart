import 'package:flutter/material.dart';
import 'package:zen/model/composed_task.dart';
import 'package:zen/model/individual_task.dart';
import 'package:zen/model/predefinedTags/difficulty.dart';
import 'package:zen/model/tag.dart';
import 'package:zen/model/task.dart';

class TaskTreeOm {
  static Task getTaskOm() {
    Tag tag = Tag("tag", Colors.blue);
    List<Tag> tags = List.of([tag]);
    Task root = IndividualTask("root", "root prueba", tags, Difficulty.easy);
    Task oneLevelDeep = IndividualTask("first", "first", tags, Difficulty.easy);
    ComposedTask? result = root.addTask(oneLevelDeep);
    if (result != null) {
      root = result;
    }

    assert(oneLevelDeep.father == root as ComposedTask);

    Task secondLevelDeep =
        IndividualTask("second", "second", tags, Difficulty.easy);
    result = oneLevelDeep.addTask(secondLevelDeep);
    if (result != null) {
      oneLevelDeep = result;
    }
    assert(secondLevelDeep.findRoot() == root);

    return root;
  }

  static Task variousChildsOm() {
    Tag tag = Tag("a", Colors.blue);
    List<Tag> tags = [tag];
    IndividualTask individualTask1 =
        IndividualTask("1", "1", tags, Difficulty.easy);
    IndividualTask individualTask2 =
        IndividualTask("2", "2", tags, Difficulty.easy);
    IndividualTask individualTask3 =
        IndividualTask("3", "3", tags, Difficulty.easy);
    IndividualTask individualTask4 =
        IndividualTask("4", "4", tags, Difficulty.easy);
    return ComposedTask(
        "prueba",
        "descripcion",
        tags,
        [individualTask1, individualTask2, individualTask3, individualTask4],
        Difficulty.difficult);
  }
}
