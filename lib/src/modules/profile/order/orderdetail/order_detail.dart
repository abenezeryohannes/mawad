import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/cart/checkout/checkout_controller.dart';
import 'package:mawad/src/modules/profile/order/orderdetail/order_detail_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final OrderDetailController controller = Get.put(OrderDetailController());
  final RegisterWithPhoneController registerController =
      Get.put(RegisterWithPhoneController());
  final CheckoutController _checkoutcontroller = Get.put(CheckoutController());

  var order = Get.arguments;
  var availablePaymentTypes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    availablePaymentTypes = _checkoutcontroller.paymentType
        .where((type) => type.isAvailable)
        .toList();
    controller.getOrderItem(order["id"]);
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        backgroundColor: AppColorTheme.bg,
        haveTitle: true,
        title: 'Order Detail',
        showBackButton: true,
        body: Expanded(
          child: SingleChildScrollView(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColorTheme.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        buildDetail("Invoice",
                            " KD ${controller.orderDetail.totalPrice}"),
                        buildDetail("Order Date", " ${order["date"]}"),
                        buildDetail(
                            registerController.userDetail.value!.name
                                .toString(),
                            registerController.userDetail.value!.userEmail
                                .toString(),
                            isBold: true),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildTitle("Order Details"),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColorTheme.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: controller.orderDetail.product.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final product =
                                controller.orderDetail.product[index];
                            //total price

                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  buildDetailWithPrice(product.nameEng,
                                      product.price.toString()),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        buildDetailWithPrice(
                          "Total",
                          controller.orderDetail.totalPrice.toString(),
                          hasDiv: false,
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  buildSeparatorWithText('Payment'),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildPaymentListView(),
                  SizedBox(
                    height: 10.h,
                  ),
                  buildSeparatorWithText('Payment Method'),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 56,
                    child: _buildPaymentMethod(),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              );
            }),
          ),
        ));
  }

  Widget buttonPyment({Color? color, required String text}) {
    return Container(
      child: Chip(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: color ?? AppColorTheme.gray),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          label: Text(text,
              style: AppTextTheme.graysubtitle15.copyWith(
                  color: color ?? AppColorTheme.gray,
                  fontWeight: FontWeight.bold))),
    );
  }

  Widget buildDetailWithPrice(String title, String price,
      {bool hasDiv = true, bool isBold = false}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.only(left: 20, right: 17.w),
        color: AppColorTheme.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text("KWD $price", style: AppTextTheme.brown20)),
                Expanded(
                    child: Text(title,
                        style: isBold
                            ? AppTextTheme.darkGray14bold
                            : AppTextTheme.graysubtitle15)),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            hasDiv
                ? Divider(
                    thickness: 1.h,
                    color: AppColorTheme.darkWhite,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget buildDetail(String title, String value, {bool isBold = false}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.only(left: 20, right: 17.w),
        color: AppColorTheme.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: isBold
                        ? AppTextTheme.brown20
                        : AppTextTheme.graysubtitle12),
                Text(
                  value,
                  style: isBold
                      ? AppTextTheme.graysubtitle12
                      : AppTextTheme.brown20,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              thickness: 1.h,
              color: AppColorTheme.darkWhite,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentListView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.orderDetail.priceDetail.length,
      itemBuilder: (context, index) {
        var paymentItem = controller.orderDetail.priceDetail[index];

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  child: buttonPyment(
                    color: _getbtnColor(paymentItem.index),
                    text: _getTitleForIndexBtn(paymentItem.index),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                _buildTitle(
                    '% ${(paymentItem.percentage.round()).toString()} : ${_getTitleForIndex(paymentItem.index)}'),
                // _buildPaymentListView(),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            _buildPrimerCard(paymentItem.price,
                paymentItem.percentage.toString(), paymentItem.index),
            SizedBox(
              height: 10.h,
            ),
          ],
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

  String _getTitleForIndexBtn(int index) {
    switch (index) {
      case 1:
        return 'Paid';
      case 2:
        return 'Pay Later';
      default:
        return 'Pay Later';
    }
  }

  Color _getbtnColor(int index) {
    switch (index) {
      case 1:
        return AppColorTheme.red;
      case 2:
        return AppColorTheme.green;
      default:
        return AppColorTheme.gray;
    }
  }

  Widget _buildPrimerCard(double price, String percentage, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'KWD $price ',
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

  Widget _buildPaymentMethod() {
    availablePaymentTypes = _checkoutcontroller.paymentType
        .where((type) => type.isAvailable)
        .toList();
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: availablePaymentTypes.length,
      itemBuilder: (context, index) {
        var paymentType = availablePaymentTypes[index];

        return Container(
          margin: EdgeInsets.only(right: 10.w),
          padding: const EdgeInsets.all(3),
          height: 50.h,
          child: SvgPicture.asset(
            paymentType.icon,
            fit: BoxFit.contain,
            height: 56.h,
          ),
        );
      },
    );
  }
}
