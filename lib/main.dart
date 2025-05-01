import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist_app/pages/login.dart';
import 'package:todolist_app/pages/projects.dart';
import 'package:todolist_app/pages/signup.dart';
import 'package:todolist_app/pages/welcome.dart';
import 'package:todolist_app/pages/task.dart';
// import 'firebase_options.dart';

void main() {
  //initialize Firebase:
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoList App',
      home: const WelcomeScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const WelcomeScreen(),
        '/project': (context) => const Projects(),
        '/task': (context) => const Task(),
      },
      initialRoute: '/home',
    );
  }
}
