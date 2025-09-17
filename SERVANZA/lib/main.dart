import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/main_shell.dart';
import 'screens/onboarding/onboarding_page.dart';
import 'screens/auth/login_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ServanzaApp()));
}

class ServanzaApp extends StatelessWidget {
  const ServanzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SERVANZA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routes: {
        OnboardingPage.routeName: (_) => const OnboardingPage(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        SignUpScreen.routeName: (_) => const SignUpScreen(),
        MainShell.routeName: (_) => const MainShell(),
        NotificationsScreen.routeName: (_) => const NotificationsScreen(),
      },
      home: const _AppRoot(),
    );
  }
}

class _AppRoot extends StatelessWidget {
  const _AppRoot();

  Future<bool> _didCompleteOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_complete') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _didCompleteOnboarding(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final done = snapshot.data!;
        return done ? const LoginScreen() : const OnboardingPage();
      },
    );
  }
}