import 'package:get/get.dart';

import '../controllers/already_have_acc_controller.dart';

class AlreadyHaveAccBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AlreadyHaveAccController>(AlreadyHaveAccController());
  }
}
