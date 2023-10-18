import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterWithPhoneController extends GetxController {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG'.obs.value;

  final formKey = GlobalKey<FormState>();
}
