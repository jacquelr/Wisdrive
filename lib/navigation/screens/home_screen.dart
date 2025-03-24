import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:wisdrive/navigation/screens/profile_screen.dart';
import 'package:wisdrive/navigation/screens/quizes_screen.dart';
import 'package:wisdrive/widgets/home/sidebar_menu.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.find();
  final SupabaseClient supabase = Supabase.instance.client;
  int? selectedCategoryId; // Guardamos el ID de la categoría
  int? selectedModule;

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    return await supabase.from('categories').select();
  }

  Future<List<Map<String, dynamic>>> fetchModules() async {
    if (selectedCategoryId == null) return []; // Evita ejecutar la consulta si no hay categoría seleccionada
    return await supabase
        .from('modules')
        .select()
        .eq('category_id', selectedCategoryId!); // Filtramos con el ID correcto
  }

  @override
  Widget build(context) {
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
                ? FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No hay categorías disponibles');
                      }

                      final categories = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: categories.map((category) {
                          final categoryId = category['id']; // Asegurar que existe el ID
                          if (categoryId == null) return const SizedBox(); // Evitar nulls
                          
                          return ElevatedButton(
                            onPressed: () => setState(() {
                              selectedCategoryId = categoryId as int; // Asegurar que sea un entero
                            }),
                            child: Text(category['name'] ?? 'Sin nombre'), // Manejo seguro de nulls
                          );
                        }).toList(),
                      );
                    },
                  )
                : FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchModules(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No hay módulos disponibles');
                      }

                      final modules = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: modules.map((module) {
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      QuizesScreen(moduleId: module['id'])));
                            },
                            child: Text(module['module_name'] ?? 'Sin nombre'),
                          );
                        }).toList(),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
