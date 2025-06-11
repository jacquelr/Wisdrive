import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';

class CreateProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CreateProfileAppbar({super.key, required this.appbarTitle});

  final String appbarTitle;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return AppBar(
      title: Text(
        appbarTitle,
        style: GoogleFonts.play(color: HelperFunctions.getTextThemeColor()),
      ),
      leading: const IconButton(
        onPressed: null,
        icon: Icon(Icons.arrow_back_sharp),
      ),
      iconTheme: themeController.isDarkMode.value
          ? const IconThemeData(color: AppTheme.lightBackground, size: 40)
          : const IconThemeData(color: AppTheme.darkPurple, size: 40),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
