import 'package:get/get.dart';

class ShowWalletController extends GetxController {
  //TODO: Implement ShowWalletController

  final walletAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final d = Get.arguments;
    if (d != null && d is Map) {
      walletAddress.value = d['address'] ?? '';
    }
  }
}
