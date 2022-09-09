//You should separate task.dart and taskdata.dart because if you make it one file it make error crash app
//"this error happens when you try to create and read provider immediately"
class Task {
  //using provider
  String? name;
  bool isDone;

  Task({this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  // void add(String newTask) {
  //   tasks.add(Task(name: newTask));
  //   notifyListeners();
  // }
}
// class Task extends ChangeNotifier {
//   //using provider
//   String? name;
//   bool isDone;
//   List<Task> tasks = [
//     Task(name: 'Buy Milk'),
//     Task(name: 'Buy Bread'),
//     Task(name: 'Buy Fruits'),
//     Task(name: 'Buy Fruits'),
//   ];
//
//   Task({this.name, this.isDone = false});
//
//   void toggleDone() {
//     isDone = !isDone;
//   }
//
//   void add(String newTask) {
//     tasks.add(Task(name: newTask));
//     notifyListeners();
//   }
// }
