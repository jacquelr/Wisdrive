import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:wisdrive/navigation/screens/home/chat_screen.dart';
import 'package:wisdrive/navigation/screens/profile/profile_screen.dart';
import 'package:wisdrive/widgets/home/basic_mecanic.dart';
import 'package:wisdrive/widgets/home/main_view.dart';
import 'package:wisdrive/widgets/home/sidebar_menu.dart';
import 'package:wisdrive/widgets/home/category_list.dart';
import 'package:wisdrive/widgets/home/module_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.find();
  int? selectedCategoryId;

  String? getSelectedCategory() {
    switch (selectedCategoryId) {
      case 1:
        return S.of(context).basic_mechanics;
      case 2:
        return S.of(context).traffic_regulations;
      case 3:
        return S.of(context).road_culture;
      default:
        return null;
    }
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
          title: Text(
            getSelectedCategory() ?? '',
            style: GoogleFonts.play(color: HelperFunctions.getTextThemeColor()),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
              color: HelperFunctions.getIconThemeColor(), size: 50),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle,
                  color: HelperFunctions.getIconThemeColor()),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ));
              },
            ),
          ],
        ),
        drawer: const SidebarMenu(),
        body: Stack(
          children: [
            // Fondo con gradiente según modo oscuro/claro
            Container(
              decoration: themeController.isDarkMode.value
                  ? BoxDecoration(
                      gradient: AppTheme.getInvertedGradient(
                          themeController.isDarkMode.value),
                    )
                  : const BoxDecoration(color: AppTheme.lightBackground),
            ),
            // Contenedor blanco con bordes redondeados
            Positioned(
              top:
                  MediaQuery.of(context).size.height * 0.10, // Antes del AppBar
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: HelperFunctions.getContainerThemeColor(),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                        height: 20), // Espacio antes de mostrar módulos
                    Expanded(
                      child: selectedCategoryId == null
                          ? const MainView()
                          : Column(
                              children: [
                                if (selectedCategoryId == 3)
                                  const BasicMecanic(),
                                Expanded(
                                  child: ModuleList(
                                      selectedCategoryId: selectedCategoryId!),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 20), // Espacio antes de los botones
                    CategoryList(onCategorySelected: (id) {
                      setState(() {
                        selectedCategoryId = id;
                      });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ChatScreen(),
              ));
            },
            backgroundColor: AppTheme.darkPurple,
            child: const Icon(Icons.chat, color: white),
          ),
        ),
      ),
    );
  }
}
