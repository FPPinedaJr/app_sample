import 'package:app_example/features/login/login_screen.dart';
import 'package:app_example/features/register/register_screen.dart';
import 'package:app_example/features/landing/splash_screen.dart';
import 'package:flutter/material.dart';

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
        // "/": (context) => const RegisterScreen(), // FOR DEVELOPMENT ONLY


        "/": (context) => const SplashScreen(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
      },
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
