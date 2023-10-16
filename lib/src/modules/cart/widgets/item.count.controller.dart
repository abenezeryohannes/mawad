import 'package:flutter/material.dart';

class ItemCountController extends StatefulWidget {
  const ItemCountController(
      {super.key,
      this.value = 0,
      required this.onChange,
      this.canAdd = true,
      this.canSubtract = true,
      this.backgroundColor,
      this.radius = 60,
      this.iconSize = 20,
      this.iconColor,
      this.fontSize = 16});
  final int value;
  final Function(int val) onChange;
  final bool canAdd;
  final bool canSubtract;
  final double radius;
  final double iconSize;
  final double fontSize;
  final Color? backgroundColor;
  final Color? iconColor;
  @override
  State<ItemCountController> createState() => _ItemCountControllerState();
}

class _ItemCountControllerState extends State<ItemCountController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          color: widget.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(
              onClick: () {
                widget.onChange(widget.value - 1);
              },
              color: widget.iconColor,
              icon: Icon(
                Icons.remove,
                size: widget.iconSize,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              widget.value.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: widget.fontSize),
            ),
          ),
          _button(
              onClick: () {
                widget.onChange(widget.value + 1);
              },
              color: widget.iconColor,
              icon: Icon(
                Icons.add,
                size: widget.iconSize,
              ))
        ],
      ),
    );
  }

  Widget _button(
      {required Function onClick, required Widget icon, Color? color}) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: color ?? Colors.grey.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: icon,
        ));
  }
}
