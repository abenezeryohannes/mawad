import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/profile/widgets/profile.item.card.dart';
import 'package:mawad/src/modules/profile/order/order.page.dart';
import 'package:mawad/src/modules/profile/account_detail/profile.manager.page.dart';
import 'package:mawad/src/modules/profile/widgets/profile.avatar.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

class ProfilePage extends GetView<RegisterWithPhoneController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.onPrimary,
          child: Column(children: [
            Obx(() {
              return Expanded(
                child: controller.userDetail.value != null
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileAvatar(
                            radius: 50,
                            onImagePicked: (p0) {},
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                  bottom: 24.0, left: 10, right: 10, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [..._bottomList(context)],
              ),
            )
          ]),
        ),
      ),
    );
  }

  List<Widget> _bottomList(context) {
    return [
      ProfileItemCard(
        title: 'Account Details',
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
        title: 'My Addresses',
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
        title: 'My Orders',
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Image.asset(
            'assets/icon/box.png',
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        onClick: () => Get.to(() => const OrderPage()),
      ),
      ProfileItemCard(
        title: 'Privacy Terms',
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
}
