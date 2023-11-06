import 'package:flutter/material.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/modules/cart/widgets/item.count.controller.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard(
      {super.key,
      this.backgroundColor = Colors.white,
      this.radius = 16,
      required this.item,
      required this.onValueChange,
      this.countable = true});
  final bool countable;
  final Color? backgroundColor;
  final double? radius;
  final CartItem item;
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
                  child: Image.network(
                    widget.item.product.images.first.url,
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
                        widget.item.product.nameEng,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 0),
                      child: Text(
                          widget.item.product.detailsEng.isNotEmpty
                              ? widget.item.product.detailsEng.substring(0, 50)
                              : "",
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
                              widget.countable
                                  ? "Price:${widget.item.product.price * widget.item.quantity}"
                                  : 'Special request',
                              style: widget.countable
                                  ? AppTextTheme.darkGray14bold
                                  : AppTextTheme.yellow14,
                            ),
                          ),
                        ),
                        if (widget.countable)
                          Padding(
                              padding: const EdgeInsets.only(),
                              child: ItemCountController(
                                  initialValue: widget.item.quantity,
                                  maxCount: widget.item.product.stock,
                                  minCount: 0,
                                  iconSize: 14,
                                  onChange: (val) {
                                    setState(() {});
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
                              'Waiting for approval',
                              style: AppTextTheme.brown12,
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
