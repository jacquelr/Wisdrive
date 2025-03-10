import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constraints/images_routes.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      backgroundColor: AppTheme.darkPurple,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        iconTheme: themeController.isDarkMode.value
            ? const IconThemeData(color: AppTheme.lightBackground, size: 40)
            : const IconThemeData(color: AppTheme.darkPurple, size: 40),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const Divider(
            color: Colors.grey,
          ),
          Stack(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(RImages.profilePickImage),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppTheme.lightSecondary),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Editar foto",
              style: GoogleFonts.play(
                  color: AppTheme.lightSecondary, fontSize: 24),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
