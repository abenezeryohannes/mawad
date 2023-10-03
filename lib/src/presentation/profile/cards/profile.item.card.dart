import 'package:flutter/material.dart';

class ProfileItemCard extends StatefulWidget {
  const ProfileItemCard(
      {super.key,
      this.title,
      this.icon,
      this.collapsable = true,
      this.onClick,
      this.backgroundColor});
  final String? title;
  final Widget? icon;
  final Color? backgroundColor;
  final bool collapsable;
  final Function? onClick;
  @override
  State<ProfileItemCard> createState() => _ProfileItemCardState();
}

class _ProfileItemCardState extends State<ProfileItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: InkWell(
        onTap: () {
          if (widget.onClick != null) widget.onClick!();
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(14))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.icon ?? const SizedBox(),
                  Text(
                    widget.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
              Icon(
                Icons.chevron_right,
                size: 24,
                color: Theme.of(context).disabledColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
