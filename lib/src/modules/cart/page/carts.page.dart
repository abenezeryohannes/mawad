import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/cart/carts/cart.item.card.dart';
import 'package:mawad/src/modules/cart/carts/cart.total.card.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

import '../../../presentation/sharedwidgets/big.text.button.dart';

class CartsPage extends StatelessWidget {
  final CartController _cartController = Get.put(CartController());
  final RegisterWithPhoneController _authController =
      Get.find<RegisterWithPhoneController>();

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
                    CartItem item = _cartController.cartItems[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: CartItemCard(
                          radius: 14.r,
                          item: item,
                          onValueChange: (val) {
                            if (val == 0) {
                              Get.defaultDialog(
                                title: 'Remove Item',
                                content: const Text(
                                    'Do you want to remove this item'),
                                textConfirm: 'Yes',
                                textCancel: 'No',
                                onConfirm: () {
                                  _cartController.removeItem(item.product.id);
                                  Get.back();
                                },
                                onCancel: () {
                                  _cartController.updateItemQuantity(
                                      item.product.id, 1);
                                },
                              );

                              return;
                            }
                            _cartController.updateItemQuantity(
                                item.product.id, val);
                          },
                          countable: !item.product.allowInstructions),
                    );
                  },
                );
              }),
              Obx(
                () => _cartController.cartItems.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CartTotalCard(
                          controller: _cartController,
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 100.h),
                        child: const Center(
                          child: Text('No items in cart'),
                        ),
                      ),
              ),
              Obx(
                () => _cartController.cartItems.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Payment fees will be divided into 3 payments', // TODO: Calculate actual total
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Obx(
                () => _cartController.cartItems.isNotEmpty
                    ? BigTextButton(
                        text: 'Complete the payment',
                        fontWight: FontWeight.bold,
                        cornerRadius: 24,
                        elevation: 0,
                        backgroudColor: Theme.of(context).colorScheme.secondary,
                        borderColor: Theme.of(context).cardColor,
                        textColor: Theme.of(context).colorScheme.onBackground,
                        padding: const EdgeInsets.all(15),
                        horizontalMargin: const EdgeInsets.all(30),
                        onClick: () async {
                          if (!await _authController.isAuth()) {
                            Get.toNamed(AppRoutes.register);
                            return;
                          }

                          Get.toNamed(AppRoutes.checkout);
                        },
                      )
                    : const SizedBox.shrink(),
              )
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
                'Cart',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                if (_cartController.cartItems.length > 1) {
                  Get.defaultDialog(
                    title: 'Clear cart',
                    content: const Text('Are you sure you want to clear cart?'),
                    textConfirm: 'Yes',
                    textCancel: 'No',
                    onConfirm: () {
                      _cartController.clearCart();
                      Get.back();
                    },
                    onCancel: () {},
                  );
                  return;
                } else {
                  _cartController.clearCart();
                  return;
                }
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
