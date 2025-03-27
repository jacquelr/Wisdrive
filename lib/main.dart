import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/controllers/language_controller.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:wisdrive/navigation/screens/app_start/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await GetStorage.init();

  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
  // Inicializar Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,

  Get.put(ThemeController());
  Get.put(LanguageController());
  runApp(const WisdriveApp());
}

class WisdriveApp extends StatelessWidget {
  const WisdriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.find();

    return GetMaterialApp(
      locale: languageController.selectedLocale.value, // Idioma dinámico
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Wisdrive',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
