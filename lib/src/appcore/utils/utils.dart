import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mawad/src/appcore/widgets/app.snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  static Future<String> loadJsonAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  static String readTestFixture(String name) =>
      File('test/fixture/$name').readAsStringSync();

  static String readFixture(String name) =>
      File('assets/fixture/$name').readAsStringSync();

  static bool isUrl(String x) {
    try {
      return Uri.parse(x).isAbsolute;
    } catch (e) {
      return false;
    }
  }

  static String? validateNoEmpty(dynamic input) {
    if (input == null ||
        (input.runtimeType == String && input.trim().isEmpty)) {
      return 'Required Field!';
    }
    return null;
  }

  static Future GetImage(BuildContext context, Function(bool) isLoading,
      Function(String) onUpload) async {
    try {
      File image;
      var imagePicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      isLoading(true);
      if (imagePicker != null) {
        image = File(imagePicker.path);
        if (await image.exists()) {
          onUpload(imagePicker.path);
        }
      }
      isLoading(false);
    } catch (e) {
      print('yyy' + e.toString());
    }
  }

  static String GetTimeZoneOffset() {
    Duration duration = DateTime.now().timeZoneOffset;
    String toDigits(int n) => n.toString().padLeft(2, "0");
    String twoHour = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    if (duration.inMinutes > 0) {
      return "+$twoHour:$twoDigitMinutes";
    }
    return "-$twoHour:$twoDigitMinutes";
  }

  static String twoDigits(int num) {
    return num < 10 ? '0$num' : '$num';
  }

  static DateTime ParseDate(String value) {
    String dateUtc = value
        .substring(
            0,
            (value.lastIndexOf('+') == -1
                    ? value.lastIndexOf('-')
                    : value.lastIndexOf('+')) -
                1)
        .replaceAll("T", " ");
    var time = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true);
    Duration d = ParseTimeZoneOffset(value);
    if (d.inMinutes == 0) {
      return time.toLocal();
    } else {
      if (value.lastIndexOf('+') == -1) {
        time.add(Duration(minutes: time.timeZoneOffset.inMinutes.abs()));
      } else {
        time.subtract(Duration(minutes: time.timeZoneOffset.inMinutes.abs()));
      }
      return time.toLocal();
    }
  }

  static Duration ParseTimeZoneOffset(String val) {
    String t1 = val.substring(
        val.lastIndexOf('+') == -1
            ? val.lastIndexOf('-') + 1
            : val.lastIndexOf('+') + 1,
        val.lastIndexOf(':') - 1);
    String t2 = val.substring(val.lastIndexOf(':') + 1);
    return Duration(minutes: int.parse(t2), hours: int.parse(t2));
  }

  static Future dial(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(_phoneUri)) {
        if (!await launchUrl(_phoneUri)) {
          throw Exception('Could not launch $_phoneUri');
        }
      }
    } catch (error) {
      AppSnackBar.error(
          message:
              'Can\'t call the number ($contactNumber) due to unknown reason');
    }
  }

  static Color HexColor(String s) {
    String color = s.replaceAll('#', '0xFF');
    return Color(int.parse(color));
  }
}
