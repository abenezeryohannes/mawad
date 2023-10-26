import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/modules/cart/carts/cart.item.card.dart';
import 'package:mawad/src/modules/cart/carts/cart.total.card.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';

import '../../../presentation/sharedwidgets/big.text.button.dart';

class CartsPage extends StatelessWidget {
  final CartController _cartController = Get.put(CartController());

  CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _appBar(context),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _cartController.cartItems.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    Product item = _cartController.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CartItemCard(
                          radius: 14.r,
                          item: item,
                          onValueChange: (val) {
                            _cartController.updateItemQuantity(item.id, val);
                          },
                          countable:
                              true // You might want to reconsider this logic based on cartItems
                          ),
                    );
                  },
                );
              }),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: CartTotalCard(
                    items: []), // TODO: Pass the appropriate items here
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Payment fees will be divided into 3 payments', // TODO: Calculate actual total
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              BigTextButton(
                text: 'This is the button',
                fontWight: FontWeight.bold,
                cornerRadius: 24,
                elevation: 0,
                backgroudColor: Theme.of(context).colorScheme.secondary,
                borderColor: Theme.of(context).cardColor,
                textColor: Theme.of(context).colorScheme.onBackground,
                padding: const EdgeInsets.all(15),
                horizontalMargin: const EdgeInsets.all(30),
                onClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.chevron_left,
                size: 32,
              ),
            ),
            Expanded(
              child: Text(
                'This is title',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                _cartController.clearCart();
              },
              icon: Image.asset(
                'assets/icon/remove.png',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
