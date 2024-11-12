import 'package:flutter/material.dart';
import 'package:zen/data/task_dao.dart';
import 'package:zen/model/task_list_item_dto.dart';
import 'package:zen/view/tree_visualizer_page/add_task_page.dart';
import 'package:zen/widget/list_view_task.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    Future<List<TaskListItemDto>> items = TaskDao().findRootTasks();
    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return AddTaskForm(addTaskToList);
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  ListViewTask(taskListItemDto: snapshot.data![index]),
            );
          }
        }
        return Center(child: SizedBox());
      },
    );
  }

  addTaskToList() {}
}
