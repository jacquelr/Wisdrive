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
