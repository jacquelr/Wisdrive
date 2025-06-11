import 'package:flutter/material.dart';
import 'package:wisdrive/controllers/language_controller.dart';
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

  // Display signIn or signUp modal sheet
  void _showAuthModal(BuildContext context, bool isSignin) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return isSignin ? const ModalSigninSheet() : const ModalSignupSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LanguageController languageController = Get.find();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppTheme.getGradient(themeController.isDarkMode.value),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Language Icon
              Positioned(
                top: 10,
                left: 10,
                child: PopupMenuButton<Locale>(
                  icon: const Icon(Icons.language, color: Colors.white),
                  tooltip: S.of(context).language,
                  onSelected: (Locale locale) {
                    languageController.changeLanguage(locale);
                  },
                  itemBuilder: (BuildContext context) {
                    Locale currentLocale =
                        languageController.selectedLocale.value;
                    return [
                      PopupMenuItem(
                        value: const Locale('es', 'MX'),
                        child: Row(
                          children: [
                            const Text('Español'),
                            const Spacer(),
                            if (currentLocale.languageCode == 'es')
                              const Icon(Icons.check, color: Colors.white),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: const Locale('en', 'US'),
                        child: Row(
                          children: [
                            const Text('English'),
                            const Spacer(),
                            if (currentLocale.languageCode == 'en')
                              const Icon(Icons.check, color: Colors.white),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // evita ocupar todo el alto
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        themeController.isDarkMode.value
                            ? Image.asset(RImages.fullLogo, width: 300)
                            : Image.asset(RImages.fullLigthLogo, width: 300),
                        const SizedBox(height: 40),
                        Text(
                          S.of(context).lets_start_learning,
                          style: GoogleFonts.play(
                            color: themeController.isDarkMode.value
                                ? AppTheme.lightBackground
                                : AppTheme.lightPurple,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showAuthModal(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeController.isDarkMode.value
                                  ? Colors.transparent
                                  : AppTheme.lightPurple,
                              foregroundColor: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                S.of(context).sign_in,
                                style: GoogleFonts.play(
                                    color: Colors.white, fontSize: 26),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showAuthModal(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                S.of(context).sign_up,
                                style: GoogleFonts.play(
                                    color: purple, fontSize: 26),
                              ),
                            ),
                          ),
                        ),
                      ],
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
