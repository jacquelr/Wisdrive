import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/constraints/popup_messages.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/service/supabase_service.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';
// import 'package:wisdrive/widgets/login/social_login_buttons.dart';
import '../../generated/l10n.dart';

class ModalSignupSheet extends StatefulWidget {
  const ModalSignupSheet({super.key});

  @override
  State<ModalSignupSheet> createState() => _ModalSignupSheetState();
}

class _ModalSignupSheetState extends State<ModalSignupSheet> {
  final authService = AuthService();
  final supabaseService = SupabaseService();
  final ThemeController themeController = Get.find();
  bool obscurePassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Logic to Sign Up once user input his email, password and confirm password
  void signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) { // Validate empty fields
      Navigator.pop(context);
      ResponseSnackbar.show(context, true, S.of(context).fill_all_fields);
      return;
    } else if (!HelperFunctions.isValidEmail(email)) { // Validate email with regex
      Navigator.pop(context);
      ResponseSnackbar.show(context, true, S.of(context).invalid_email_format);
      return;
    } else if (!HelperFunctions.isSecurePassword(password)) { // Validate password with regex
      Navigator.pop(context);
      ResponseSnackbar.show(context, true, S.of(context).invalid_password_format);
      return;
    } else if (password != confirmPassword) { // Validate if passwords match
      Navigator.pop(context);
      ResponseSnackbar.show(context, true, S.of(context).unmatch_password);
      return;
    }

    try {
      final matchedEmail = await supabaseService.isMatchedEmail(email);
      final deletedUser = await supabaseService.isUserDeleted(email);

      if (!matchedEmail) {
        // Case 1: There is no user with this email
        await authService.signUpWithEmailAndPassword(email, password);
        if (context.mounted) {
          Navigator.pop(context);
          PopupMessages.showAlert(
            S.of(context).created_account,
            S.of(context).check_email_to_activate_account,
          );
        }
      } else {
        if (deletedUser) {
          // Case 2: User deleted his account and want to create another -> delete user data record to create a new one
          await supabaseService.deleteUserProfile(email);
          await authService.updatePassword(password);
          if (context.mounted) {
            Navigator.pop(context);
            PopupMessages.showAlert(
              S.of(context).created_account,
              S.of(context).already_authenticated,
            );
          }
        } else {
          // Caso 3: Active account already exists → show existing account error
          Navigator.pop(context);
          ResponseSnackbar.show(
            context,
            true,
            S.of(context).existing_account,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ResponseSnackbar.show(
          context,
          true,
          S.of(context).signup_error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        child: Container(
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
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: S.of(context).password,
                  labelStyle: GoogleFonts.play(color: Colors.white70, fontSize: 24),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: HelperFunctions.getIconThemeColor(),
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: confirmPasswordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: S.of(context).confirm_password,
                  labelStyle: GoogleFonts.play(color: Colors.white70, fontSize: 20),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: HelperFunctions.getIconThemeColor(),
                      ),
                      onPressed: () {
                        PopupMessages.showAlert(
                          S.of(context).password_format,
                          S.of(context).password_requirements,
                        );
                      }),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: signUp,
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
              // SIGN UP WITH FACEBOOK OR GOOGLE (feature not completed)
              // Text(
              //   S.of(context).create_account_with,
              //   style: GoogleFonts.play(color: Colors.white, fontSize: 16),
              // ),
              // const SizedBox(height: 15),
              // const SocialLoginButtons(),
              const SizedBox(height: 55),
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
        ),
      ),
    );
  }
}
