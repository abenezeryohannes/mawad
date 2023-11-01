import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/home/cards/home.tab.cards.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class ProductCategoryList extends GetView<ProductController> {
  const ProductCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorTheme.bg,
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      height: 150.h,
      child: Obx(() {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            return Container(
              padding: EdgeInsets.all(10.r),
              child: Obx(() {
                return SelectableCard(
                  isSelected:
                      controller.productCategoryController.selectedIndex ==
                          index,
                  onTap: () {
                    controller.productCategoryController.selectedIndex = index;
                    controller.productCategoryController.update();
                    if (controller.productCategoryController.selectedIndex ==
                        0) {
                      Get.toNamed(AppRoutes.productCategory);
                      controller.getProductByCountry(
                          controller.selectedCountry.value!.id);
                    } else if (controller
                            .productCategoryController.selectedIndex ==
                        index) {
                      controller.getProductByCategory(category.id);
                    }
                  },
                  icon: Container(
                      child: index == 0
                          ? SvgPicture.asset(
                              category.image.url,
                              color: controller.productCategoryController
                                          .selectedIndex ==
                                      index
                                  ? AppColorTheme.white
                                  : AppColorTheme.gray,
                            )
                          : SvgPicture.network(
                              category.image.url,
                              color: controller.productCategoryController
                                          .selectedIndex ==
                                      index
                                  ? AppColorTheme.white
                                  : AppColorTheme.gray,
                            )),
                  label: category.nameEng,
                );
              }),
            );
          },
        );
      }),
    );
  }
}
