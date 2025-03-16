import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_app/service/auth_gate.dart';

class OnboardingController extends GetxController{
  static OnboardingController get instance => Get.find();

  //Variables
  final pageConroller = PageController();
  Rx<int> currentPageIndex = 0.obs;
  
  //Update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //Jump to the specific dot selected page
  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageConroller.jumpTo(index);
  }

  //Update current index & jump to next page
  void nextPage() {
    if(currentPageIndex.value == 2) {
     Get.to(const AuthGate());
    } else {
      int page = currentPageIndex.value + 1;
      pageConroller.jumpToPage(page);
    }
  }

  //Update current index & jump to the last Page
  void skipPage(){
    currentPageIndex.value = 2;
    Get.to(const AuthGate());
  }

}