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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _darkMode;
  Future<void> _updateTheme() async {
    print('toggle0:$_darkMode');
    final SharedPreferences prefs = await _prefs;
    print('toggle1:$_darkMode');
    print('toggle1:${prefs.getBool('darkMode')}');

    bool darkMode = (prefs.getBool('darkMode') ?? false);
    print('toggle2:$_darkMode');
    print('toggle2:${prefs.getBool('darkMode')}');

    // print('setState:$_darkMode');
    // print('setState:${prefs.getBool('darkMode')}');

    // !darkMode opposite bool Toggle
    // _darkMode = prefs.setBool('darkMode', !darkMode).then((bool success) {
    //   return darkMode;
    // });
    print('AfterSetState:$_darkMode');
    print('AfterSetState:${prefs.getBool('darkMode')}');

    // The opposite of Toggle Function
    darkMode
        ? Get.changeTheme(ThemeData.dark())
        : Get.changeTheme(ThemeData.light());
    print('updattteddd Themmmme');
  }

/* if (await _darkMode) {
      Get.changeTheme(ThemeData.dark());
      print('Statless Changeeeeeee Themmeee');
      setState(() {});
    }*/
  @override
  void initState() {
    super.initState();
    _darkMode = _prefs.then((SharedPreferences prefs) {
      print('initstate00:${prefs.getBool('darkMode')}');
      return prefs.getBool('darkMode') ?? false;
    });
    /*darkMode
        ? Get.changeTheme(ThemeData.dark())
        : Get.changeTheme(ThemeData.light());
    print('Statless Changeeeeeee Themmeee');*/
    _updateTheme();
  }

  @override
  Widget build(BuildContext context) {
/*
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
                  // themeMode: snapshot.data! ? ThemeMode.dark : ThemeMode.light,
                  themeMode: snapshot.data! ? ThemeMode.light : ThemeMode.light,
                  // LIGHT, LIGHT - Change calculation to updateTheme function
                  // Theme mode depends on device settings at the beginning
                  home: TasksScreen(),
                );
              }
          }
        });
*/
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      // themeMode: xxxxxx ? ThemeMode.dark : ThemeMode.light,
      // problem: when app starts with lightMode, the toggle works fine but doesn't work when starts with darkMode
      // solve: make updateTheme Function using Get.changeTheme(ThemeData.dark())

      themeMode: ThemeMode.light,
      // Theme mode depends on device settings at the beginning
      home: const TasksScreen(),
    );
  }
}
