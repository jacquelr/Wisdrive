import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:quiz_app/controllers/language_controller.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/navigation/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const logo = '../assets/images/logo.png';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
  // Inicializar Supabase
  await Supabase.initialize(
    url:
        'https://vtyjpcahodmndprwngxx.supabase.co', // Reemplaza con tu URL de Supabase
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0eWpwY2Fob2RtbmRwcnduZ3h4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAyNzgyNjIsImV4cCI6MjA1NTg1NDI2Mn0.sqWU9JAlMmUbk7z1PpGeC2Xow9cg6JjU9-eb0NjqDvY', // Reemplaza con tu API Key pública
  );

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
