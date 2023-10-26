import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CartItemCard(
                        item: _cartController.cartItems[index],
                        onValueChange: (val) {
                          _cartController.updateItemQuantity(
                              _cartController.cartItems[index].id, val);
                        },
                        countable: index !=
                            3, // You might want to reconsider this logic based on cartItems
                      ),
                    );
                  },
                );
              }),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: CartTotalCard(
                    items: []), // TODO: Pass the appropriate items here
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Total is total is total is total is total ', // TODO: Calculate actual total
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
              onPressed: () {}, // TODO: Implement the appropriate action
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
