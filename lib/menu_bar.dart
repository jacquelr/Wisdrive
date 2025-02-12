import 'package:flutter/material.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({super.key});

  @override
  Widget build(context) {
    return const Expanded(
      child: Row(
        children: [
          Icon(Icons.menu_rounded),
          Icon(Icons.account_circle),
        ],
      ),
    );
  }
}
