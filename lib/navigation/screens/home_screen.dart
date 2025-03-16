import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/navigation/screens/profile_screen.dart';
import 'package:quiz_app/service/auth_service.dart';
import 'package:quiz_app/widgets/home/sidebar_menu.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.find();
  final authservice = AuthService();

  @override
  Widget build(context) {
    final currentEmail = authservice.getCurrentUserEmail();

    return MaterialApp(
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: "Wisdrive",
      theme: ThemeData(),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: themeController.isDarkMode.value
              ? const IconThemeData(color: AppTheme.lightBackground, size: 40)
              : const IconThemeData(color: AppTheme.lightSecondary, size: 40),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: themeController.isDarkMode.value
                  ? const Icon(Icons.account_circle,
                      color: AppTheme.lightBackground)
                  : const Icon(Icons.account_circle,
                      color: AppTheme.lightSecondary),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ));
              },
            ),
          ],
        ),
        drawer: const SidebarMenu(),
        body: Container(
          decoration: themeController.isDarkMode.value
              ? BoxDecoration(
                  gradient: AppTheme.getInvertedGradient(
                      themeController.isDarkMode.value),
                )
              : const BoxDecoration(color: AppTheme.lightBackground),
          child: Center(
            child: Text(currentEmail.toString()),
          ),
        ),
      ),
    );
  }
}
