import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

import '../widgets/profile.item.card.dart';
import 'address.add.dart';

class AddressPage extends GetView<AddressController> {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return controller.locationDetails.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: controller.locationDetails.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final location = controller.locationDetails[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20.0),
                              child: ProfileItemCard(
                                title: location.city?.nameEng,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                icon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Image.asset(
                                    'assets/icon/home_location.png',
                                    width: 20,
                                    height: 20,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : const CircularProgressIndicator();
            })
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20, right: 20, top: 10.0, bottom: 10),
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
                )),
            Expanded(
              child: Text(
                'This is title',
                textAlign: TextAlign.center,
                style: AppTextTheme.dark18,
              ),
            ),
            IconButton.filled(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColorTheme.yellow),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
              onPressed: () => Get.to(() => const AddAddress()),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
