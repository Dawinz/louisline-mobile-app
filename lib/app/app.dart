import 'package:flutter/material.dart';

import '../features/onboarding/onboarding_page.dart';
import '../features/shell/shell_page.dart';
import '../theme/app_theme.dart';

class LouislineApp extends StatefulWidget {
  const LouislineApp({super.key});

  @override
  State<LouislineApp> createState() => _LouislineAppState();
}

class _LouislineAppState extends State<LouislineApp> {
  bool _onboardingComplete = false;

  void _finishOnboarding() {
    setState(() => _onboardingComplete = true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Louisline Mobile',
      theme: AppTheme.light,
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          final fade = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          final slide = Tween<Offset>(
            begin: const Offset(0.08, 0),
            end: Offset.zero,
          ).animate(fade);
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
        child: _onboardingComplete
            ? const ShellPage(key: ValueKey('shell'))
            : OnboardingPage(
                key: const ValueKey('onboarding'),
                onGetStarted: _finishOnboarding,
              ),
      ),
    );
  }
}
