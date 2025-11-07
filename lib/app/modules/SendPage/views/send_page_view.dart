import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/send_page_controller.dart';

class SendPageView extends GetView<SendPageController> {
  const SendPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SendPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SendPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
