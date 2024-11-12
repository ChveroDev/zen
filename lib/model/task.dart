import 'package:zen/model/composed_task.dart';
import 'package:zen/model/predefinedTags/difficulty.dart';
import 'package:zen/model/tag.dart';

abstract class Task {
  ComposedTask? father;
  int? id;
  late String title;
  late String description;
  late List<Tag> tags;
  Difficulty difficulty;
  bool completed = false;
  bool forToday = false;
  Task(this.title, this.description, this.tags, this.difficulty, {this.id});

  set newfather(ComposedTask? newFather) {
    father = newFather;
  }

  ComposedTask? addTask(Task task);

  delete() {
    if (father != null) {
      father!.tasks.remove(this);
    }
  }

  Task findRoot() {
    if (father == null) {
      return this;
    } else {
      return father!.findRoot();
    }
  }

  bool isRoot() {
    return father == null;
  }

  printChildTitles({int deepness = 0}) {
    String deepnessString = " " * deepness + "-";

    print("${deepnessString}${this.title}");
    if (this is ComposedTask) {
      print(" " * (deepness + 1) + "|");
      deepness++;
      ComposedTask aux = this as ComposedTask;
      for (var task in aux.tasks) {
        task.printChildTitles(deepness: deepness);
      }
    }
  }

  printChildsFromRoot() {
    findRoot().printChildTitles();
  }
}
