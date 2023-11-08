import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String value;
  final bool valueBig;
  final bool separator;

  const InfoItem({
    super.key,
    required this.title,
    required this.value,
    this.valueBig = false,
    this.separator = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: valueBig ? 20 : 14,
                    color: (!valueBig)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ],
        ),
        if (separator)
          Container(
            height: 0.1,
            margin:
                const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            color: Theme.of(context).dividerColor,
            width: MediaQuery.of(context).size.width,
          )
      ],
    );
  }
}
