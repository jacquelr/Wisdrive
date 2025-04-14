import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/controllers/onboarding_controller.dart';
import 'package:wisdrive/controllers/theme_controller.dart';
import 'package:wisdrive/data/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../generated/l10n.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(context) {
    final ThemeController themeController = Get.find();
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageConroller,
              onPageChanged: controller.updatePageIndicator,
              children: [
                Onboarding(
                  themeController: themeController,
                  text: S.of(context).onboarding_1,
                  image: RImages.onboarding_1,
                ),
                Onboarding(
                  themeController: themeController,
                  text: S.of(context).onboarding_2,
                  image: RImages.onboarding_2,
                ),
                Onboarding(
                  themeController: themeController,
                  text: S.of(context).onboarding_3,
                  image: RImages.onboarding_3,
                ),
              ],
            ),
            Positioned(
              top: 1,
              right: 1,
              child: TextButton(
                onPressed: () => OnboardingController.instance.skipPage(),
                child: Text(
                  S.of(context).SKIP,
                  style: GoogleFonts.play(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 25,
              child: SmoothPageIndicator(
                controller: controller.pageConroller,
                onDotClicked: controller.dotNavigationClick,
                count: 3,
                effect: const ExpandingDotsEffect(
                    activeDotColor: AppTheme.lightSecondary, dotHeight: 6),
              ),
            ),
            Positioned(
              bottom: 1,
              right: 1,
              child: IconButton(
                icon: const Icon(Icons.arrow_circle_right, size: 50),
                onPressed: () => OnboardingController.instance.nextPage(),
              ),
            ),
          ],
        ),
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
