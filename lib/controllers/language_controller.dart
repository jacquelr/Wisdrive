import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var selectedLocale = const Locale('es', 'MX').obs; // Español por defecto

  @override
  void onInit() {
    //_loadSavedLanguage();
    super.onInit();
  }

  void changeLanguage(Locale locale) async {
    selectedLocale.value = locale;
    Get.updateLocale(locale);
    //_saveLanguage(locale);
  }

  /*Future<void> _saveLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    String? countryCode = prefs.getString('countryCode');

    if (languageCode != null) {
      selectedLocale.value = Locale(languageCode, countryCode);
      Get.updateLocale(selectedLocale.value);
    }
  }*/
}
