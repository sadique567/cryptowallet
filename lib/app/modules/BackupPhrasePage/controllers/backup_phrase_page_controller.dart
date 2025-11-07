import 'package:cryptoreliwell/app/data/Storage_data.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BackupPhrasePageController extends GetxController {
  // Your mnemonic phrase stored here
  final mnemonic = ''.obs;
  // StorageService storageService = StorageService();
  FlutterSecureStorage storage = FlutterSecureStorage();
  @override
  void onInit() async {
    super.onInit();
    // Example: This would normally come from secure storage or wallet creation
    getData();
  }

  void getData() async {
    final m = await storage.read(key: StorageData.PHRASE_MNEMONIC);
    mnemonic.value = m ?? '';
  }

  // 📋 Copy to clipboard
  void copyPhraseToClipboard() {
    if (mnemonic.value.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: mnemonic.value));
      Get.snackbar(
        'Copied',
        'Seed phrase copied to clipboard!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1B5E20),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  // ✅ When user confirms backup
  void onBackupConfirmed() {
    // Here you can mark backup as completed or navigate
    Get.snackbar(
      'Success',
      'Backup confirmed!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF004D40),
      colorText: const Color(0xFFFFFFFF),
    );

    // Example navigation after backup
    // Get.offNamed(Routes.HOME_PAGE);
  }
}
