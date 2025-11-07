import 'package:get/get.dart';

import '../controllers/genrate_phrase_controller.dart';

class GenratePhraseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GenratePhraseController>(GenratePhraseController());
  }
}
