import 'package:flutter/material.dart';
import 'package:zen/model/individual_task.dart';
import 'package:zen/utils/position.dart';
import 'package:zen/model/task.dart';

class ComposedTask extends Task {
  late List<Task> _tasks;
  ComposedTask(super.title, super.description, super.tags, List<Task> tasks,
      super.difficulty) {
    _tasks = tasks;
    for (var task in _tasks) {
      task.newfather = this;
    }
  }

  ComposedTask.copy(super.title, super.description, super.tags, Task task,
      ComposedTask? father, super.difficulty,
      {super.id}) {
    _tasks = List<Task>.of([task]);
    task.newfather = this;
    newfather = father;
  }

  List<Task> get tasks => _tasks;

  @override
  ComposedTask? addTask(Task task) {
    _tasks.add(task);
    task.newfather = this;
    return null;
  }

  void changeChild(Task oldTask, Task newTask) {
    int index = _tasks.indexOf(oldTask);
    _tasks[index] = newTask;
  }

  Map<Task, Position> getItemsPositions(
      double dx, double dy, double separation) {
    Map<Task, Position> map = {};
    int upDownItems = (_tasks.length / 2).floor();
    double delta = 0;
    double limitCondition = -((upDownItems * separation) - delta);
    if (_tasks.length % 2 == 0) {
      delta = separation / 2;
    }
    for (double i = (separation * upDownItems) - delta, j = 0;
        i >= limitCondition;
        i -= separation, j++) {
      map.putIfAbsent(
          tasks[j.floor()], () => Position(dx: dx + separation, dy: i + dy));
    }
    return map;
  }
}
