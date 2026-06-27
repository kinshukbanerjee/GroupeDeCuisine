import 'package:flutter/material.dart';
import 'package:groupe_de_cuisine/core/theme/app_spacing.dart';
import 'package:groupe_de_cuisine/core/widgets/app_logo.dart';
import 'package:groupe_de_cuisine/core/widgets/primary_button.dart';
import 'package:groupe_de_cuisine/routes/route_names.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const Spacer(),

              const AppLogo(
                size: 120,
              ),

              SizedBox(height: AppSpacing.lg),

              Text(
                'Groupe De Cuisine',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              SizedBox(height: AppSpacing.sm),

              Text(
                'Your Virtual Food Court',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const Spacer(),

  PrimaryButton(
  text: 'Get Started',
  onPressed: () {
    Navigator.pushNamed(
      context,
      RouteNames.login,
    );
  },
),

              SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}   