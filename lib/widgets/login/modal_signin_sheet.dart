import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';

import 'package:quiz_app/service/auth_service.dart';
import 'package:quiz_app/widgets/login/social_login_buttons.dart';
import '../../generated/l10n.dart';

class ModalSigninSheet extends StatefulWidget {
  const ModalSigninSheet({super.key});

  @override
  State<ModalSigninSheet> createState() => _ModalSigninSheetState();
}

class _ModalSigninSheetState extends State<ModalSigninSheet> {
  final AuthService _authservice = AuthService();
  final ThemeController themeController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() async {
    final email = emailController.text;
    final password = passwordController.text;
    try {
      Navigator.pop(context);
      await _authservice.signInWithEmailAndPassword(email, password);
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${S.of(context).signin_error}: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: themeController.isDarkMode.value
            ? AppTheme.getGradient(themeController.isDarkMode.value)
            : AppTheme.getInvertedGradient(themeController.isDarkMode.value),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).Sign_In,
            style: GoogleFonts.play(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: S.of(context).email,
              labelStyle: GoogleFonts.play(color: Colors.white70, fontSize: 24),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: S.of(context).password,
              labelStyle: GoogleFonts.play(color: Colors.white70, fontSize: 24),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.mediumPurple,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(S.of(context).sign_in,
                    style: GoogleFonts.play(fontSize: 24)),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            S.of(context).or,
            style: GoogleFonts.play(color: Colors.white, fontSize: 16),
          ),
          Text(
            S.of(context).sign_in_with,
            style: GoogleFonts.play(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 15),
          const SocialLoginButtons(),
          const SizedBox(height: 60),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).close,
                style: GoogleFonts.play(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
