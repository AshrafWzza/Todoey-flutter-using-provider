import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoey_flutter/screens/add_task_screen.dart';
import 'package:todoey_flutter/widgets/task_list.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:get/get.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  //return it to statelessWidget
//   @override
//   State<TasksScreen> createState() => _TasksScreenState();
// }
//
// class _TasksScreenState extends State<TasksScreen> {
  //create tasks here because it is easy to lifting values state up from belows screen(childrens)
  // List<Task> tasks = [
  //   Task(name: 'Buy Milk'),
  //   Task(name: 'Buy Bread'),
  //   Task(name: 'Buy Fruits'),
  //   Task(name: 'Buy Fruits'),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // //Receiving value from pop()-> addTaskScreen
          // use provider instead
          // var nameTask = await showModalBottomSheet(
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.zero,
                  bottomLeft: Radius.zero),
            ),
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskScreen(),
              ),
            ),
          );
          //print(nameTask);
          // //after receiving value form pop()-> addTaskScreen
          //use provider instead
          // setState(() {
          //   tasks.add(Task(name: nameTask));
          // });
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30.0,
                      child: Icon(
                        Icons.list,
                        size: 40.0,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        icon: const Icon(Icons.lightbulb),
                        onPressed: () {
                          Get.isDarkMode
                              ? Get.changeTheme(ThemeData.light())
                              : Get.changeTheme(ThemeData.dark());
                        }),
                  ]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Todoey',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${Provider.of<TaskData>(context).taskCount} Tasks',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: const BoxDecoration(
                //color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: const TaskList(
                  //tasks: context.read<Task>().tasks,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
