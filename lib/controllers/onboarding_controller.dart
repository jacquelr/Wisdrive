import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_app/service/auth_gate.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  //Variables
  final box = GetStorage();
  final pageConroller = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //Update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageConroller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  //Update current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      box.write("isFirstTime", false);
      Get.offAll(const AuthGate());
    } else {
      int nextPage = currentPageIndex.value + 1;
      pageConroller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  //Update current index & jump to the last Page
  void skipPage() {
    box.write("isFirstTime", false);
    Get.offAll(const AuthGate());
  }
}
