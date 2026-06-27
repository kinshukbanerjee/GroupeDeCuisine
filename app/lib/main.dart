import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const GroupeDeCuisineApp());
}

class GroupeDeCuisineApp extends StatelessWidget {
  const GroupeDeCuisineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Groupe De Cuisine",
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}