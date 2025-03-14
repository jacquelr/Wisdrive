import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constraints/images_routes.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/navigation/screens/edit_profile_screen.dart';
import 'package:quiz_app/widgets/profile/sidebar_profile.dart';
import 'package:quiz_app/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(context) {
    final ThemeController themeController = Get.find();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: GoogleFonts.play(
              color: themeController.isDarkMode.value
                  ? AppTheme.darkPurple
                  : Colors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: themeController.isDarkMode.value
            ? const IconThemeData(color: AppTheme.darkPurple, size: 40)
            : const IconThemeData(color: AppTheme.lightBackground, size: 40),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: themeController.isDarkMode.value
              ? const Icon(Icons.arrow_back_sharp, color: AppTheme.darkPurple)
              : const Icon(Icons.arrow_back_sharp,
                  color: AppTheme.lightBackground),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: const SidebarProfile(),
      body: Container(
        height: double.infinity,
        decoration: themeController.isDarkMode.value
            ? const BoxDecoration(gradient: AppTheme.blackBgGradient)
            : const BoxDecoration(color: AppTheme.lightBackground),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: themeController.isDarkMode.value
                          ? AppTheme.lightBackground
                          : AppTheme.lightPurple,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(200),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 75),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: themeController.isDarkMode.value
                          ? Colors.black.withOpacity(0.5)
                          : Colors.white.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 15,
                          offset: const Offset(0, 40),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage(RImages.profilePickImage),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Nombre de usuario", // Get useneme from supabase
                  style: GoogleFonts.play(
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : AppTheme.lightSecondary,
                      fontSize: 36)),
              Text("Descripcion del usuario para wisdrive", // Get description from supabase
                  style: GoogleFonts.play(
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : AppTheme.lightSecondary,
                      fontSize: 18)),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeController.isDarkMode.value
                          ? Colors.white
                          : AppTheme.lightPurple,
                      foregroundColor: themeController.isDarkMode.value
                          ? AppTheme.darkPurple
                          : Colors.white,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      S.of(context).edit_profile,
                      style: GoogleFonts.play(fontSize: 18),
                    )),
              ),
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: Divider(
                  color: Colors.grey,
                  thickness: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
