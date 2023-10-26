import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class MessageService {
  void showTopUpMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      backgroundColor: AppColorTheme.darkGray,
      colorText: Colors.white,
      borderRadius: 30,
      margin: const EdgeInsets.all(10),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOutCubic,
      reverseAnimationCurve: Curves.easeInOutCubic,
      // Any other styling or configurations
    );
  }
}
