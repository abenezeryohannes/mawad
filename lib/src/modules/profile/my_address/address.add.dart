import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/citie.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/dropdown_input.dart';

import '../widgets/profile.text.input.dart';

class AddAddress extends GetView<AddressController> {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                _appBar(),
                ProfileTextInput(
                    controller: controller.avenueController,
                    label: 'Avenue',
                    placeholder: 'avenue',
                    onChange: (text) {
                      controller.avenueController.text = text;
                    }),
                ProfileTextInput(
                    label: 'Block',
                    placeholder: 'block',
                    controller: controller.blockController,
                    onChange: (text) {
                      controller.blockController.text = text;
                    }),
                ProfileTextInput(
                    label: 'House',
                    placeholder: 'house',
                    controller: controller.houseController,
                    onChange: (text) {
                      controller.houseController.text = text;
                    }),
                ProfileTextInput(
                    label: 'Street',
                    placeholder: 'street',
                    controller: controller.streetController,
                    onChange: (text) {
                      controller.streetController.text = text;
                    }),
                Obx(() {
                  if (controller.cities.isNotEmpty) {
                    var initialCityId = controller.selectedCityId.value ??
                        controller.cities.first.cityId;

                    return DropdownInput<City>(
                      label: 'Choose a City',
                      placeholder: 'Select a city',
                      items: controller.cities,
                      initialValue: initialCityId,
                      isEnabled: true,
                      onChange: (City? city) {
                        if (city != null) {
                          controller.onCitySelected(city.cityId);
                        }
                      },
                      getDisplayName: (City city) => city.nameEng,
                      getValue: (City city) => city.cityId,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
                Obx(() {
                  if (controller.selectedAreaId.isNotEmpty) {
                    var initialAreaId = controller.selectedAreaId.value ??
                        controller.areas.first.areaId;

                    return DropdownInput<Area>(
                      key: ValueKey(controller.areas.length),
                      label: 'Area',
                      placeholder: 'Select an area',
                      items: controller.areas,
                      initialValue: initialAreaId,
                      isEnabled: true,
                      onChange: (Area? area) {
                        if (area != null) {
                          controller.onAreaSelected(area.areaId);
                        }
                      },
                      getDisplayName: (Area area) => area.nameEng,
                      getValue: (Area area) => area.areaId,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(
                  height: 20,
                ),
                BigTextButton(
                    text: 'This is the button',
                    fontWight: FontWeight.bold,
                    cornerRadius: 24,
                    elevation: 0,
                    enabled: controller.formKey.currentState!.validate(),
                    backgroudColor: Theme.of(context).colorScheme.secondary,
                    borderColor: Theme.of(context).cardColor,
                    textColor: Theme.of(context).colorScheme.onBackground,
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    horizontalMargin:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    onClick: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addLocationDetail(LocationDetail(
                            avenue: controller.avenueController.text,
                            block: controller.blockController.text,
                            house: controller.houseController.text,
                            street: controller.streetController.text,
                            cityId: controller.selectedCityId.value,
                            areaId: controller.selectedAreaId.value));
                      }
                    })
              ],
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
                'This is title',
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
