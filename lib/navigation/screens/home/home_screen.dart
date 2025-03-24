import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:wisdrive/navigation/screens/profile_screen.dart';
import 'package:wisdrive/widgets/home/sidebar_menu.dart';
import 'package:wisdrive/widgets/home/category_list.dart';
import 'package:wisdrive/widgets/home/module_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.find();
  int? selectedCategoryId;

  String? getSelectedCategory() {
    String? categoryTitle;
    switch (selectedCategoryId) {
      case null: categoryTitle = '';
      break;
      case 1: categoryTitle = S.of(context).basic_mechanics;
      break;
      case 2: categoryTitle = S.of(context).traffic_regulations;
      break;
      case 3: categoryTitle = S.of(context).road_culture;
      break;
      default: break;
    }
    return categoryTitle;
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(getSelectedCategory()!, style: GoogleFonts.play(color: Colors.white),),
          centerTitle: true,
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
            child: selectedCategoryId == null
                ? CategoryList(onCategorySelected: (id) {
                    setState(() {
                      selectedCategoryId = id;
                    });
                  })
                : ModuleList(selectedCategoryId: selectedCategoryId!),
          ),
        ),
      ),
    );
  }
}
