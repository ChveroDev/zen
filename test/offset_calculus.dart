import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zen/model/composed_task.dart';
import 'package:zen/model/individual_task.dart';
import 'package:zen/model/predefinedTags/difficulty.dart';
import 'package:zen/model/tag.dart';

void main() {
  test("offset calculus", () {
    Tag tag = Tag("a", Colors.black);
    List<Tag> tags = [tag];
    IndividualTask individualTask1 =
        IndividualTask("1", "1", tags, Difficulty.easy);
    IndividualTask individualTask2 =
        IndividualTask("2", "2", tags, Difficulty.easy);
    IndividualTask individualTask3 =
        IndividualTask("3", "3", tags, Difficulty.easy);
    IndividualTask individualTask4 =
        IndividualTask("4", "4", tags, Difficulty.easy);
    IndividualTask individualTask5 =
        IndividualTask("5", "5", tags, Difficulty.easy);
    ComposedTask task = ComposedTask(
        "prueba",
        "descripcion",
        tags,
        [
          individualTask1,
          individualTask2,
          individualTask3,
          individualTask4,
          individualTask5
        ],
        Difficulty.easy);
    print(task.getItemsPositions(10, 200, 20).length);
  });
}
