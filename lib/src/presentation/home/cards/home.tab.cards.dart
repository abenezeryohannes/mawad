import 'package:flutter/material.dart';

class HomeTabCards extends StatefulWidget {
  const HomeTabCards({super.key, this.item});
  final Object? item;
  @override
  State<HomeTabCards> createState() => _HomeTabCardsState();
}

class _HomeTabCardsState extends State<HomeTabCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(14))),
            child: Image.asset(
              'assets/icon/box.png',
              width: 24,
              height: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 5),
            child: Text(
              'TabOption',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
