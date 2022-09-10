import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      // Theme mode depends on device settings at the beginning
      home: const TasksScreen(),
    );
  }
}
