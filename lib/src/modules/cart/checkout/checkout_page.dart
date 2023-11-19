import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/enums/paymentType.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/order.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/modules/cart/checkout/checkout_controller.dart';
import 'package:mawad/src/modules/cart/checkout/widgets/loading.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController _cartController = Get.find<CartController>();

  final CheckoutController _checkoutcontroller = Get.find<CheckoutController>();
  final RegisterWithPhoneController _authController =
      Get.find<RegisterWithPhoneController>();
  final AddressController _addressController = Get.find<AddressController>();
  double _downPayment = 0;
  double total = 0;
  @override
  void initState() {
    super.initState();
    _downPayment = _checkoutcontroller.downPayment;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _checkoutcontroller.paymentPercentageItems.isEmpty
          ? const Scaffold(body: CheckoutPageSkeleton())
          : MainScaffold(
              backgroundColor: AppColorTheme.bgColor,
              haveTitle: true,
              showBackButton: true,
              title: 'Payments',
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 31.h,
                      ),
                      _buildPaymentListView(),
                      SizedBox(
                        height: 20.h,
                      ),
                      // PrimerCard(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       CheckboxIcon(
                      //         disabledTextStyle: AppTextTheme.lightGray17,
                      //         title: "Request service",
                      //         textStyle: AppTextTheme.darkblueTitle16,
                      //         onClicked: (c) {},
                      //         isClicked: false,
                      //         checkedIconPath: IconRoutes.checkedBox,
                      //         iconPath: IconRoutes.checkbox,
                      //       ),
                      //       Directionality(
                      //         textDirection: TextDirection.ltr,
                      //         child: Text(
                      //           "40 KWD",
                      //           style: AppTextTheme.gray16,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      buildSeparatorWithText('Payment Method'),
                      Container(
                        height: 56.h,
                        margin: EdgeInsets.only(top: 20.h),
                        child: Obx(() {
                          var availablePaymentTypes = _checkoutcontroller
                              .paymentType
                              .where((type) => type.isAvailable)
                              .toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: availablePaymentTypes.length,
                            itemBuilder: (context, index) {
                              var paymentType = availablePaymentTypes[index];
                              bool isSelected = _checkoutcontroller
                                      .selectedPaymentTypeId.value ==
                                  paymentType.name;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _checkoutcontroller.setSelectedPaymentType(
                                        paymentType.name);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  padding: const EdgeInsets.all(3),
                                  decoration: isSelected
                                      ? BoxDecoration(
                                          // color: AppColorTheme.yellow,
                                          border: Border.all(
                                              color: AppColorTheme.yellow,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        )
                                      : const BoxDecoration(),
                                  height: 50.h,
                                  child: SvgPicture.asset(
                                    paymentType.icon,
                                    fit: BoxFit.contain,
                                    height: 56.h,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                  Obx(() {
                    return BigTextButton(
                      text:
                          "Click to pay ${_downPayment == 0 ? '' : '$_downPayment KWD'} ",
                      fontWight: FontWeight.bold,
                      cornerRadius: 24,
                      isLoading: _checkoutcontroller.isLoading.value,
                      elevation: 0,
                      backgroudColor: Theme.of(context).colorScheme.secondary,
                      borderColor: Theme.of(context).cardColor,
                      textColor: Theme.of(context).colorScheme.onBackground,
                      padding: const EdgeInsets.all(15),
                      horizontalMargin: const EdgeInsets.all(30),
                      onClick: () {
                        final firstLocationDetail =
                            _addressController.locationDetails.isNotEmpty
                                ? _addressController.locationDetails.first
                                : null;
                        _checkoutcontroller.makeOrder(OrderModel(
                          products: _cartController.cartItems,
                          orderTimeType: "AS_SOON_AS_POSSIBLE",
                          status: "DELIVERY",
                          payType: paymentTypeToString(
                              _checkoutcontroller.selectedPaymentTypeId.value),
                          services: [],
                          userData: UserData(
                              user: _authController.userDetail.value!,
                              address: firstLocationDetail!),
                          userId: _authController.userDetail.value!.userId
                              .toString(),
                          deliveryArea: firstLocationDetail.area!.areaId,
                        ));
                      },
                    );
                  })
                ],
              ));
    });
  }

  Widget _buildPaymentListView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _checkoutcontroller.paymentPercentageItems.length,
      itemBuilder: (context, index) {
        var paymentItem = _checkoutcontroller.paymentPercentageItems[index];
        List<CartItem> products = _cartController.cartItems;
        double total = 0;
        products.map((product) {
          total += product.product.price * product.quantity;
        }).toList();
        _checkoutcontroller.downPayment =
            (total * paymentItem.items[0].percentage / 100).roundToDouble();
        _downPayment = _checkoutcontroller.downPayment;
        return Column(
          children: paymentItem.items.map((item) {
            return Column(
              children: [
                _buildTitle(
                    '% ${item.percentage} : ${_getTitleForIndex(item.index)}'),
                SizedBox(
                  height: 10.h,
                ),
                _buildPrimerCard(total, item.percentage, item.index),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  String _getTitleForIndex(int index) {
    switch (index) {
      case 1:
        return 'Down Payment';
      case 2:
        return 'Second Payment';
      default:
        return 'Payment $index';
    }
  }

  Widget _buildPrimerCard(double price, int percentage, int index) {
    price = ((price * percentage) / 100).round().toDouble();

    return PrimerCard(
      hasBorder: index == 1,
      radius: 14,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$price KWD',
                style:
                    index == 1 ? AppTextTheme.brown20bold : AppTextTheme.gray16,
              ),
              Text(
                _getTitleForIndex(index),
                style: AppTextTheme.gray18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // width: 130px;
  Widget _buildTitle(String title) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(right: 15.w),
        child: Align(
            alignment: Alignment.topRight,
            child: Text(
              title,
              style: AppTextTheme.darkblueTitle16,
            )),
      ),
    );
  }

  Widget buildSeparatorWithText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Divider(
              color: AppColorTheme.gray,
              thickness: 0.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(text, style: AppTextTheme.graysubtitle15),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Divider(
              color: AppColorTheme.gray,
              thickness: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
