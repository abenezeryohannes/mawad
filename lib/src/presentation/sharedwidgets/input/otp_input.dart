import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:pinput/pinput.dart';

class OtpInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final Function(String?) validator;
  final Function(String) onCompleted;

  const OtpInput({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.number,
    this.maxLength = 4,
    required this.validator,
    required this.onCompleted,
  });

  @override
  _OtpInputState createState() => _OtpInputState();

  @override
  String toStringShort() => 'OtpInput';
}

class _OtpInputState extends State<OtpInput> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 66.0,
      height: 66.0,
      textStyle: const TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(66.0),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 68,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          defaultPinTheme: defaultPinTheme,
          followingPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: AppColorTheme.lightGray2,
              borderRadius: BorderRadius.circular(66.0),
            ),
          ),
          validator: (s) => widget.validator(s),
          onCompleted: (pin) => widget.onCompleted(pin),
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: false,
        ),
      ),
    );
  }
}
