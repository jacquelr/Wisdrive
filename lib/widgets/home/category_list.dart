import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: categories.map((category) {
            final categoryId = category['id'];
            if (categoryId == null) return const SizedBox();

            return ElevatedButton(
              onPressed: () => onCategorySelected(categoryId as int),
              child: Text(category['name'] ?? S.of(context).unnamed),
            );
          }).toList(),
        );
      },
    );
  }
}