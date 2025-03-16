import 'package:flutter/material.dart';
import 'package:quiz_app/navigation/screens/home_screen.dart';
import 'package:quiz_app/navigation/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(context) {
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
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
