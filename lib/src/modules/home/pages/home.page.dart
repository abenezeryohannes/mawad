import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/favorite/favorite_list.dart';
import 'package:mawad/src/modules/home/cards/home.tab.cards.dart';
import 'package:mawad/src/modules/home/pages/change.country.bottom.sheet.dart';
import 'package:mawad/src/modules/home/pages/image_banner.dart';
import 'package:mawad/src/modules/main_controller.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/sharedwidgets/appbottomshet.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/search_input.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  late TextEditingController searchController;
  final ProductController productController = Get.put(ProductController());
  final MainController mainController = Get.put(MainController());

  int selectedIndex = 0;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
    productController.getReca();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorTheme.bg,
        body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    surfaceTintColor: AppColorTheme.bg,
                    pinned: true,
                    primary: true,
                    backgroundColor: AppColorTheme.bg,
                    floating: true,
                    iconTheme: const IconThemeData(size: 0),
                    leadingWidth: 0,
                    leading: null,
                    collapsedHeight: 230.h,
                    expandedHeight: 280.h,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: FlexibleSpaceBar(
                      title: _appBarBackground(),
                      titlePadding: EdgeInsets.zero,
                      expandedTitleScale: 1,
                      background: _appBar(),
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                child: _body(context),
              )),
        ));
  }

  Widget _appBarBackground() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    child: SearchInput(
                      controller: searchController,
                      placeholder: 'Search',
                      hintStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                        setState(() {
                          search = val;
                        });
                      },
                    ),
                  )),
            ),
            Container(
                color: AppColorTheme.bg,
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 150.h,
                child: Obx(() {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.categories.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final category = productController.categories[index];
                      bool isSelected = productController
                              .productCategoryController.selectedIndex ==
                          index; // Check if the current index matches the selectedIndex
                      return Container(
                        padding: EdgeInsets.all(10.r),
                        child: SelectableCard(
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              productController.productCategoryController
                                  .selectedIndex = index;
                              if (productController.productCategoryController
                                      .selectedIndex ==
                                  0) {
                                Get.toNamed(AppRoutes.productCategory);
                              } else {
                                productController
                                    .getProductByCategory(category.id);
                              }
                            });
                          },
                          icon: Container(
                              child: SvgPicture.network(
                            category.image.url,
                            color: isSelected
                                ? AppColorTheme.white
                                : AppColorTheme.gray,
                          )),
                          label: category.nameEng,
                        ),
                      );
                    },
                  );
                }))
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      color: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'This is the title',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () => showAppBottomSheet(
                        ChangeCountryBottomSheet(
                          countries: mainController.countries,
                          initialSelectedCountry:
                              mainController.selectedCountry.value,
                          onCountrySelected: (selected) {
                            log(selected.id);
                            setState(() {
                              productController
                                  .getProductByCountry(selected.id);
                              mainController.selectedCountry(selected);
                            });
                          },
                        ),
                      ),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: Image.asset(
                            'assets/icon/flag.png',
                            width: 32,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ImageBanner(
            onButtonPressed: () {
              Get.toNamed(AppRoutes.checkout);
            },
            imagePath: 'assets/icon/banner.png'),
        Expanded(
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                productController.isLeading.value
                    ? const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ))
                    : productController.products.isNotEmpty
                        ? FavoriteProductsList(
                            productList: productController.products)
                        : const Center(
                            child: Text('No product'),
                          )
              ],
            );
          }),
        ),
      ],
    );
  }
}
