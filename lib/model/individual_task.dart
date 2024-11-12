import 'package:zen/model/composed_task.dart';
import 'package:zen/model/task.dart';

class IndividualTask extends Task {
  IndividualTask(super.title, super.description, super.tags, super.difficulty,
      {super.id});

  @override
  ComposedTask? addTask(Task task) {
    ComposedTask composedTask = copyToComposedTask(task);
    if (father != null) {
      father!.changeChild(this, composedTask);
    }
    return composedTask;
  }

  ComposedTask copyToComposedTask(Task task) {
    return ComposedTask.copy(title, description, tags, task, father, difficulty,
        id: id);
  }
}
