import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wisdrive/navigation/screens/home/home_screen.dart';
import 'package:wisdrive/navigation/screens/app_start/login_screen.dart';
import 'package:wisdrive/navigation/screens/app_start/onboarding_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(context) {
    final box = GetStorage();
    final bool isFirstTime = box.read("isFirstTime") ?? true; //Check if user is new
    
    return StreamBuilder(
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
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          return const HomeScreen();
        } 
        return isFirstTime ? const OnboardingScreen() : const LoginScreen();
      },
    );
  }
}
