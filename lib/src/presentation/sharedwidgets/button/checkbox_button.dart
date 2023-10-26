import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CheckboxIcon extends StatefulWidget {
  final bool isClicked;
  final String iconPath;
  final String checkedIconPath;
  final Function(bool) onClicked;
  final TextStyle? textStyle;
  final String? title;

  const CheckboxIcon({
    Key? key,
    required this.isClicked,
    required this.iconPath,
    required this.checkedIconPath,
    required this.onClicked,
    this.textStyle,
    this.title,
  }) : super(key: key);

  @override
  _CheckboxIconState createState() => _CheckboxIconState();
}

class _CheckboxIconState extends State<CheckboxIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onClicked(!widget.isClicked); // Toggle the clicked state
        });
        // Toggle the clicked state
      },
      child: Row(
        children: [
          // Icon(
          //   widget.isClicked ? Icons.check_box : Icons.check_box_outline_blank,
          // ),
          SvgPicture.asset(
            widget.isClicked ? widget.checkedIconPath : widget.iconPath,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            widget.title ?? '',
            style: widget.textStyle,
          ),
        ],
      ),
    );
  }
}
