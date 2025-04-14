import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/navigation/screens/profile/edit_profile_screen.dart';
import 'package:wisdrive/navigation/screens/home/home_screen.dart';
import 'package:wisdrive/service/auth_service.dart';

class SidebarProfile extends StatefulWidget {
  const SidebarProfile({super.key});

  @override
  State<SidebarProfile> createState() => _SidebarProfileState();
}

class _SidebarProfileState extends State<SidebarProfile> {
  final authservice = AuthService();
  final ThemeController themeController = Get.find();

  void logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.darkPurple,
        title: Text(
          '¿Estás seguro?',
          textAlign: TextAlign.center,
          style: GoogleFonts.play(
            color: themeController.isDarkMode.value
                ? Colors.white
                : AppTheme.lightSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Divider(endIndent: 5),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await authservice.signOut();
            },
            child: Text(
              S.of(context).logout,
              style: GoogleFonts.play(color: Colors.red, fontSize: 16),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).cancel,
                style: GoogleFonts.play(
                    color: themeController.isDarkMode.value
                        ? Colors.white
                        : AppTheme.darkPurple,
                    fontSize: 16),
              ))
        ]),
      ),
    );
  }

  @override
  Widget build(context) {
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
