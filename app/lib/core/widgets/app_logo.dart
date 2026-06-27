import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.restaurant_menu_rounded,
      size: size,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}