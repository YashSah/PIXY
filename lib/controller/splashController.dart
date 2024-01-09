import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pixy/screen/home_screen.dart';
import 'package:pixy/screen/onboarding_screen.dart';

import '../helper/pref.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splashController();
  }

  void splashController(){
    Future.delayed(Duration(seconds: 4), () {
      Get.offAll(Pref.showOnboarding ? const OnboardingScreen() : const HomeScreen());
    });
  }
}