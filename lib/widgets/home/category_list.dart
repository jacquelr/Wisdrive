import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';

class CategoryList extends StatelessWidget {
  final Function(int) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final supabase = Supabase.instance.client;
    return await supabase.from('categories').select();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text(S.of(context).no_categories_available);
        }

        final categories = snapshot.data!;

        return Container(
          height: 70,
          decoration: const BoxDecoration(
            color: AppTheme.darkPurple, // Fondo morado
          ),
          child: Row(
            children: categories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              final categoryId = category['id'];

              if (categoryId == null) return const SizedBox();

              return Expanded(
                child: Row(
                  children: [
                    if (index != 0)
                      const VerticalDivider(
                        color: AppTheme.darkPurple, // Color del separador
                        thickness: 4,
                        width: 4,
                      ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => onCategorySelected(categoryId as int),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.mediumPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          
                        ),
                        child: Text(
                          category['name'] ?? S.of(context).unnamed,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                        ),

                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
