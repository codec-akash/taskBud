import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:TaskApp/providers/tasks.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context);
    // print(tasks.items[0].title);
    return tasks.items.length == 0
        ? Text('Text')
        : Flexible(
            fit: FlexFit.tight,
            child: ListView.builder(
              itemCount: tasks.items.length,
              itemBuilder: (ctx, index) => Text(
                tasks.items[index].title,
              ),
            ),
          );
  }
}
