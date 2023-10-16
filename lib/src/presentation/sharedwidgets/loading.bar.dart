import 'package:flutter/material.dart';

class LoadingBar extends StatefulWidget {
  const LoadingBar({
    Key? key,
    this.show = false,
    this.color,
    this.backColor,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);
  final Color? color;
  final Color? backColor;
  final EdgeInsets padding;
  final bool show;
  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.show) {
      return Padding(
        padding: widget.padding,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: LinearProgressIndicator(
            backgroundColor:
                widget.backColor ?? Theme.of(context).colorScheme.secondary,
            valueColor: AlwaysStoppedAnimation(
                widget.color ?? Theme.of(context).scaffoldBackgroundColor),
            minHeight: 5,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
