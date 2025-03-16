import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constraints/images_routes.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/navigation/screens/edit_profile_screen.dart';
import 'package:quiz_app/navigation/screens/home_screen.dart';
import 'package:quiz_app/service/auth_service.dart';

class SidebarProfile extends StatefulWidget {
  const SidebarProfile({super.key});

  @override
  State<SidebarProfile> createState() => _SidebarProfileState();
}

class _SidebarProfileState extends State<SidebarProfile> {
  final authservice = AuthService();

  void logout() async {
    await authservice.signOut();
  }

  @override
  Widget build(context) {
    final ThemeController themeController = Get.find();

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient:
              AppTheme.getInvertedGradient(themeController.isDarkMode.value),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildProfileMenuItems(context, themeController),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container();

  Widget buildProfileMenuItems(
          BuildContext context, ThemeController themeController) =>
      Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            ListTile(
              leading: Image.asset(RImages.wLogo, width: 60),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              )),
            ),
            const Divider(
              color: Colors.white,
              height: 50,
            ),
            Obx(
              () => ListTile(
                  leading: const Icon(Icons.brightness_4,
                      color: Colors.white), //brightness_5,
                  title: Text(
                    S.of(context).theme,
                    style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                  ),
                  trailing: Icon(
                    themeController.isDarkMode.value
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Colors.white,
                  ),
                  onTap: themeController.toggleTheme),
            ),
            ListTile(
                leading: const Icon(Icons.mode_edit_outline_rounded,
                    color: Colors.white), //notifications_off
                title: Text(
                  S.of(context).edit_profile,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ));
                }),
            ListTile(
                leading: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                title: Text(
                  S.of(context).change_password,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                }),
            ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                title: Text(
                  S.of(context).delete_account,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                }),
            const SizedBox(height: 525),
            ListTile(
                leading: const Icon(Icons.logout_outlined, color: Colors.white),
                title: Text(
                  S.of(context).logout,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: logout),
          ],
        ),
      );
}
