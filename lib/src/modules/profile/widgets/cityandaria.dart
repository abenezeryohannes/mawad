import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';

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
                    "City",
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
                    hintText: 'Select City',
                  ),
                  value: controller.selectedCityId.isNotEmpty
                      ? controller.selectedCityId.value
                      : null,
                  items: controller.cities.map((city) {
                    return DropdownMenuItem<String>(
                      value: city.cityId,
                      child: Text(city.nameEng),
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
                          "Area",
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
                          hintText: 'Select Area',
                        ),
                        value: controller.selectedAreaId.isNotEmpty
                            ? controller.selectedAreaId.value
                            : null,
                        items: controller.areas.map((area) {
                          return DropdownMenuItem<String>(
                            value: area.areaId,
                            child: Text(area.nameEng),
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
      ],
    );
  }
}

// Interface for classes with id property