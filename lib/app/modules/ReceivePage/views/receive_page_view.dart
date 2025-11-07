import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/receive_page_controller.dart';

class ReceivePageView extends GetView<ReceivePageController> {
  const ReceivePageView({super.key});
  @override
  Widget build(BuildContext context) {
final ctrl= controller.cotrollerWallet;

    return Scaffold(
appBar: AppBar(title: const Text('Receive')),
body: Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Obx(() => SelectableText(ctrl.address.value)),
const SizedBox(height: 12),
Obx(() => QrImageView(data: ctrl.address.value)),
],
),
),
);
  }
}
