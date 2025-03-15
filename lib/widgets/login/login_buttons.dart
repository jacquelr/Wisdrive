import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
// import 'package:quiz_app/widgets/login/modal_sheet.dart';
import 'package:quiz_app/widgets/login/modal_signin_sheet.dart';
import 'package:quiz_app/widgets/login/modal_signup_sheet.dart';
import '../../generated/l10n.dart';

void _showAuthModal(BuildContext context, bool isSignin) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Para que ocupe más espacio
      builder: (context) {
        return isSignin ? const ModalSigninSheet() : const ModalSignupSheet();
      },
    );
  }

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showAuthModal(context, true),
        style: ElevatedButton.styleFrom(backgroundColor: themeController.isDarkMode.value ? Colors.transparent : AppTheme.lightPurple, foregroundColor: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            S.of(context).sign_in,
            style: GoogleFonts.play(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showAuthModal(context, false),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            S.of(context).sign_up,
            style: GoogleFonts.play(color: purple, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
