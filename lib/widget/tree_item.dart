import 'package:flutter/material.dart';
import 'package:zen/model/composed_task.dart';
import 'package:zen/model/individual_task.dart';
import 'package:zen/model/predefinedTags/difficulty.dart';
import 'package:zen/utils/position.dart';
import 'package:zen/model/tag.dart';
import 'package:zen/model/task.dart';
import 'package:zen/view/tree_visualizer_page/add_task_page.dart';
import 'package:zen/view/tree_visualizer_page/line_custom_painter.dart';

class TaskCard extends StatefulWidget {
  late Task task;
  Map<Task, Position>? positions;
  double xSeparation = 20;
  double ySeparation = 65;
  late Position position;
  late double appBarHeight;
  Function? changeChildCallback;
  TaskCard(Position givenOffset, Task task, double appBarHeight,
      {this.changeChildCallback, super.key}) {
    this.appBarHeight = appBarHeight;
    this.task = task;
    this.position = givenOffset;
    if (task is ComposedTask && positions == null) {
      reDoPositions();
    }
  }

  reDoPositions() {
    ComposedTask aux = task as ComposedTask;
    positions = aux.getItemsPositions(
        position.dx + xSeparation, position.dy, ySeparation);
  }

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool showTaskForm = false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      if (widget.positions != null)
        ...widget.positions!.values.map(
          (offset) => CustomPaint(
            painter: LinePainter(
                Offset(widget.position.dx,
                    widget.position.dy + widget.appBarHeight + 20),
                Offset(offset.dx, offset.dy + widget.appBarHeight + 20)),
          ),
        ),
      Positioned(
        left: widget.position.dx,
        top: widget.position.dy,
        width: 90,
        child: GestureDetector(
          onTap: () {
            setState(() {
              showTaskForm = true;
            });
          },
          child: LongPressDraggable(
            childWhenDragging: SizedBox(),
            onDragEnd: (details) {
              widget.position.dx = details.offset.dx;
              widget.position.dy = details.offset.dy - widget.appBarHeight - 20;
              setState(() {});
              if (widget.changeChildCallback != null) {
                widget.changeChildCallback!(
                    MapEntry(widget.task, widget.position));
              }
            },
            onDragUpdate: (details) {
              widget.position.dx = details.localPosition.dx;
              widget.position.dy =
                  details.localPosition.dy - widget.appBarHeight - 80;
              setState(() {});
              if (widget.changeChildCallback != null) {
                widget.changeChildCallback!(
                    MapEntry(widget.task, widget.position));
              }
            },
            feedback: SizedBox(
              width: 90,
              child: Card(
                color: widget.task.tags.isNotEmpty
                    ? widget.task.tags[0].tagColor
                    : Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Center(
                    child: Text(
                      widget.task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            child: Card(
              color: widget.task.tags.isNotEmpty
                  ? widget.task.tags[0].tagColor
                  : Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                  child: Text(
                    widget.task.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      if (widget.positions != null) ...createChildTaskCards(),
      if (showTaskForm)
        Expanded(
          child: AddTaskForm(addTask),
        )
    ]);
  }

  List<TaskCard> createChildTaskCards() {
    List<TaskCard> cards = [];
    widget.positions!.forEach((key, value) {
      cards.add(TaskCard(
        value,
        key,
        widget.appBarHeight,
        //addChildCallback,
        changeChildCallback: changeChildTypeCallback,
      ));
    });
    return cards;
  }

  changeChildTypeCallback(MapEntry<Task, Position> entry) {
    print(widget.task.title);
    widget.positions![entry.key] = entry.value;
    setState(() {});
  }

/*   addChildCallback(MapEntry<Task, Position> entry) {
    widget.task.add
  } */
  addTask(String title) {
    Task? result = widget.task.addTask(IndividualTask(
        title, "a", [Tag("cosa", Colors.yellow)], Difficulty.easy));
    showTaskForm = false;
    widget.reDoPositions();
    //addChildCallback(MapEntry(widget.task, widget.position));
    setState(() {});
  }
}
