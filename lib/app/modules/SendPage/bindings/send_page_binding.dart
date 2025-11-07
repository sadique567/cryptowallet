import 'package:get/get.dart';

import '../controllers/send_page_controller.dart';

class SendPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SendPageController>(SendPageController());
  }
}
