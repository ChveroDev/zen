import 'package:flutter/material.dart';
import 'package:zen/data/task_dao.dart';
import 'package:zen/data/task_tree_om.dart';
import 'package:zen/model/composed_task.dart';
import 'package:zen/utils/position.dart';
import 'package:zen/model/task.dart';
import 'package:zen/widget/tree_item.dart';
import 'package:zen/view/tree_visualizer_page/line_custom_painter.dart';

class TreeStructure extends StatefulWidget {
  Future<Task> task = TaskDao().find(1);
  TreeStructure({super.key});
  @override
  State<TreeStructure> createState() => _TreeStructureState();
}

class _TreeStructureState extends State<TreeStructure> {
  double appBarHeight = 30;

  @override
  Widget build(BuildContext context) {
    widget.task = TaskDao().find(1);
    return Scaffold(
      body: FutureBuilder(
          future: widget.task,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: TaskCard(
                      Position(dx: 10, dy: 300),
                      snapshot.data!,
                      appBarHeight,
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
