import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import '../../generated/l10n.dart';

class CategoryProps {
  final int? id; // null para Home
  final String name;
  final IconData icon;

  const CategoryProps({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class CategoryList extends StatelessWidget {
  final Function(int?) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    // List with the names of the three categories (multilanguaje implemented)
    final List<CategoryProps> categoryButtons = [
      CategoryProps(id: null, name: S.of(context).home, icon: Icons.home),
      CategoryProps(id: 1, name: S.of(context).road_culture, icon: Icons.traffic),
      CategoryProps(id: 2, name: S.of(context).regulations, icon: Icons.rule),
      CategoryProps(id: 3, name: S.of(context).mechanics, icon: Icons.build),
    ];

    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppTheme.darkPurple,
      ),
      child: Row(
        children: categoryButtons.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;

          return Expanded(
            child: Row(
              children: [
                if (index != 0)
                  const VerticalDivider(
                    color: AppTheme.darkPurple,
                    thickness: 4,
                    width: 4,
                  ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onCategorySelected(category.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.mediumPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category.icon, color: Colors.white, size: 20),
                        const SizedBox(height: 4),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.play(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
