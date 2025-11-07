import 'package:cryptoreliwell/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller.walletController;
    final theme = Theme.of(context);

    return Scaffold(
      // backgroundColor: const Color(0xff0f2027),
      appBar: AppBar(
        title: const Text(
          'My Wallet',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              controller.secureStorage.deleteAll();
              Get.toNamed(Routes.GENRATE_PHRASE);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.lightGreen.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black87, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Wallet",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Balance",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Obx(
                          () => IconButton(
                            onPressed: () {
                              print("isvisible ${controller.isVisible.value}");
                              controller.isVisible.value =
                                  !controller.isVisible.value;
                              print("Show balance");
                            },
                            icon: Icon(
                              controller.isVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => Text(
                        controller.isVisible.value ? "\$1950.253" : "XXXXXXX",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),

                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color(0xff0f2027),
                  //     Color(0xff203a43),
                  //     Color(0xff2c5364),
                  //   ],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //   Container(
                      //     padding: const EdgeInsets.all(20),
                      //     decoration: BoxDecoration(
                      //       // color: Colors.lightGreen.withOpacity(0.4),
                      //       gradient: LinearGradient(
                      //         colors: [
                      //           Color(0xff0f2027),
                      //           Color(0xff203a43),
                      //           Color(0xff2c5364),
                      //         ],
                      //         begin: Alignment.topCenter,
                      //         end: Alignment.bottomCenter,
                      //       ),
                      //       borderRadius: BorderRadius.circular(20),
                      //       border: Border.all(color: Colors.white24, width: 1),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black.withOpacity(0.2),
                      //           blurRadius: 10,
                      //           offset: const Offset(0, 4),
                      //         ),
                      //       ],
                      //     ),
                      //     child: Obx(() {
                      //       final addr = ctrl.address.value;
                      //       final bal = ctrl.balance.value;

                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           const Text(
                      //             'Wallet Address',
                      //             style: TextStyle(
                      //               color: Colors.white70,
                      //               fontSize: 14,
                      //             ),
                      //           ),
                      //           const SizedBox(height: 6),
                      //           SelectableText(
                      //             addr.isEmpty ? "Loading..." : addr,
                      //             style: const TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //           const SizedBox(height: 20),
                      //           const Text(
                      //             'Balance',
                      //             style: TextStyle(
                      //               color: Colors.white70,
                      //               fontSize: 14,
                      //             ),
                      //           ),
                      //           const SizedBox(height: 6),
                      //           Text(
                      //             "$bal ETH",
                      //             style: const TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 26,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     }),
                      //   ),
                      // const SizedBox(height: 1),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => coinListTile(
                              controller.isVisible.value,
                              onTap: () {
                                Get.toNamed(
                                  Routes.SHOW_WALLET,
                                  arguments: {'address': ctrl.address.value},
                                );
                              },
                              image:
                                  "https://media.istockphoto.com/id/1033874896/vector/blockchain-bitcoin-icon.jpg?s=612x612&w=0&k=20&c=yzGKzb1A0moFQFxSoMw1hXHaWKqOzdcJ1ShFWRyNaGQ=",
                              coinName: 'BTC',
                              coinQty: "12.65",
                              currentCoinValue: "\$10005325.332",
                              presentPrice: '\$102562',
                            ),
                          );
                        },
                      ),

                      // // 🔸 QR Code
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(16),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black.withOpacity(0.3),
                      //         blurRadius: 10,
                      //       ),
                      //     ],
                      //   ),
                      //   padding: const EdgeInsets.all(16),
                      //   child: Obx(
                      //     () => QrImageView(
                      //       data: ctrl.address.value.isNotEmpty
                      //           ? ctrl.address.value
                      //           : "No Address",
                      //       size: 180,
                      //       backgroundColor: Colors.white,
                      //     ),
                      //   ),
                      // ),

                      // const SizedBox(height: 40),

                      // 🔹 Action Buttons
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     _WalletActionButton(
                      //       icon: Icons.send_rounded,
                      //       label: "Send",
                      //       color: Colors.tealAccent,
                      //       onTap: () => Get.toNamed(Routes.SEND_PAGE),
                      //     ),
                      //     _WalletActionButton(
                      //       icon: Icons.download_rounded,
                      //       label: "Receive",
                      //       color: Colors.blueAccent,
                      //       onTap: () => Get.toNamed(Routes.RECEIVE_PAGE),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget coinListTile(
  bool isVisible, {
  String? image,
  String? coinName,
  String? presentPrice,
  String? coinQty,
  String? currentCoinValue,
  Callback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 199, 255, 228).withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(blurRadius: 1, color: Colors.black87, offset: Offset(2, 2)),
        ],
      ),

      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                image ?? '',
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(coinName ?? ''), Text(presentPrice ?? '')],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isVisible ? Text(coinQty ?? '') : Text('*****'),
                isVisible ? Text(currentCoinValue ?? '') : Text("**********"),
              ],
            ),
          ],
        ),
      ),
    ),
  );
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
