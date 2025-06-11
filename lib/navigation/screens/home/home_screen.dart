import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/navigation/screens/home/chat_screen.dart';
import 'package:wisdrive/navigation/screens/profile/create_profile_screen.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/service/supabase_service.dart';
import 'package:wisdrive/widgets/home/home_appbar.dart';
import 'package:wisdrive/widgets/home/basic_mecanic.dart';
import 'package:wisdrive/widgets/home/main_view.dart';
import 'package:wisdrive/widgets/home/sidebar_menu.dart';
import 'package:wisdrive/widgets/home/category_list.dart';
import 'package:wisdrive/widgets/home/module_list.dart';
import '../../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.find();
  final authService = Get.find<AuthService>();
  final supabaseService = Get.find<SupabaseService>();
  int? selectedCategoryId;

  // Displays the category the user is in in the app bar
  String? getSelectedCategory() {
    switch (selectedCategoryId) {
      case 1:
        return S.of(context).basic_mechanics;
      case 2:
        return S.of(context).traffic_regulations;
      case 3:
        return S.of(context).road_culture;
      default:
        return null; // This means main view = no title
    }
  }

  // Redirect to EditProfileScreen if it is the user's first time using the app to input his information
  void checkFirstTimeLogged() async {
    bool isExistent = await supabaseService.isExistentUser();
    if (!isExistent) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const CreateProfileScreen(),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkFirstTimeLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppbar(selectedCategory: getSelectedCategory()),
      drawer: const SidebarMenu(),
      body: Stack(
        children: [
          // Background gradient based on theme mode
          Container(
            decoration: themeController.isDarkMode.value
                ? BoxDecoration(
                    gradient: AppTheme.getInvertedGradient(
                        themeController.isDarkMode.value),
                  )
                : const BoxDecoration(color: AppTheme.lightBackground),
          ),
          // White container with rounded borders
          Positioned(
            top:
                MediaQuery.of(context).size.height * 0.12, // Space below AppBar
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
                  Expanded(
                    // Switches between category content
                    child: selectedCategoryId == null
                        ? const MainView()
                        : Column(
                            children: [
                              selectedCategoryId == 1
                                  ? const Expanded(
                                      child:
                                          BasicMecanic()) // Basic mechanics content
                                  : Expanded(
                                      child: ModuleList(
                                          // Road culture or Traffic regulations modules
                                          selectedCategoryId:
                                              selectedCategoryId!),
                                    ),
                            ],
                          ),
                  ),
                  CategoryList(onCategorySelected: (id) {
                    // MenuBar of categories
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
        // Chatbot bubble on bottom-right side of screen
        padding: const EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ChatScreen(),
            ));
          },
          backgroundColor: AppTheme.darkPurple,
          child: const Icon(Icons.chat, color: Colors.white),
        ),
      ),
    );
  }
}
