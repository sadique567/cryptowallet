import 'package:cryptoreliwell/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  @override
  void onInit() {
    super.onInit();
    goToNextSceen();
  }

  Future goToNextSceen() async {
    await Future.delayed(Duration(seconds: 3), () {
      Get.toNamed(Routes.GENRATE_PHRASE);
    });
  }
}
