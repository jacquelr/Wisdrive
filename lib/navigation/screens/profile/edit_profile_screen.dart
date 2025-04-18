import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/widgets/profile/editprofile_inputs.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(context) {
    final ThemeController themeController = Get.find();
    final Color textColor = themeController.isDarkMode.value ? Colors.white : AppTheme.darkPurple;

    return Scaffold(
      backgroundColor: themeController.isDarkMode.value ? AppTheme.darkPurple : AppTheme.lightBackground,
      appBar: AppBar(
        title: Text(S.of(context).edit_profile, style: GoogleFonts.play(color: textColor),),
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
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              color: Colors.grey,
            ),
            Stack( // Choose profile image container
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Container( // Image View container
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar( //Image View
                      radius: 80,
                      backgroundImage: AssetImage(RImages.profilePickImage),
                    ),
                  ),
                ),
                Positioned( // Set this widget on bottom-right of Choose profile image container
                  bottom: 0,
                  right: 0,
                  child: Container( // Edit image button container
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
            TextButton( // Text button to change profile image
              onPressed: () {},
              child: Text(
                S.of(context).change_picture,
                style: GoogleFonts.play(
                    color: AppTheme.lightSecondary, fontSize: 24),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const Expanded(
              child: Center(
                child: EdditProfileInputs(), // Form to update user info
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton( // Change password text button
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.lightPurple,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: Text(S.of(context).change_password, style: GoogleFonts.play(fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
