import 'package:flutter/material.dart';
import 'package:mawad/src/presentation/sharedwidgets/custom.shimmer.dart';

class BottomSheetButton extends StatefulWidget {
  const BottomSheetButton(
      {super.key,
      this.title,
      this.icon,
      this.color,
      this.cheviron = true,
      this.onClick,
      this.padding,
      this.icaonBackgroundColor});
  final String? title;
  final String? icon;
  final bool cheviron;
  final Function? onClick;
  final Color? icaonBackgroundColor;
  final Color? color;
  final EdgeInsets? padding;
  @override
  State<BottomSheetButton> createState() => _BottomSheetButtonState();
}

class _BottomSheetButtonState extends State<BottomSheetButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ??
          EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * (2 / 12),
              vertical: 14),
      child: InkWell(
        onTap: () {
          if (widget.onClick != null) {
            widget.onClick!();
          }
        },
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.icon != null)
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: widget.icaonBackgroundColor ??
                          Theme.of(context).cardColor,
                      child: Image.asset(
                        widget.icon ?? 'asseta/icon/logo.png',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: CustomShimmer(
                      show: widget.title == null,
                      child: Text(widget.title ?? '.........................',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  backgroundColor: (widget.title == null)
                                      ? Theme.of(context).disabledColor
                                      : Colors.transparent,
                                  color: widget.color ??
                                      Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                  fontWeight: widget.cheviron
                                      ? FontWeight.bold
                                      : FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.cheviron || widget.title == null)
              CustomShimmer(
                show: widget.title == null,
                child: Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: Theme.of(context).disabledColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
