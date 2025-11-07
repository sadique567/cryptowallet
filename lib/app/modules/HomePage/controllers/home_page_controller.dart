import 'package:cryptoreliwell/app/modules/CreateWalletPage/controllers/create_wallet_page_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  //TODO: Implement HomePageController

final RxBool isVisible = true.obs;
  final walletController = Get.put(CreateWalletPageController());
  FlutterSecureStorage secureStorage = FlutterSecureStorage();  

  @override
  void onInit() {
    super.onInit();
  }
}
