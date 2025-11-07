import 'package:cryptoreliwell/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/genrate_phrase_controller.dart';

class GenratePhraseView extends GetView<GenratePhraseController> {
  const GenratePhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0f2027), Color(0xff203a43), Color(0xff2c5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🪙 App Logo (optional placeholder)
              const Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 100,
              ),

              const SizedBox(height: 30),

              // 🔹 App Title
              const Text(
                'RELIWELL',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // 🔸 Subtitle
              const Text(
                'Your Secure Crypto Wallet',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              const SizedBox(height: 60),

              // 💳 Create Wallet Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  Get.toNamed(Routes.CREATE_WALLET_PAGE);
                },
                child: const Text(
                  "Create New Wallet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔁 Restore Wallet Option
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.BACKUP_PHRASE_PAGE);
                },
                child: const Text(
                  "I already have a wallet",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
