import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

import 'package:groupe_de_cuisine/routes/app_router.dart';
import 'package:groupe_de_cuisine/routes/route_names.dart';

void main() {
  runApp(const GroupeDeCuisineApp());
}

class GroupeDeCuisineApp extends StatelessWidget {
  const GroupeDeCuisineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Groupe De Cuisine',
  theme: AppTheme.lightTheme,
  initialRoute: RouteNames.splash,
  onGenerateRoute: AppRouter.generateRoute,
);
  }
}