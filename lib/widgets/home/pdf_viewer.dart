import 'package:flutter/material.dart';

import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/app_theme.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/navigation/screens/home/pdf_viewer_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdrive/constraints/helper_functions.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PdfViewerScreen(),
          ));
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppTheme.getInvertedGradient(
                    themeController.isDarkMode.value),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.find_in_page),
            ),
            Column(
              children: [
                Text(
                  S.of(context).traffic_regulations,
                  style: GoogleFonts.play(
                      color: HelperFunctions.getWhiteBgTextThemeColor(),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  S.of(context).take_a_look,
                  style: GoogleFonts.play(
                      color: HelperFunctions.getWhiteBgTextThemeColor(),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
