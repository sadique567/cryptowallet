import 'package:cryptoreliwell/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/show_wallet_controller.dart';

class ShowWalletView extends GetView<ShowWalletController> {
  const ShowWalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ShowWalletView'), centerTitle: true),
      body: Column(
        children: [
          // 🔸 QR Code
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => QrImageView(
                data: controller.walletAddress.value.isNotEmpty
                    ? controller.walletAddress.value
                    : "No Address",
                size: 180,
                backgroundColor: Colors.white,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: SelectableText(
                    controller.walletAddress.value,
                    maxLines: 3,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(
                      new ClipboardData(text: controller.walletAddress.value),
                    );
                  },
                  icon: Icon(Icons.copy),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 🔹 Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WalletActionButton(
                icon: Icons.send_rounded,
                label: "Send",
                color: Colors.tealAccent,
                onTap: () => Get.toNamed(Routes.SEND_PAGE),
              ),
              _WalletActionButton(
                icon: Icons.download_rounded,
                label: "Receive",
                color: Colors.blueAccent,
                onTap: () => Get.toNamed(Routes.RECEIVE_PAGE),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 🔘 Custom reusable button widget
class _WalletActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _WalletActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 4,
      ),
    );
  }
}
