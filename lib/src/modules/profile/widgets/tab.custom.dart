import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabCustom extends StatefulWidget {
  const TabCustom({
    super.key,
    this.selectedIndex = 0,
    required this.items,
    required this.onItemSelected,
    this.radius = 0.0,
    this.backgroundColor,
  });
  final int selectedIndex;
  final List<String> items;
  final double radius;
  final Color? backgroundColor;
  final Function(int tabIndex) onItemSelected;
  @override
  State<TabCustom> createState() => _TabCustomState();
}

class _TabCustomState extends State<TabCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          color: widget.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...widget.items.map((it) => Expanded(
                  child: Padding(
                padding: EdgeInsets.only(
                  left: widget.items.indexOf(it) == widget.items.length &&
                          Get.locale?.languageCode == 'ar'
                      ? 0
                      : Get.locale?.languageCode == 'ar'
                          ? 10
                          : 0,
                  right: widget.items.indexOf(it) == widget.items.length &&
                          Get.locale?.languageCode != 'ar'
                      ? 10
                      : Get.locale?.languageCode != 'ar'
                          ? 10
                          : 0,
                ),
                child: InkWell(
                  onTap: () => widget.onItemSelected(widget.items.indexOf(it)),
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 14, bottom: 14, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: widget.selectedIndex == widget.items.indexOf(it)
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text(it,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight:
                                widget.selectedIndex == widget.items.indexOf(it)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color: widget.selectedIndex ==
                                    widget.items.indexOf(it)
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.onBackground)),
                  ),
                ),
              )))
        ],
      ),
    );
  }
}
