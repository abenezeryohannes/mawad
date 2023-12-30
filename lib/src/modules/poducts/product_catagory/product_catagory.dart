import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/catagorie.dart';
import 'package:mawad/src/modules/home/widgets%20/home.tab.cards.dart';
import 'package:mawad/src/modules/home/pages/change.country.bottom.sheet.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_categories_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/appbottomshet.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

import '../../../data/services/localization_service.dart';

class ProductCategory extends GetView<ProductController> {
  const ProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(
          "Categories",
          style: AppTextTheme.brown25,
        ),
        SizedBox(
          height: 20.h,
        ),
        buildCountryButton(() {
          showAppBottomSheet(
            Obx(() {
              return ChangeCountryBottomSheet(
                countries: controller.countries,
                initialSelectedCountry: controller.selectedCountry.value,
                onCountrySelected: (selected) {
                  controller.getProductByCountry(selected.id);
                  controller.getCategoryByCountry(selected.id);
                  controller.selectedCountry(selected);
                },
              );
            }),
          );
        }),
        SizedBox(
          height: 20.h,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            margin: EdgeInsets.only(right: 19.w),
            alignment: Alignment.topRight,
            child: Text(
              "sections",
              style: AppTextTheme.brown14,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        buildCategories(controller.categories),
      ],
    ));
  }

  Widget buildCategories(List<CategoryModel> catagories) {
    final catController = Get.find<ProductCategoryController>();
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(() {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // This specifies the number of columns
                childAspectRatio:
                    3 / 4, // Adjust as needed for your card's proportions
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: catagories.length,
              itemBuilder: (context, index) {
                final category = catagories[index];
                return Obx(() {
                  return SelectableCard(
                    backgroundColor: catController.isSelected
                        ? AppColorTheme.yellow
                        : AppColorTheme.white,
                    isSelected: catController.selectedIndex == index,
                    onTap: () {
                      catController.selectedIndex = index;
                      controller.getProductByCategory(category.id);
                      controller.isCategory(false);
                    },
                    label: LocalizationService.instance.currentLocaleLangCode ==
                            AppConstants.ENG
                        ? category.nameEng
                        : category.nameAr,
                    icon: index == 0
                        ? SvgPicture.asset(
                            category.image.url,
                            color: catController.isSelected
                                ? AppColorTheme.white
                                : AppColorTheme.gray,
                          )
                        : SvgPicture.network(
                            category.image.url,
                            color: catController.isSelected
                                ? AppColorTheme.white
                                : AppColorTheme.gray,
                          ),
                  );
                });
              },
            );
          }),
        ),
      ),
    );
  }

  Widget buildCountryButton(VoidCallback onClick) {
    return Column(
      children: [
        BigTextButton(
          textWidget: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selected country'.tr,
                  style: AppTextTheme.dark18,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Obx(() {
                  return CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 22.r,
                    child: ClipOval(
                      child: SvgPicture.network(
                        '${AppConstants.IMAGER_URL}/${controller.selectedCountry.value!.attachment.id}',
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          fontWight: FontWeight.bold,
          cornerRadius: 16.r,
          elevation: 0,
          backgroudColor: AppColorTheme.yellow,
          borderColor: AppColorTheme.yellow,
          textColor: AppColorTheme.brown,
          padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
          horizontalMargin:
              EdgeInsets.symmetric(horizontal: 25.w, vertical: 26.w),
          onClick: onClick,
        ),
      ],
    );
  }
}
