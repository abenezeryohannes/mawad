import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAppBottomSheet(Widget bottomSheetContent) {
  Get.bottomSheet(
    bottomSheetContent,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
  );
}
