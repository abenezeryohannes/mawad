import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatefulWidget {
  const CustomShimmer(
      {Key? key,
      required this.child,
      required this.show,
      this.baseColor,
      this.highlightColor})
      : super(key: key);
  final bool show;
  final Widget child;

  final Color? baseColor;
  final Color? highlightColor;

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer> {
  @override
  Widget build(BuildContext context) {
    return (widget.show)
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: widget.child,
          )
        : widget.child;
  }
}
