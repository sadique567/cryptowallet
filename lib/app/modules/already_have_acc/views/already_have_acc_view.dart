import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/already_have_acc_controller.dart';

class AlreadyHaveAccView extends GetView<AlreadyHaveAccController> {
  const AlreadyHaveAccView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AlreadyHaveAccView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AlreadyHaveAccView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
