import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutPageSkeleton extends StatelessWidget {
  const CheckoutPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      backgroundColor: AppColorTheme.bgColor,
      haveTitle: true,
      showBackButton: true,
      title: 'Payments',
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            SizedBox(height: 31.h),
            _buildPaymentListSkeleton(context),
            SizedBox(height: 20.h),
            _buildCardSkeleton(context),
            _buildSeparatorSkeleton(context),
            _buildPaymentMethodSkeleton(context),
            SizedBox(height: 4.h),
            _buildButtonSkeleton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentListSkeleton(BuildContext context) {
    // Mimic the layout of _buildPaymentListView
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3, // Number of items you expect
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 100.w,
                height: 20.h,
                color: Colors.white,
              ),
              SizedBox(width: 10.w),
              Container(
                width: MediaQuery.of(context).size.width - 120.w,
                height: 20.h,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCardSkeleton(BuildContext context) {
    // Mimic the layout of PrimerCard
    return Container(
      width: double.infinity,
      height: 60.h,
      color: Colors.white,
    );
  }

  Widget _buildSeparatorSkeleton(BuildContext context) {
    // Mimic the layout of buildSeparatorWithText
    return Container(
      width: double.infinity,
      height: 20.h,
      color: Colors.white,
    );
  }

  Widget _buildPaymentMethodSkeleton(BuildContext context) {
    // Mimic the layout of your payment method section
    return Container(
      width: double.infinity,
      height: 56.h,
      color: Colors.white,
    );
  }

  Widget _buildButtonSkeleton(BuildContext context) {
    // Mimic the layout of BigTextButton
    return Container(
      width: double.infinity,
      height: 48.h,
      color: Colors.white,
    );
  }
}
