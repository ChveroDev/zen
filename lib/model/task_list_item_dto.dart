import 'package:zen/model/task.dart';

class TaskListItemDto {
  Task _task;
  bool _hasChilds;
  TaskListItemDto(this._task, this._hasChilds);

  Task get task => _task;
  bool get hasChilds => _hasChilds;
}
