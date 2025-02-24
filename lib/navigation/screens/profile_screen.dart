import 'package:flutter/material.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/widgets/sidebar_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Profile Screen"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const SidebarMenu(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.blackBgGradient,
        ),
      ),
    );
  }
}
