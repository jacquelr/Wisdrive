import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';
import 'package:wisdrive/widgets/profile/profile_appbar.dart';
import '../../../generated/l10n.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final ThemeController themeController = Get.find();
  final authService = AuthService();
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  void updatePasswordFlow() async {
    final email = authService.getCurrentUserEmail();
    final current = currentPassword.text.trim();
    final newPass = newPassword.text.trim();
    final confirmNew = confirmNewPassword.text.trim();

    if (current.isEmpty || newPass.isEmpty || confirmNew.isEmpty) {
      ResponseSnackbar.show(context, true, S.of(context).fill_all_fields);
      return;
    }

    if (newPass != confirmNew) {
      ResponseSnackbar.show(context, true, S.of(context).unmatch_password);
      return;
    }

    if (current == newPass) {
      ResponseSnackbar.show(context, true, S.of(context).same_password);
      return;
    }

    final isValid = await authService.reauthenticate(email!, current);
    if (!isValid) {
      ResponseSnackbar.show(context, true, S.of(context).incorrect_current_password);
      return;
    }

    try {
      await authService.updatePassword(newPass);
      if (mounted) {
        ResponseSnackbar.show(context, false, S.of(context).updated_password);
        authService.signOut(); // Sign Out of session after successfuly updating password
      }
    } catch (e) {
      ResponseSnackbar.show(context, true, "${S.of(context).updated_password_error}: $e");
    }
  }

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color textLabelColor = themeController.isDarkMode.value
        ? Colors.white70
        : AppTheme.darkPurple;

    return Scaffold(
      backgroundColor: themeController.isDarkMode.value
          ? AppTheme.darkPurple
          : AppTheme.lightBackground,
      appBar: ProfileAppbar(appbarTitle: S.of(context).change_password),
      body: SafeArea(
        child: Column(children: [
          const Divider(color: Colors.grey),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: currentPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: S.of(context).current_password,
                    labelStyle:
                        GoogleFonts.play(color: textLabelColor, fontSize: 24),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textLabelColor),
                    ),
                  ),
                  style: TextStyle(color: HelperFunctions.getTextThemeColor()),
                ),
                TextField(
                  controller: newPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: S.of(context).new_password,
                    labelStyle:
                        GoogleFonts.play(color: textLabelColor, fontSize: 24),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textLabelColor),
                    ),
                  ),
                  style: TextStyle(color: HelperFunctions.getTextThemeColor()),
                ),
                TextField(
                  controller: confirmNewPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: S.of(context).confirm_new_password,
                    labelStyle:
                        GoogleFonts.play(color: textLabelColor, fontSize: 24),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textLabelColor),
                    ),
                  ),
                  style: TextStyle(color: HelperFunctions.getTextThemeColor()),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: themeController.isDarkMode.value
                              ? Colors.transparent
                              : AppTheme.lightPurple,
                          foregroundColor: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          S.of(context).cancel,
                          style: GoogleFonts.play(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: updatePasswordFlow,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          S.of(context).apply,
                          style: GoogleFonts.play(
                              color: AppTheme.darkPurple, fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
