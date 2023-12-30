import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class CartTotalCard extends StatefulWidget {
  const CartTotalCard(
      {required this.controller,
      this.textStyle,
      super.key,
      this.backgroundColor,
      this.title});

  final Color? backgroundColor;
  final CartController controller;
  final String? title;
  final TextStyle? textStyle;

  @override
  State<CartTotalCard> createState() => _CartTotalCardState();
}

class _CartTotalCardState extends State<CartTotalCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 5, right: 5),
          child: Text(
            widget.title ?? 'Total'.tr,
            style: widget.textStyle ?? AppTextTheme.gray16,
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: widget.backgroundColor ?? Colors.white),
          child: Obx(() {
            return Column(
              children: [
                ..._items(
                    title: "SubTotal".tr,
                    value: '${widget.controller.subtotal}${'KWD'.tr}'),
                ..._items(
                    title: 'ShippingFees'.tr,
                    value: '${widget.controller.shippingFees} ${'KWD'.tr}'),
                ..._items(
                    title: 'Total'.tr,
                    value: '${widget.controller.total} ${'KWD'.tr}',
                    valueBig: true,
                    separator: false),
              ],
            );
          }),
        )
      ],
    );
  }

  List<Widget> _items(
      {required String title,
      required String value,
      bool valueBig = false,
      bool separator = true}) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Row(
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
            )
          ],
        ),
      ),
      if (separator)
        Container(
          height: 0.1,
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          color: Theme.of(context).dividerColor,
          width: MediaQuery.of(context).size.width,
        )
    ];
  }
}
