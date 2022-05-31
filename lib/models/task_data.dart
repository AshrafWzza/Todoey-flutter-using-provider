//You should separate task.dart and taskdata.dart because if you make it one file it make error crash app
//"this error happens when you try to create and read provider immediately"
import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Buy Milk'),
    Task(name: 'Buy Bread'),
    Task(name: 'Buy Fruits'),
  ];
  //use get to protect u from access it directly and forget to use methods contains notifyListeners()
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void updateTask(Task taskwantedtochange, bool value) {
    taskwantedtochange.isDone = value;
    notifyListeners(); // Mandatory
  }

  void deleteTask(Task taskwantedtodelete) {
    _tasks.remove(taskwantedtodelete);
    notifyListeners(); // Mandatory
  }

  int get taskCount {
    return _tasks.length;
  }

  void add(String newTask) {
    _tasks.add(Task(name: newTask));
    notifyListeners(); // Mandatory
  }
}
