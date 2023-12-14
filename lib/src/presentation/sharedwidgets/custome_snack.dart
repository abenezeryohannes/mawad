import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar(
    {required String title,
    required String message,
    Color? backgroundColor,
    Color? colorText}) {
  Get.snackbar(
    "",
    "",
    backgroundColor: backgroundColor ?? Colors.grey[200],
    colorText: colorText ?? Colors.red,
    titleText: Text(
      title,
      style: TextStyle(
        color: colorText ?? Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyle(
        color: colorText ?? Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
