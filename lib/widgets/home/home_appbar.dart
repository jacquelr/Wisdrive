import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/navigation/screens/profile/profile_screen.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
    required this.selectedCategory,
  });
  final String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        selectedCategory ?? '',
        style: GoogleFonts.play(color: HelperFunctions.getTextThemeColor()),
      ),
      centerTitle: true,
      iconTheme:
          IconThemeData(color: HelperFunctions.getIconThemeColor(), size: 50),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle,
              color: HelperFunctions.getIconThemeColor()),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
