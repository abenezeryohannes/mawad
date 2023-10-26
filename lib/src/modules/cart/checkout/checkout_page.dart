import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      backgroundColor: AppColorTheme.bgColor,
      haveTitle: true,
      showBackButton: true,
      title: 'Payments',
      body: Column(
        children: [
          _buildTitle('الدفعة الأولى:  40%'),
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
              ))
        ],
      ),
    );
  }

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
