import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Importa Supabase
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:quiz_app/widgets/category_tile.dart'; // Asegúrate de que este archivo exista

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({super.key});

  @override
  _ModuleScreenState createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  final ThemeController themeController = Get.find();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> categories = [];
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _loadCategories();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && hasMore) {
        _loadCategories();
      }
    });
  }

  Future<void> _loadCategories() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await Supabase.instance.client
          .from('categories')
          .select('*')
          .range((page - 1) * 10, page * 10 - 1); // Asegúrate de usar el rango para paginación

      // Verifica si la respuesta no es vacía
      if (response.isNotEmpty) {
        setState(() {
          categories.addAll(response); // Agrega las categorías obtenidas
          isLoading = false;
          page++; // Avanza a la siguiente página para paginación
          if (response.length < 10) {
            hasMore = false; // Si hay menos de 10 elementos, no hay más que cargar
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error fetching categories: No data found');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mecánica",
          style: GoogleFonts.play(
            color: themeController.isDarkMode.value
                ? AppTheme.darkPurple
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: themeController.isDarkMode.value
            ? const IconThemeData(color: AppTheme.darkPurple, size: 40)
            : const IconThemeData(color: AppTheme.lightBackground, size: 40),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: themeController.isDarkMode.value
              ? const Icon(Icons.arrow_back_sharp, color: AppTheme.darkPurple)
              : const Icon(Icons.arrow_back_sharp,
                  color: AppTheme.lightBackground),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: themeController.isDarkMode.value
            ? const BoxDecoration(gradient: AppTheme.blackBgGradient)
            : const BoxDecoration(color: AppTheme.lightBackground),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: categories.isEmpty && isLoading
                ? const Center(child: CircularProgressIndicator()) // Muestra cargando si hay datos
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Desactiva el scroll dentro del GridView
                    itemCount: categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return CategoryTile(category: categories[index]);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
