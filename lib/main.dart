import 'package:expense_tracker/expenses.dart';
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
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardTheme().copyWith(
          color: Colors.white70,
        ),
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        useMaterial3: true,
      ),
      home: const Expenses(),
    );
  }
}
