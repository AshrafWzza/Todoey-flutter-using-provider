import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    late Future<bool> _darkMode;
    _darkMode = _prefs.then((SharedPreferences prefs) {
      print('initstateStatless:${prefs.getBool('darkMode')}');
      return prefs.getBool('darkMode') ?? false;
    });
    return FutureBuilder<bool>(
        future: _darkMode,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  darkTheme: ThemeData.dark(),
                  themeMode: snapshot.data! ? ThemeMode.dark : ThemeMode.light,
                  // Theme mode depends on device settings at the beginning
                  home: const TasksScreen(),
                );
              }
          }
        });
    /*return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: await _darkMode ? ThemeMode.light : ThemeMode.dark,
      // Theme mode depends on device settings at the beginning
      home: const TasksScreen(),
    );*/
  }
}
