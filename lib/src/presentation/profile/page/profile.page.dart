import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/profile/cards/profile.item.card.dart';
import 'package:mawad/src/presentation/profile/page/address.page.dart';
import 'package:mawad/src/presentation/profile/page/order.page.dart';
import 'package:mawad/src/presentation/profile/page/profile.manager.page.dart';
import 'package:mawad/src/presentation/profile/widgets/profile.avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        child: Column(children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileAvatar(
                  isLoading: (bool x) {},
                  editable: false,
                  deletable: false,
                  onSave: () {},
                  placeholder: Image.asset(
                    'assets/icon/user_placeholder.png',
                    height: 100,
                    width: 100,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.onBackground,
                  radius: 100,
                  boxShadow: [],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  upload: (String) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'This is user Name',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'This is user Name',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.only(
                bottom: 24.0, left: 10, right: 10, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [..._bottomList()],
            ),
          )
        ]),
      ),
    );
  }

  List<Widget> _bottomList() {
    return [
      ProfileItemCard(
        title: 'Sample text',
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
        title: 'Sample text',
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Image.asset(
            'assets/icon/home_location.png',
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        onClick: () => Get.to(() => const AddressPage()),
      ),
      ProfileItemCard(
        title: 'Sample text',
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
        title: 'Sample text',
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
