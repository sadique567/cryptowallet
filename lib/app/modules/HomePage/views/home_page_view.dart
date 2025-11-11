import 'package:cryptoreliwell/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          // return controller.loadWallets();
          return Future.delayed(Duration(seconds: 1));
        },
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),

                  child: Obx(
                    () => ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.coins.length,
                      itemBuilder: (context, index) {
                        final coin = controller.coins[index];
                        // controller.getCurrentPrice(coin['symbol']);
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.SHOW_WALLET,
                              arguments: {"address": coin['address']},
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  coin['url'],
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${coin['name']} (${coin['symbol']})",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),

                                      StreamBuilder(
                                        stream: coin['current_price'],
                                        builder: (context, snapshot) {
                                          // if (snapshot.hasData) {
                                          //   return const Text("Loading......");
                                          // }
                                          return Text(
                                            "\$${snapshot.data}",
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),

                                      // const SizedBox(height: 6),
                                      // SelectableText(
                                      //   coin['address'],
                                      //   maxLines: 3,
                                      //   style: const TextStyle(
                                      //     fontSize: 14,
                                      //     color: Colors.black87,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => controller.isVisible.value
                                          ? Text(
                                              "bal : ${coin['balance'] ?? ""}",
                                            )
                                          : Text("XXXXX"),
                                    ),

                                    StreamBuilder(
                                      stream: coin['total_usdt'],
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData)
                                          return Text("Loading...");
                                        // return Text("\$${snapshot.data!.toStringAsFixed(2)}");
                                        return controller.isVisible.value
                                            ? Text(
                                                "\$ ${snapshot.data}",
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : Text("XXXX");
                                      },
                                    ),
                                    // Text("USDT : ${coin['total_usdt']}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
