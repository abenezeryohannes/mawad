import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/chip_button.dart';

class ChipGroup extends StatefulWidget {
  final List<String> labels;
  final Function(String)
      onSelectionChanged; // Callback to return selected label
  const ChipGroup({
    required this.labels,
    required this.onSelectionChanged,
    Key? key,
  }) : super(key: key);

  @override
  _ChipGroupState createState() => _ChipGroupState();
}

class _ChipGroupState extends State<ChipGroup> {
  int selectedChipIndex = 0; // Initialize to 0 as default selection

  void handleChipSelection(int index) {
    setState(() {
      selectedChipIndex = index;
    });
    widget.onSelectionChanged(widget.labels[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(widget.labels.length, (index) {
        return Row(
          children: [
            ChipButton(
              label: widget.labels[index],
              isSelected: selectedChipIndex == index,
              onPressed: () {
                handleChipSelection(index);
              },
            ),
            if (index != widget.labels.length - 1) SizedBox(width: 10.w),
          ],
        );
      }),
    );
  }
}
