import 'package:cryptoreliwell/app/modules/CreateWalletPage/controllers/create_wallet_page_controller.dart';
import 'package:cryptoreliwell/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateWalletPageView extends GetView<CreateWalletPageController> {
  const CreateWalletPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2, // 🔹 Two tabs — Phrase & Private Key
      child: Scaffold(
        backgroundColor: const Color(0xff0f2027),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff0f2027),
                  Color(0xff203a43),
                  Color(0xff2c5364),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // 🪙 Title
                  const Text(
                    "Create / Import Wallet",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Securely create a new wallet or import existing one.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // 💳 Wallet Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 🌱 Create Wallet Button
                        ElevatedButton.icon(
                          onPressed: () async {
                            await controller.createNewWallet();
                            Get.offNamed(Routes.HOME_PAGE);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.tealAccent[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 6,
                          ),
                          icon: const Icon(Icons.add_circle_outline_rounded),
                          label: const Text(
                            "Create New Wallet",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // 🔑 Import Wallet Section
                        const Text(
                          "Or Import Existing Wallet",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 12),

                        // 🔹 TabBar above TextField
                        TabBar(
                          labelColor: Colors.tealAccent,
                          unselectedLabelColor: Colors.white54,
                          indicatorColor: Colors.transparent,
                          indicatorWeight: 2.5,
                          dividerColor: Colors.transparent,

                          tabs: [
                            Tab(text: 'Phrase'),
                            Tab(text: 'Private Key'),
                          ],
                        ),

                        // const SizedBox(height: 16),

                        // 🔹 TabBarView below the TabBar
                        SizedBox(
                          height: 200,
                          child: TabBarView(
                            children: [
                              // =================== PHRASE TAB ===================
                              Column(
                                children: [
                                  TextField(
                                    controller: controller.existingPhrase,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.15),
                                      hintText: "example: apple window car ...",
                                      hintStyle: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.white30,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.tealAccent,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                    minLines: 1,
                                    maxLines: 6,
                                  ),
                                  // ==========PAST
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          ClipboardData? data =
                                              await Clipboard.getData(
                                                Clipboard.kTextPlain,
                                              );
                                          if (data?.text != null) {
                                            controller.existingPhrase.text =
                                                data!.text!;
                                          }
                                        },
                                        child: const Text(
                                          'Paste',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // ====Import wallet Button =======
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await controller.importWallet(
                                          controller.existingPhrase.text.trim(),
                                        );
                                        Get.offNamed(Routes.HOME_PAGE);
                                      } catch (e) {
                                        Get.snackbar(
                                          'Error',
                                          e.toString(),
                                          backgroundColor: Colors.redAccent,
                                          colorText: Colors.white,
                                        );
                                      }
                                    },
                                    child: const Text("Import Wallet"),
                                  ),
                                ],
                              ),

                              // ====== PRIVATE KEY TAB =======
                              Column(
                                children: [
                                  TextField(
                                    controller: controller.privateKeyImp,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.15),
                                      hintText:
                                          "Enter your private key (hex format)",
                                      hintStyle: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.white30,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.tealAccent,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                    maxLines: 2,
                                  ),
                                  // const SizedBox(height: 10),
                                  // ==========PAST
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          ClipboardData? data =
                                              await Clipboard.getData(
                                                Clipboard.kTextPlain,
                                              );
                                          if (data?.text != null) {
                                            controller.privateKeyImp.text =
                                                data!.text!;
                                          }
                                        },
                                        child: const Text(
                                          'Paste',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ElevatedButton(
                                    onPressed: () {
                                      Get.snackbar(
                                        'Feature Coming Soon',
                                        'Private key import not yet implemented.',
                                        backgroundColor: Colors.tealAccent,
                                        colorText: Colors.black,
                                      );
                                    },
                                    child: const Text(
                                      "Import with Private Key",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // 🧠 Display Generated Mnemonic
                        Obx(() {
                          final phrase = controller.mnemonic.value;
                          if (phrase.isEmpty) {
                            return const SizedBox();
                          }
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Account Created Successfully",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SelectableText(
                                        phrase,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                          new ClipboardData(
                                            text: controller.mnemonic.value,
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // ⚠️ Security Note
                  const Text(
                    "⚠️ Never share your recovery phrase with anyone.",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
