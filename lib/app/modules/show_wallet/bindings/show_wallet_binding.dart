import 'package:get/get.dart';

import '../controllers/show_wallet_controller.dart';

class ShowWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowWalletController>(
      () => ShowWalletController(),
    );
  }
}
