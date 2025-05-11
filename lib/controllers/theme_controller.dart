import 'package:get/get.dart';
import 'package:wisdrive/constraints/app_theme.dart';

class ThemeController extends GetxController {
  var isDarkMode = true.obs; // 🌙 Dark theme by default

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme);
    Get.forceAppUpdate();
  }
}