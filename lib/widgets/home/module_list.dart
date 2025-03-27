import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/navigation/screens/home/quizes_screen.dart';

class ModuleList extends StatelessWidget {
  final int selectedCategoryId;

  const ModuleList({super.key, required this.selectedCategoryId});

  Future<List<Map<String, dynamic>>> fetchModules() async {
    final supabase = Supabase.instance.client;
    return await supabase.from('modules').select().eq('category_id', selectedCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchModules(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text(S.of(context).no_modules_available);
        }

        final modules = snapshot.data!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: modules.map((module) {
            return ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizesScreen(moduleId: module['id'], moduleName: module['module_name']),
                ));
              },
              child: Text(module['module_name'] ?? S.of(context).unnamed),
            );
          }).toList(),
        );
      },
    );
  }
}
