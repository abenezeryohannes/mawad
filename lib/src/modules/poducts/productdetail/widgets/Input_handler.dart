import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/textarea_filed.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class InputAddonHandler extends StatefulWidget {
  const InputAddonHandler({super.key});

  @override
  State<InputAddonHandler> createState() => _InputAddonHandlerState();
}

class _InputAddonHandlerState extends State<InputAddonHandler> {
  final TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PrimerCard(
      height: 200.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "هل لديك مواصفات خاصة؟",
              style: AppTextTheme.darkblueTitle16,
            ),
          ),
          TextAreaFiled(
            controller:
                myController, // You need to create a TextEditingController
            hintText: '',
            onChanged: (text) {
              // Handle text changes here
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "* سيتم الرد على الطلب الخاص خلال يومان عمل.",
              style: AppTextTheme.graysubtitle12,
            ),
          ),
        ],
      ),
    );
  }
}
