import 'package:flutter/material.dart';
import 'package:todoey_flutter/screens/add_task_screen.dart';
import 'package:todoey_flutter/widgets/task_list.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late Future<bool> _darkMode;

  Future<void> _toggleDarkMode() async {
    print('toggle0:$_darkMode');
    final SharedPreferences prefs = await _prefs;
    print('toggle1:$_darkMode');

    final bool darkMode = (prefs.getBool('darkMode') ?? false);
    print('toggle2:$_darkMode');

    setState(() {
      // !darkMode opposite bool Toggle
      _darkMode = prefs.setBool('darkMode', !darkMode).then((bool success) {
        return darkMode;
      });
      print('setState:$_darkMode');
    });
  }

  @override
  void initState() {
    super.initState();
    _darkMode = _prefs.then((SharedPreferences prefs) {
      print('initstate:${prefs.getBool('darkMode')}');
      return prefs.getBool('darkMode') ?? false;
    });
  }

  //return it to statelessWidget
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          onPressed: () async {
                            await _toggleDarkMode();

                            await _darkMode
                                ? Get.changeTheme(ThemeData.dark())
                                : Get.changeTheme(ThemeData.light());
                          }),
                    ],
                  ),
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
