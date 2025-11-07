import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/backup_phrase_page_controller.dart';

class BackupPhrasePageView extends GetView<BackupPhrasePageController> {
  const BackupPhrasePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xff0f2027),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0f2027), Color(0xff203a43), Color(0xff2c5364)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              final phrase = controller.mnemonic.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // 🔹 Title
                  const Text(
                    "Backup Your Seed Phrase",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Write down these 12 words in order and keep them safe. "
                    "They are the only way to recover your wallet.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // 🧠 Mnemonic Phrase Display Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: phrase.isEmpty
                        ? const Text(
                            "No phrase found. Please generate wallet first.",
                            style: TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          )
                        : Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: phrase
                                .split(' ')
                                .asMap()
                                .entries
                                .map(
                                  (entry) => Chip(
                                    label: Text(
                                      "${entry.key + 1}. ${entry.value}",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    backgroundColor: Colors.tealAccent
                                        .withOpacity(0.3),
                                  ),
                                )
                                .toList(),
                          ),
                  ),

                  const SizedBox(height: 30),

                  // 📋 Copy Button
                  ElevatedButton.icon(
                    onPressed: () {
                      print("Phrase-> ${controller.mnemonic.value}");
                      controller.copyPhraseToClipboard();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text(
                      "Copy Phrase",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  const Spacer(),

                  // ⚠️ Security Warning
                  const Text(
                    "⚠️ Never share your recovery phrase with anyone.\n"
                    "Anyone with these words can access your wallet.",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // ✅ Confirm Backup Button
                  ElevatedButton(
                    onPressed: controller.onBackupConfirmed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "I’ve Backed It Up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
