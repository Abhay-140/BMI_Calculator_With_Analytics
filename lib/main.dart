import 'package:flutter/material.dart';
import 'screens/input_screen.dart';
import 'screens/history_screen.dart'; // Import the screen
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/', // Optional but clean
      routes: {
        '/': (context) => const InputScreen(),
        '/history': (context) => const HistoryScreen(), // Route registered
      },
    );
  }
}
