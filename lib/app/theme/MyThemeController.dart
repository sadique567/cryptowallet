import 'package:cryptoreliwell/app/data/Storage_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mythemecontroller extends GetxController {
  final prefs = Get.find<SharedPreferences>();
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPreferences();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToPreferences(isDarkMode.value);
  }

  void _loadThemeFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isDarkMode.value = prefs.getBool(StorageData.isDarkTheme) ?? false;
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    } catch (e) {
      print('Error loading theme: $e');
    }
  }

  void _saveThemeToPreferences(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(StorageData.isDarkTheme, isDarkMode);
    } catch (e) {
      print('Error saving theme: $e');
    }
  }
}
