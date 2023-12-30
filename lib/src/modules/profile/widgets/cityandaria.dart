import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/data/services/localization_service.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';
import 'package:mawad/src/modules/profile/widgets/profile.text.input.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class CityAndArea extends GetView<AddressController> {
  const CityAndArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "City".tr,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'chose your city'.tr,
                    hintStyle: AppTextTheme.lightGray17,
                  ),
                  value: controller.selectedCityId.isNotEmpty
                      ? controller.selectedCityId.value
                      : null,
                  items: controller.cities.map((city) {
                    return DropdownMenuItem<String>(
                      value: city.cityId,
                      child: Text(
                        LocalizationService.instance.currentLocaleLangCode ==
                                AppConstants.ENG
                            ? city.nameEng
                            : city.nameAr,
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    controller.onCitySelected(newValue!);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Show the areas dropdown only if a city is selected
        Obx(
          () => controller.selectedCityId.isNotEmpty
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Area".tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Select Area'.tr,
                          hintStyle: AppTextTheme.lightGray17,
                        ),
                        value: controller.selectedAreaId.isNotEmpty
                            ? controller.selectedAreaId.value
                            : null,
                        items: controller.areas.map((area) {
                          return DropdownMenuItem<String>(
                            value: area.areaId,
                            child: Text(
                              LocalizationService
                                          .instance.currentLocaleLangCode ==
                                      AppConstants.ENG
                                  ? area.nameEng
                                  : area.nameAr,
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          controller.onAreaSelected(newValue!);
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),

        const SizedBox(height: 20),
        ProfileTextInput(
            label: 'Block No.'.tr,
            placeholder: 'your block number'.tr,
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Please enter valid block'.tr;
              }
            },
            controller: controller.blockController,
            onChange: (text) {
              // controller.blockController.text = text;
            }),
      ],
    );
  }
}

// Interface for classes with id property