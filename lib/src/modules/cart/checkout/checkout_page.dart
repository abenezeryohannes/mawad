import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/cart/carts/cart.total.card.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/modules/cart/checkout/checkout_controller.dart';
import 'package:mawad/src/modules/cart/checkout/widgets/InfroItem.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/utils.dart';

class CheckoutPage extends GetView<CheckoutController> {
  final CartController _cartController = Get.find<CartController>();

  CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      backgroundColor: AppColorTheme.bgColor,
      haveTitle: true,
      showBackButton: true,
      title: 'Payments',
      body: Obx(() {
        return controller.paymentPercentageItems.isNotEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: 31.h,
                  ),
                  _buildTitle(
                      '% ${controller.paymentPercentageItems[0].items[0].percentage}  :Down payment'),
                  PrimerCard(
                    hasBorder: true,
                    radius: 14,
                    child: Container(
                      child: const Row(
                        children: [
                          Text("data"),
                          Text("data"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CartTotalCard(
                      controller: _cartController,
                      title:
                          '% ${controller.paymentPercentageItems[0].items[1].percentage}  :Second payment',
                      textStyle: AppTextTheme.darkblueTitle16,
                    ),
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: _buildTitle(
                        '%${controller.paymentPercentageItems[0].items[2].percentage}  :Third payment'),
                  ),
                  PrimerCard(
                    radius: 14,
                    child: Container(
                      child: InfoItem(
                        title: 'third installment',
                        value: (Util.formatNumberAsPercentage(
                                _cartController.total.value,
                                controller.paymentPercentageItems[0].items[2]
                                    .percentage))
                            .toString(),
                        separator: false,
                      ),
                    ),
                  ),
                  // todo add the line separetor

                  //todo add the selected
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: SizedBox(
                                height: 56.h,
                                child: SvgPicture.asset(
                                  controller.paymentType[index].icon,
                                  fit: BoxFit.contain,
                                  height: 56.h,
                                ),
                              ));
                        },
                        itemCount: controller.paymentType.length,
                      ),
                    ),
                  )
                ],
              )
            : const SizedBox.shrink();
      }),
    );
  }
  // width: 130px;
// height: 56px;

  Widget _buildTitle(String title) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      child: Align(
          alignment: Alignment.topRight,
          child: Text(
            title,
            style: AppTextTheme.darkblueTitle16,
          )),
    );
  }
}
