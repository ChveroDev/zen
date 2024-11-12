import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zen/model/composed_task.dart';
import 'package:zen/model/individual_task.dart';
import 'package:zen/model/predefinedTags/difficulty.dart';
import 'package:zen/model/tag.dart';
import 'package:zen/model/task.dart';

void main() {
  test("tree test", () {
    Tag tag = Tag("tag", Colors.blue);
    List<Tag> tags = List.of([tag]);
    Task root = IndividualTask("root", "root prueba", tags, Difficulty.easy);
    Task oneLevelDeep = IndividualTask("first", "first", tags, Difficulty.easy);
    Task? result = root.addTask(oneLevelDeep);
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
    print("todo okey mi vida");
  });
}
