import 'package:get/get.dart';

import '../controllers/backup_phrase_page_controller.dart';

class BackupPhrasePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BackupPhrasePageController>(BackupPhrasePageController());
  }
}
