import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/navigation/screens/home_screen.dart';
import 'package:quiz_app/widgets/login/social_login_buttons.dart';
import '../../generated/l10n.dart';

class ModalSignupSheet extends StatefulWidget {
  const ModalSignupSheet({super.key});

  @override
  State<ModalSignupSheet> createState() => _ModalSignupSheetState();
}

class _ModalSignupSheetState extends State<ModalSignupSheet> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

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
            S.of(context).Sign_Up,
            style: GoogleFonts.play(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 15),
          TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: S.of(context).confirm_password,
              labelStyle: GoogleFonts.play(color: Colors.white70, fontSize: 20),
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
              onPressed: () {
                String email = emailController.text;
                String password = passwordController.text;
                String confirmPassword = confirmPasswordController.text;
                //Insert Sign up logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.mediumPurple,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(S.of(context).sign_up,
                    style: GoogleFonts.play(fontSize: 24)),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            S.of(context).create_account_with,
            style: GoogleFonts.play(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 15),
          const SocialLoginButtons(),
          const SizedBox(height: 40),
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
