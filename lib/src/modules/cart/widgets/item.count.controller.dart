import 'package:flutter/material.dart';

class ItemCountController extends StatefulWidget {
  final int initialValue;
  final Function(int val) onChange;
  final bool canAdd;
  final bool canSubtract;
  final double radius;
  final double iconSize;
  final double fontSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const ItemCountController({
    Key? key,
    this.initialValue = 0,
    required this.onChange,
    this.canAdd = true,
    this.canSubtract = true,
    this.backgroundColor,
    this.radius = 60,
    this.iconSize = 20,
    this.iconColor,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  State<ItemCountController> createState() => _ItemCountControllerState();
}

class _ItemCountControllerState extends State<ItemCountController> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        color:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(
            onClick: widget.canSubtract
                ? () {
                    setState(() {
                      if (_value <= 1) return;
                      _value -= 1;
                      widget.onChange(_value);
                    });
                  }
                : null,
            color: widget.iconColor,
            icon: Icon(
              Icons.remove,
              size: widget.iconSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '$_value',
              style: TextStyle(fontSize: widget.fontSize),
            ),
          ),
          _button(
            onClick: widget.canAdd
                ? () {
                    setState(() {
                      _value += 1;
                      widget.onChange(_value);
                    });
                  }
                : null,
            color: widget.iconColor,
            icon: Icon(
              Icons.add,
              size: widget.iconSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required Function? onClick,
    required Widget icon,
    Color? color,
  }) {
    return InkWell(
      onTap: onClick as void Function()?,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color ?? Colors.grey.shade300,
          borderRadius: BorderRadius.circular(100),
        ),
        child: icon,
      ),
    );
  }
}
