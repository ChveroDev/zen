import 'package:flutter/material.dart';
import 'package:zen/model/task.dart';

class AddTaskForm extends StatefulWidget {
  late Function createTask;
  AddTaskForm(Function funcition, {super.key}) {
    createTask = funcition;
  }

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  late String title = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "title"),
            onChanged: (value) => title = value,
          ),
          ElevatedButton(
              onPressed: () {
                widget.createTask(title);
              },
              child: Text("aceptar"))
        ],
      ),
    );
  }
}
