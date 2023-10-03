import 'package:flutter/material.dart';

class TextBadge extends StatefulWidget {
  const TextBadge({super.key, required this.text, this.color, this.colorTxt});

  final String text;
  final Color? color;
  final String? colorTxt;

  @override
  State<TextBadge> createState() => _TextBadgeState();
}

class _TextBadgeState extends State<TextBadge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: widget.color?.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Text(
        widget.text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold, color: widget.color, fontSize: 10),
      ),
    );
  }
}
