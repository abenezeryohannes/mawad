import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../errors/failure.dart';

class AppSnackBar {
  AppSnackBar.warning(
      {String? title, String? message, Widget? icon, SnackPosition? position}) {
    Get.snackbar(title ?? 'Dear', message ?? 'Unknown',
        icon: icon,
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        snackStyle: SnackStyle.FLOATING,
        messageText: Text(
          message ?? '----------',
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        mainButton: TextButton(
          onPressed: () {
            Get.closeCurrentSnackbar();
          },
          child: const Icon(Icons.close),
        ),
        titleText: Text(
          title ?? 'Dear',
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        duration: const Duration(hours: 1),
        backgroundColor: Colors.amber,
        margin: const EdgeInsets.all(0),
        borderRadius: 0,
        dismissDirection: DismissDirection.horizontal,
        snackPosition: position ?? SnackPosition.BOTTOM);
  }

  AppSnackBar.error({String? message, SnackPosition? position}) {
    Get.snackbar('Error', message ?? 'Unknown',
        messageText: Text(
          message ?? 'Sorry, something went wrong. try again later!',
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        titleText: const Text(
          'Error',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        snackPosition: position ?? SnackPosition.BOTTOM);
  }

  AppSnackBar.success(
      {String? title, String? message, SnackPosition? position}) {
    Get.snackbar('Successfull', message ?? '',
        messageText: Text(
          message ?? ' Task Completed !',
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        titleText: const Text(
          'Successfull',
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        snackPosition: position ?? SnackPosition.BOTTOM);
  }

  AppSnackBar.failure(
      {required Failure failure, SnackPosition? position, Duration? duration}) {
    Get.snackbar('Error', failure.message ?? 'Unknown',
        duration: duration ?? const Duration(seconds: 3),
        messageText: Text(
          failure.message ?? 'Sorry, something went wrong. try again later!',
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        titleText: const Text(
          'Error',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        snackPosition: position ?? SnackPosition.BOTTOM);
  }
}
