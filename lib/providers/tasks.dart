import 'package:TaskApp/providers/task.dart';
import 'package:flutter/material.dart';

class Tasks with ChangeNotifier {
  List<Task> _items = [];
  // final String authToken;
  // Tasks(this.authToken);

  List<Task> get items {
    return [..._items];
  }

  Future<void> addTask(Task task) async {
    final newTask = Task(
      title: task.title,
      duration: task.duration,
      date: task.date,
      description: task.description,
      startTime: task.startTime,
      endTime: task.endTime,
      status: task.status,
    );
    _items.add(newTask);
    print("object");
    print(_items);
    notifyListeners();
  }
}
