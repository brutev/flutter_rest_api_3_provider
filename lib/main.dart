import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3_provider/Provider/auth_provider.dart';
import 'package:flutter_rest_api_3_provider/Provider/database_provider.dart';
import 'package:flutter_rest_api_3_provider/Provider/taskProvider/add_task_provider.dart';
import 'package:flutter_rest_api_3_provider/Provider/taskProvider/delete_task_provider.dart';
import 'package:flutter_rest_api_3_provider/screens/splash_screen.dart';
import 'package:flutter_rest_api_3_provider/styles/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => AddTaskProvider()),
        ChangeNotifierProvider(create: (_) => DeleteTaskProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: primaryColor),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: primaryColor),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
