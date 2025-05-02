import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/controllers/language_controller.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/navigation/screens/home/contact_support_screen.dart';
import 'package:wisdrive/navigation/screens/home/home_screen.dart';
import 'package:wisdrive/navigation/screens/home/pdf_viewer_screen.dart';
import 'package:wisdrive/navigation/screens/profile/profile_screen.dart';
import 'package:wisdrive/service/auth_service.dart';
import '../../generated/l10n.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  final authService = Get.find<AuthService>();
  final ThemeController themeController = Get.find();
  final LanguageController languageController = Get.find();

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
              buildMenuItems(context, languageController, themeController),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container();

  Widget buildMenuItems(
          BuildContext context,
          LanguageController languageController,
          ThemeController themeController) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
                leading: const Icon(Icons.person, color: Colors.white),
                title: Text(
                  S.of(context).user_profile,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
                }),
            ExpansionTile(
              leading: const Icon(Icons.language, color: Colors.white),
              title: Text(
                S.of(context).language,
                style: GoogleFonts.play(color: Colors.white, fontSize: 20),
              ),
              collapsedIconColor: Colors.white,
              children: [
                Obx(() {
                  Locale currentLocale =
                      languageController.selectedLocale.value;
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Español',
                          style: GoogleFonts.play(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        trailing: currentLocale.languageCode == 'es'
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                        onTap: () {
                          languageController
                              .changeLanguage(const Locale('es', 'MX'));
                        },
                      ),
                      ListTile(
                        title: Text(
                          'English',
                          style: GoogleFonts.play(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        trailing: currentLocale.languageCode == 'en'
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                        onTap: () {
                          languageController
                              .changeLanguage(const Locale('en', 'US'));
                        },
                      ),
                    ],
                  );
                })
              ],
            ),
            const Divider(
              color: Colors.white,
              height: 50,
            ),
            ListTile(
                // Traffic Regulations
                leading: const Icon(Icons.find_in_page, color: Colors.white),
                title: Text(
                  S.of(context).traffic_regulations,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PdfViewerScreen(),
                  ));
                }),
            ListTile(
                title: Text(
                  S.of(context).accesibility,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                }),
            ListTile(
                leading: const Icon(Icons.email, color: Colors.white),
                title: Text(
                  S.of(context).contact_us,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const ContactSupportScreen(),
                  ));
                }),
            ListTile(
                leading: const Icon(
                  Icons.privacy_tip_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  S.of(context).privacy_politics,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                }),
            ListTile(
                leading: const Icon(Icons.logout_outlined, color: Colors.red),
                title: Text(
                  S.of(context).logout,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
                onTap: () => HelperFunctions.showLogoutDialog(context)),
          ],
        ),
      );
}
