import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/chip_button.dart';

class ChipGroup extends StatefulWidget {
  const ChipGroup({super.key});

  @override
  _ChipGroupState createState() => _ChipGroupState();
}

class _ChipGroupState extends State<ChipGroup> {
  int selectedChipIndex = 0; // Initialize to -1 for no selection

  void handleChipSelection(int index) {
    setState(() {
      selectedChipIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChipButton(
          label: "غرفة مزدوجة",
          isSelected: selectedChipIndex == 0,
          onPressed: () {
            handleChipSelection(0);
          },
        ),
        SizedBox(
          width: 10.w,
        ),
        ChipButton(
          label: "غرفة أحادية",
          isSelected: selectedChipIndex == 1,
          onPressed: () {
            handleChipSelection(1);
          },
        ),
        // Add more ChipButtons as needed
      ],
    );
  }
}
