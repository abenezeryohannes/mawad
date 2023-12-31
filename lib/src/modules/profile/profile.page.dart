import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/profile/widgets/profile.item.card.dart';
import 'package:mawad/src/modules/profile/account_detail/profile.manager.page.dart';
import 'package:mawad/src/modules/profile/widgets/profile.avatar.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends GetView<RegisterWithPhoneController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getUserDetail();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.onPrimary,
          child: Column(
            children: [
              Obx(() {
                return Expanded(
                  child: controller.userDetail.value != null
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.userDetail.value?.avatar == null &&
                                    controller.isProfileLoading.value
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: const CircleAvatar(
                                        radius: 50.0,
                                      ),
                                    ))
                                : ProfileAvatar(
                                    imageUrl:
                                        "http://ordermawad.com/api/v1/file/get/${controller.userDetail.value?.avatar}",
                                    radius: 50,
                                    onImagePicked: (p0) {
                                      controller.addAvatar(p0);
                                    },
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                controller.userDetail.value!.name.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  controller.userDetail.value!.phone.toString(),
                                  style: AppTextTheme.darkGray14bold,
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(),
                );
              }),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.only(
                    bottom: 40.0, left: 10, right: 10, top: 20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [..._bottomList(context)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _bottomList(context) {
    return [
      ProfileItemCard(
        title: 'Account Details'.tr,
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Image.asset(
            'assets/icon/profile.png',
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        onClick: () => Get.to(() => const ProfileManagerPage()),
      ),
      ProfileItemCard(
        title: 'My Addresses'.tr,
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Image.asset(
            'assets/icon/home_location.png',
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        onClick: () => Get.toNamed(AppRoutes.address),
      ),
      ProfileItemCard(
        title: 'My Orders'.tr,
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Image.asset(
            'assets/icon/box.png',
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        onClick: () => Get.toNamed(AppRoutes.orderPage),
      ),
      ProfileItemCard(
        title: 'Privacy Terms'.tr,
        onClick: () => _launchUrl(),
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Image.asset(
            'assets/icon/lock.png',
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      )
    ];
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('http://ordermawad.com/privacy-policy');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
