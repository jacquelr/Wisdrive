import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wisdrive/navigation/screens/app_start/change_password_screen.dart';
import 'package:wisdrive/navigation/screens/home/home_screen.dart';
import 'package:wisdrive/navigation/screens/app_start/login_screen.dart';
import 'package:wisdrive/navigation/screens/app_start/onboarding_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/service/auth_service.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(context) {
    final authService = AuthService();

    return StreamBuilder<AuthState>(
      //Listen to auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,
      //Build appropieate page based on auth state
      builder: (context, snapshot) {
        //Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        //Check if there is a valid session currently
        final session = Supabase.instance.client.auth.currentSession;

        // Verify if event is reset password
        if (snapshot.hasData && snapshot.data != null) {
          final event = snapshot.data!.event;

          if (event == AuthChangeEvent.passwordRecovery) {
            // Navigate to ChangePasswordScreen
            Future.microtask(() => Get.to(() => const ChangePasswordScreen()));
          }
        }

        if (session != null) {
          return const HomeScreen();
        }
        return authService.isFirstTime()
            ? const OnboardingScreen()
            : const LoginScreen();
      },
    );
  }
}
