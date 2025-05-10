import 'package:flutter/material.dart';
import 'package:wisdrive/widgets/login/modal_signin_sheet.dart';
import 'package:wisdrive/widgets/login/modal_signup_sheet.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import '../../../generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getGradient(
              themeController.isDarkMode.value), // Aplicamos el degradado
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              themeController.isDarkMode.value
                  ? Image.asset(RImages.fullLogo, width: 400)
                  : Image.asset(RImages.fullLigthLogo, width: 400),
              const SizedBox(height: 50),
              Text(
                S.of(context).lets_start_learning,
                style: GoogleFonts.play(
                    color: themeController.isDarkMode.value
                        ? AppTheme.lightBackground
                        : AppTheme.lightPurple,
                    fontSize: 42),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showAuthModal(context, true),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: themeController.isDarkMode.value
                          ? Colors.transparent
                          : AppTheme.lightPurple,
                      foregroundColor: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      S.of(context).sign_in,
                      style:
                          GoogleFonts.play(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showAuthModal(context, false),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      S.of(context).sign_up,
                      style: GoogleFonts.play(color: purple, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
