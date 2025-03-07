import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/widgets/sidebar_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(context) {
    final ThemeController themeController = Get.find();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Profile Screen"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const SidebarMenu(),
      drawerScrimColor: AppTheme.lightSecondary,
      body: Container(
        decoration: themeController.isDarkMode.value
        ? const BoxDecoration(gradient: AppTheme.blackBgGradient)
        : const BoxDecoration(color: AppTheme.lightBackground),
      ),
    );
  }
}
