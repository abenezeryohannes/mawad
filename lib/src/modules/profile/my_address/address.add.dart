import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/citie.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';
import 'package:mawad/src/modules/profile/widgets/cityandaria.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';

import '../widgets/profile.text.input.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key});
  final AddressController controller = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    final arguemnt = Get.arguments;
    controller.getCity(controller.productController.selectedCountry.value!.id);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  _appBar(),
                  const CityAndArea(),
                  ProfileTextInput(
                      label: 'Street'.tr,
                      placeholder: 'Your street number/name'.tr,
                      controller: controller.streetController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter valid street'.tr;
                        }
                      },
                      onChange: (text) {
                        // controller.streetController.text = text;
                      }),
                  ProfileTextInput(
                      controller: controller.avenueController,
                      label: 'Avenue'.tr,
                      placeholder: 'your avenue'.tr,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter valid avenue'.tr;
                        }
                      },
                      onChange: (text) {
                        // controller.avenueController.text = text;
                      }),
                  ProfileTextInput(
                      label: 'House No.'.tr,
                      placeholder: 'your house number'.tr,
                      controller: controller.houseController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter valid house'.tr;
                        }
                      },
                      onChange: (text) {
                        // controller.houseController.text = text;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return BigTextButton(
                        text: 'Save'.tr,
                        fontWight: FontWeight.bold,
                        cornerRadius: 24,
                        elevation: 0,
                        fontSize: 18,
                        isLoading: controller.isLeading.value,
                        backgroudColor: Theme.of(context).colorScheme.secondary,
                        borderColor: Theme.of(context).cardColor,
                        textColor: Theme.of(context).colorScheme.onBackground,
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        horizontalMargin: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 10),
                        onClick: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.addLocationDetail(
                                LocationDetail(
                                    avenue: controller.avenueController.text,
                                    block: controller.blockController.text,
                                    house: controller.houseController.text,
                                    street: controller.streetController.text,
                                    cityId: controller.selectedCityId.value,
                                    areaId: controller.selectedAreaId.value),
                                arguemnt ?? "");
                          }
                        });
                  })
                ],
              ),
            ),
          ),
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
                'Add Address'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(Get.context!)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
