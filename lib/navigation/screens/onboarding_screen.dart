import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constraints/helper_functions.dart';
import 'package:quiz_app/constraints/images_routes.dart';
import 'package:quiz_app/controllers/theme_controller.dart';
import 'package:quiz_app/data/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../generated/l10n.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Onboarding(
                themeController: themeController,
                text:
                    "¡Bienvenido a wisdrive! Aprende todo lo necesario sobre mecanica y el reglamento vial de Jalisco sin complicaciones.",
                image: RImages.onboarding_1,
              ),
              Onboarding(
                themeController: themeController,
                text:
                    "Mejora tu seguridad vial con lecciones de tráfico y mecánica para ser un conductor responsable.",
                image: RImages.onboarding_2,
              ),
              Onboarding(
                themeController: themeController,
                text:
                    "Prueba tus conocimientoson con lecciones interactivas y prepárate para cualquier situación.",
                image: RImages.onboarding_3,
              ),
            ],
          ),
          Positioned(
            top: 1,
            right: 1,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Saltar',
                style: GoogleFonts.play(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 25,
            child: SmoothPageIndicator(
                controller: PageController(),
                count: 3,
                effect: ExpandingDotsEffect(
                    activeDotColor: themeController.isDarkMode.value
                        ? AppTheme.lightBackground
                        : AppTheme.lightSecondary,
                    dotHeight: 6)),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: IconButton(
              icon: const Icon(Icons.arrow_circle_right, size: 50),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class Onboarding extends StatelessWidget {
  const Onboarding(
      {super.key,
      required this.themeController,
      required this.image,
      required this.text});

  final ThemeController themeController;
  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image(
              width: HelperFunctions.screenWidth() * 0.8,
              height: HelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image),
            ),
            Text(
              text,
              style: GoogleFonts.play(
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : AppTheme.lightSecondary,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ));
  }
}
