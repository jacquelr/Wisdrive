import 'package:get/get.dart';
import 'package:wisdrive/constraints/app_theme.dart';

class ThemeController extends GetxController {
  var isDarkMode = true.obs; // 🌙 Modo oscuro por defecto

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme);
    Get.forceAppUpdate();
  }
}