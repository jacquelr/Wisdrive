import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/navigation/screens/home/chat_screen.dart';
import 'package:wisdrive/navigation/screens/profile/edit_profile_screen.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/widgets/home/home_appbar.dart';
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
  final authService = AuthService();
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

  void isFirstTimeLogged() {
    bool isFirstTimeLogged = authService.isFirstTimeLogged();
    if (isFirstTimeLogged) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFirstTimeLogged();
    });
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
        appBar: HomeAppbar(selectedCategory: getSelectedCategory()),
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
                                selectedCategoryId == 3
                                ? const BasicMecanic()
                                : Expanded(
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
