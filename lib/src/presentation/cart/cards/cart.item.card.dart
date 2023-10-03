import 'package:flutter/material.dart';
import 'package:mawad/src/presentation/cart/widgets/item.count.controller.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard(
      {super.key,
      this.backgroundColor = Colors.white,
      this.radius = 16,
      this.item,
      required this.onValueChange,
      this.countable = true});
  final bool countable;
  final Color? backgroundColor;
  final double? radius;
  final Object? item;
  final Function(int val) onValueChange;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0),
                  child: Image.asset(
                    'assets/img/placeholder.jpeg',
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        'This is title',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 0),
                      child: Text('This is the sub title',
                          style: Theme.of(context).textTheme.bodyMedium!),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: Text(
                              widget.countable ? 'Price is 25E' : 'Placeholder',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: (widget.countable)
                                          ? Theme.of(context).hintColor
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary),
                            ),
                          ),
                        ),
                        if (widget.countable)
                          Padding(
                              padding: const EdgeInsets.only(),
                              child: ItemCountController(
                                  value: 3,
                                  iconSize: 14,
                                  onChange: (val) {
                                    widget.onValueChange(val);
                                  }))
                        else
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, left: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.5)),
                            child: Text(
                              'button',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
