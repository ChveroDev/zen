import 'package:flutter/material.dart';
import 'package:zen/model/task_list_item_dto.dart';

class ListViewTask extends StatelessWidget {
  final TaskListItemDto taskListItemDto;
  const ListViewTask({
    required this.taskListItemDto,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListTile(
        title: Text(taskListItemDto.task.title),
        trailing: taskListItemDto.hasChilds
            ? Icon(Icons.account_tree_outlined)
            : SizedBox(),
      ),
    );
  }
}
