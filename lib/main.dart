import 'package:flutter/material.dart';
import 'package:dih/home_screen.dart'; // make sure the path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIH Healthcare',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const HealthDashboardScreen(), // <- use correct class here
      debugShowCheckedModeBanner: false,
    );
  }
}
