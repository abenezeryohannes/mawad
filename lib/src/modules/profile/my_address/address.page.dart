import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

import '../widgets/profile.item.card.dart';

class AddressPage extends GetView<AddressController> {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getLocationDetail();
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
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20.0),
                                child: ProfileItemCard(
                                  onClick: () {
                                    controller.setSelectedAddress(location);
                                    Get.toNamed(AppRoutes.editAddress);
                                  },
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : const Center(
                      child: Text('No Address'),
                    );
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
                'Address',
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
              onPressed: () {
                controller.reset();
                Get.toNamed(AppRoutes.addAddress);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
