import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';
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

  static void showLogoutDialog(BuildContext parentContext) {
    final authService = Get.find<AuthService>();
    final ThemeController themeController = Get.find();
    showDialog(
      context: parentContext,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: getBlackContainerThemeColor(),
        title: Text(
          '${S.of(parentContext).are_you_sure}?',
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
              await authService.signOut(parentContext); // Exit the session
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
    final authService = Get.find<AuthService>();
    final ThemeController themeController = Get.find();
    showDialog(
      context: parentContext,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: getBlackContainerThemeColor(),
        title: Text(
          '${S.of(parentContext).are_you_sure}?',
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
              await authService.deleteUserDataAndSignOut(parentContext);
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

  static void resetPassword(BuildContext context) async {
    final ThemeController themeController = Get.find();
    final authService = Get.find<AuthService>();
    final TextEditingController emailResetController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: getBlackContainerThemeColor(),
          title: Text(
            S.of(context).forgot_password,
            textAlign: TextAlign.center,
            style: GoogleFonts.play(
              color: themeController.isDarkMode.value
                  ? Colors.white
                  : AppTheme.lightSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          content: TextField(
            controller: emailResetController,
            decoration: InputDecoration(
              hintText: S.of(context).enter_your_email,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                S.of(context).cancel,
                style: GoogleFonts.play(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                final email = emailResetController.text.trim();
                if (email.isNotEmpty) {
                  try {
                    authService.sendResetPassowrdLink(email);
                    Navigator.pop(context); // Pop Dialog
                    Navigator.pop(context); // Pop SignIn Modal
                    ResponseSnackbar.show(
                      context,
                      false,
                      S.of(context).reset_link_sent,
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    ResponseSnackbar.show(
                      context,
                      true,
                      "${S.of(context).reset_link_sent_error}: $e",
                    );
                  }
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ResponseSnackbar.show(
                      context, true, S.of(context).fill_all_fields);
                }
              },
              child: Text(
                S.of(context).send,
                style: GoogleFonts.play(
                    color: getQuizLevelContainerThemeColor(), fontSize: 18),
              ),
            ),
          ],
        );
      },
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
        themeController.isDarkMode.value ? Colors.white : AppTheme.darkPurple;
    return textColor;
  }

  static Color? getWhiteBgTextThemeColor() {
    final ThemeController themeController = Get.find();
    final textColor =
        themeController.isDarkMode.value ? AppTheme.darkPurple : Colors.white;
    return textColor;
  }

  static Color? getIconThemeColor() {
    final ThemeController themeController = Get.find();
    final iconColor = themeController.isDarkMode.value
        ? Colors.white
        : AppTheme.lightSecondary;
    return iconColor;
  }

  static Color? getInvertedIconThemeColor() {
    final ThemeController themeController = Get.find();
    final iconColor = themeController.isDarkMode.value
        ? AppTheme.lightSecondary
        : Colors.white;
    return iconColor;
  }

  static Color? getBlackContainerThemeColor() {
    final ThemeController themeController = Get.find();
    final containerColor = themeController.isDarkMode.value
        ? AppTheme.darkPurple
        : AppTheme.lightBackground;
    return containerColor;
  }

  static Color? getContainerThemeColor() {
    final ThemeController themeController = Get.find();
    final containerColor = themeController.isDarkMode.value
        ? AppTheme.lightBackground
        : AppTheme.lightPrimary;
    return containerColor;
  }

  static Color? getQuizCompletedContainerThemeColor() {
    final ThemeController themeController = Get.find();
    final containerColor = themeController.isDarkMode.value
        ? AppTheme.lightSecondary
        : AppTheme.lightBackground;
    return containerColor;
  }

  static Color? getQuizBgContainerThemeColor() {
    final ThemeController themeController = Get.find();
    final containerColor = themeController.isDarkMode.value
        ? AppTheme.mediumPurple
        : AppTheme.lightSecondary;
    return containerColor;
  }

  static Color? getQuizLevelContainerThemeColor() {
    final ThemeController themeController = Get.find();
    final containerColor = themeController.isDarkMode.value
        ? AppTheme.lightSecondary
        : AppTheme.lightPurple;
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
