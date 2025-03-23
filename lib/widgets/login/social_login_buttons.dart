import 'package:flutter/material.dart';
import 'package:quiz_app/constraints/images_routes.dart';
import 'package:quiz_app/navigation/screens/home_screen.dart';
import 'package:quiz_app/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SocialLoginButtons extends StatefulWidget {
  const SocialLoginButtons({super.key});

  @override
  State<SocialLoginButtons> createState() => _SocialLoginButtonsState();
}

class _SocialLoginButtonsState extends State<SocialLoginButtons> {
  final authservice = AuthService();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          RImages.facebookLogo,
          Colors.white,
          () async {
            await authservice.signInWithFacebook();
          },
        ),
        const SizedBox(width: 20),
        _buildSocialButton(
          RImages.googleLogo,
          Colors.white,
          () async {
            await authservice.signInWithGoogle();
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      String imagePath, Color bgColor, VoidCallback onPressed) {
    return SizedBox(
      //width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 5),
        ),
        child: Image.asset(imagePath, width: 50, height: 50),
      ),
    );
  }
}