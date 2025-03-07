import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constraints/helper_functions.dart';
import 'package:quiz_app/constraints/images_routes.dart';
import '../../generated/l10n.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image(
                width: HelperFunctions.screenWidth() * 0.8,
                height: HelperFunctions.screenHeight() * 0.6,
                image: const AssetImage(RImages.onboarding_1),
              ),
              Text(
                "",
                style: GoogleFonts.play(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
