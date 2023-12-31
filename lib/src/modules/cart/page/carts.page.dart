import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/cart/carts/cart.item.card.dart';
import 'package:mawad/src/modules/cart/carts/cart.total.card.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/modules/profile/account_detail/profile.manager.page.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/checkbox_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';

import '../../../presentation/sharedwidgets/big.text.button.dart';

class CartsPage extends StatefulWidget {
  const CartsPage({super.key});

  @override
  State<CartsPage> createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  final CartController _cartController = Get.put(CartController());

  final RegisterWithPhoneController _authController =
      Get.find<RegisterWithPhoneController>();

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
                                backgroundColor: Colors.white,
                                title: 'Remove Item'.tr,
                                content:
                                    Text('Do you want to remove this item'.tr),
                                textConfirm: 'Yes'.tr,
                                textCancel: 'No'.tr,
                                buttonColor: AppColorTheme.yellow,
                                confirmTextColor: AppColorTheme.brown,
                                cancelTextColor: AppColorTheme.brown,
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
                          countable: !item.product.allowInstructions!),
                    );
                  },
                );
              }),
              // todo add other services
              const SizedBox(
                height: 10,
              ),

              Obx(
                () => _cartController.otherServices.isNotEmpty &&
                        _cartController.cartItems.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Other services'.tr,
                            style: AppTextTheme.gray16,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              Obx(
                () => _cartController.otherServices.isNotEmpty &&
                        _cartController.cartItems.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _cartController.otherServices.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final otherServices =
                              _cartController.otherServices[index];
                          return PrimerCard(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _cartController.toggleOtherService(
                                          otherServices.id,
                                          !_cartController.listOfOtherServices
                                              .contains(otherServices.id
                                                  .toString())); // Convert to String
                                    });
                                  },
                                  child: CheckboxIcon(
                                    disabledTextStyle: AppTextTheme.lightGray17,
                                    title: otherServices.title,
                                    textStyle: AppTextTheme.darkblueTitle16,
                                    onClicked: (value) {
                                      setState(() {
                                        _cartController.toggleOtherService(
                                            otherServices.id, value);
                                      });
                                    },
                                    isClicked: _cartController
                                        .listOfOtherServices
                                        .contains(otherServices.id
                                            .toString()), // Convert to String
                                    checkedIconPath: IconRoutes.checkedBox,
                                    iconPath: IconRoutes.checkbox,
                                  ),
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    otherServices.price.toString(),
                                    style: AppTextTheme.gray16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ),

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
                        child: Center(
                          child: Text('No items in cart'.tr),
                        ),
                      ),
              ),
              Obx(
                () => _cartController.cartItems.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Payment fees will be divided into 3 payments'.tr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Obx(
                () => _cartController.cartItems.isNotEmpty
                    ? BigTextButton(
                        text: 'Checkout'.tr.toUpperCase(),
                        fontWight: FontWeight.bold,
                        cornerRadius: 24,
                        fontSize: 18,
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

                          if (_authController.userDetail.value!.name == null ||
                              _authController.userDetail.value!.name == '' ||
                              _authController.userDetail.value!.userEmail ==
                                  null ||
                              _authController.userDetail.value!.userEmail ==
                                  '') {
                            Get.to(() => const ProfileManagerPage());
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
                'Cart'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            //todod check the pink color again
            IconButton(
              onPressed: () {
                if (_cartController.cartItems.length > 1) {
                  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    title: 'Clear cart'.tr,
                    content:
                        Text('Are you sure you want to clear the cart?'.tr),
                    textConfirm: 'Yes'.tr,
                    textCancel: 'No'.tr,
                    buttonColor: AppColorTheme.yellow,
                    confirmTextColor: AppColorTheme.brown,
                    cancelTextColor: AppColorTheme.brown,
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
