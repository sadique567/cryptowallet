import 'package:get/get.dart';

import '../controllers/create_wallet_page_controller.dart';

class CreateWalletPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateWalletPageController>(CreateWalletPageController());
  }
}
