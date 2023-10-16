import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class MainScaffold extends StatelessWidget {
  final String? title;
  final bool showBackButton;
  final Widget body;
  final bool haveTitle;
  final Color? backgroundColor;

  const MainScaffold({
    Key? key,
    this.title,
    this.showBackButton = false,
    this.haveTitle = false,
    this.backgroundColor,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColorTheme.bgColor,
      body: SafeArea(
          child: Column(
        children: [
          _appBar(context),
          Expanded(
            child: body,
          ),
        ],
      )),
    );
  }

  _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5.0, bottom: 5),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showBackButton
                ? InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.chevron_left,
                      size: 32,
                    ))
                : const SizedBox.shrink(),
            Expanded(
              child: haveTitle
                  ? Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
