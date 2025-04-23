import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/service/auth_gate.dart';
import 'package:wisdrive/service/auth_service.dart';
import '../generated/l10n.dart';

class HelperFunctions {
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: GoogleFonts.play(
                  color: HelperFunctions.getWhiteBgTextThemeColor()),
            ),
            content: Text(
              message,
              style: GoogleFonts.play(
                  color: HelperFunctions.getWhiteBgTextThemeColor()),
            ),
            backgroundColor: HelperFunctions.getContainerThemeColor(),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(Get.context!).pop(),
                  child: Text(
                    'OK',
                    style: GoogleFonts.play(
                        color: HelperFunctions.getWhiteBgTextThemeColor(),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }

  static void showLogoutDialog(BuildContext context) {
    final authservice = AuthService();
    final ThemeController themeController = Get.find();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.darkPurple,
        title: Text(
          '¿Estás seguro?',
          textAlign: TextAlign.center,
          style: GoogleFonts.play(
            color: themeController.isDarkMode.value
                ? Colors.white
                : AppTheme.lightSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Divider(endIndent: 5),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext); // Pop dialog
              await authservice.signOut(); // Exit the session
              if (context.mounted) {
                //Go to AuthGate to check if session is still active
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const AuthGate()),
                  (route) => false,
                );
              }
            },
            child: Text(
              S.of(dialogContext).logout,
              style: GoogleFonts.play(color: Colors.red, fontSize: 16),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                S.of(dialogContext).cancel,
                style: GoogleFonts.play(
                    color: themeController.isDarkMode.value
                        ? Colors.white
                        : AppTheme.darkPurple,
                    fontSize: 16),
              ))
        ]),
      ),
    );
  }

  static void showDeleteAccountDialog(BuildContext parentContext) {
    final authservice = AuthService();
    final ThemeController themeController = Get.find();
    showDialog(
      context: parentContext,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.darkPurple,
        title: Text(
          '¿Estás seguro?',
          textAlign: TextAlign.center,
          style: GoogleFonts.play(
            color: themeController.isDarkMode.value
                ? Colors.white
                : AppTheme.lightSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Divider(endIndent: 5),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext); // Pop dialog
              await authservice.deleteUserDataAndSignOut(parentContext);
            },
            child: Text(
              S.of(parentContext).delete_account,
              style: GoogleFonts.play(color: Colors.red, fontSize: 16),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                S.of(parentContext).cancel,
                style: GoogleFonts.play(
                    color: themeController.isDarkMode.value
                        ? Colors.white
                        : AppTheme.darkPurple,
                    fontSize: 16),
              ))
        ]),
      ),
    );
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  // Get Theme Color for backgruonds and texts
  static Color? getTextThemeColor() {
    final ThemeController themeController = Get.find();
    final textColor =
        themeController.isDarkMode.value ? white : AppTheme.darkPurple;
    return textColor;
  }

  static Color? getWhiteBgTextThemeColor() {
    final ThemeController themeController = Get.find();
    final textColor =
        themeController.isDarkMode.value ? AppTheme.darkPurple : white;
    return textColor;
  }

  static Color? getIconThemeColor() {
    final ThemeController themeController = Get.find();
    final iconColor = themeController.isDarkMode.value
        ? AppTheme.lightBackground
        : AppTheme.lightSecondary;
    return iconColor;
  }

  static Color? getContainerThemeColor() {
    final ThemeController themeController = Get.find();
    final containerColor = themeController.isDarkMode.value
        ? AppTheme.lightBackground
        : AppTheme.lightPrimary;
    return containerColor;
  }

  static Color? getDropdownMenuThemeColor() {
    final ThemeController themeController = Get.find();
    final containerColor = themeController.isDarkMode.value
        ? AppTheme.lightAccent
        : AppTheme.lightBackground;
    return containerColor;
  }
}
