import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/home/cards/home.tab.cards.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_categories_controller.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/search_input.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';

class ProductCategory extends GetView<ProductCategoryController> {
  const ProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> catagories = [
      {
        "id": "1",
        "name": "all",
        "icon": IconRoutes.dashboard,
      },
      {
        "id": "1",
        "name": "wood",
        "icon": IconRoutes.wood,
      },
      {
        "id": "1",
        "name": "wood",
        "icon": IconRoutes.wood,
      },
      {
        "id": "1",
        "name": "wood",
        "icon": IconRoutes.wood,
      },
      {
        "id": "1",
        "name": "wood",
        "icon": IconRoutes.wood,
      },
    ];
    return MainScaffold(
        backgroundColor: AppColorTheme.bgColor,
        body: Column(
          children: [
            Text(
              "مـواد",
              style: AppTextTheme.brown25,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                child: SearchInput(
                  controller: controller.searchController,
                  placeholder: 'Search',
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).highlightColor,
                        fontWeight: FontWeight.bold,
                      ),
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).highlightColor,
                  ),
                  contentPadding: const EdgeInsets.only(top: 10),
                  onChanged: (val) {
                    controller.searchValue = val;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            buildCountryButton(() {}),
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
            buildCategories(catagories),
          ],
        ));
  }

  Widget buildCategories(List<Map> catagories) {
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
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

              return Container(
                padding: EdgeInsets.all(10.r),
                child: Obx(() {
                  bool isSelected = controller.selectedIndex == index;
                  return SelectableCard(
                    backgroundColor:
                        isSelected ? AppColorTheme.yellow : AppColorTheme.white,
                    isSelected: isSelected,
                    onTap: () {
                      controller.selectedIndex = index;
                      if (controller.selectedIndex == 0) {
                        Get.toNamed(AppRoutes.productCategory);
                      }
                    },
                    icon: Container(
                      child: SvgPicture.asset(
                        category["icon"],
                        color: isSelected
                            ? AppColorTheme.white
                            : AppColorTheme.gray,
                      ),
                    ),
                    label: category["name"],
                  );
                }),
              );
            },
          ),
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
                  'Selected country',
                  style: AppTextTheme.dark18,
                ),
                SizedBox(
                  width: 10.w,
                ),
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Image.asset(
                      'assets/icon/flag.png',
                      width: 33.r,
                    ))
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
