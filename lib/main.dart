import 'package:flutter/material.dart';
import 'features/splash_feature/splash_screen.dart';
import 'features/login_feature/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App Sample',
      routes: {
        "/": (context) => const LoginScreen(), // FOR DEVELOPMENT ONLY


        // "/": (context) => const SplashScreen(),
        // "/login": (context) => const LoginScreen(),
      },
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
