import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';

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
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK')),
            ],
          );
        });
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
