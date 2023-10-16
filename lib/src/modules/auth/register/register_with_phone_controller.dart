import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterWithPhoneController extends GetxController {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG'.obs.value;

  final formKey = GlobalKey<FormState>();

  PhoneNumber number = PhoneNumber(isoCode: 'NG');
}
