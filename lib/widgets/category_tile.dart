// lib/widgets/category_tile.dart

import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final dynamic category; // Puedes ajustar el tipo según la estructura de tus datos

  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 50), // Puedes cambiar el ícono por algo relacionado con la categoría
            const SizedBox(height: 10),
            Text(
              category['name'], // Asumiendo que 'name' es el nombre de la categoría
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
