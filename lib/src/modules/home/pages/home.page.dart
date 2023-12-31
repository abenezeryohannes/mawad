import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/modules/favorite/favorite_list.dart';
import 'package:mawad/src/modules/home/pages/change.country.bottom.sheet.dart';
import 'package:mawad/src/modules/home/pages/image_banner.dart';
import 'package:mawad/src/modules/home/widgets%20/product.catagory.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_catagory.dart';
import 'package:mawad/src/presentation/sharedwidgets/appbottomshet.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/search_input.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets /home_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());
  final Uri _url = Uri.parse('http://ordermawad.com/');
  Timer? debounceTimer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme.bg,
      body: Obx(() {
        return SafeArea(
          child: productController.isCategory.value
              ? const Directionality(
                  textDirection: TextDirection.ltr, child: ProductCategory())
              : NestedScrollView(
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
                        collapsedHeight: 130.h,
                        forceElevated: innerBoxIsScrolled,
                        flexibleSpace: FlexibleSpaceBar(
                          title: _appBarBackground(context),
                          titlePadding: EdgeInsets.zero,
                          expandedTitleScale: 1,
                          background: _appBar(context),
                        ),
                      ),
                    ];
                  },
                  physics: const BouncingScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.start,
                  body: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                    child: _body(context),
                  ),
                ),
        );
      }),
    );
  }

  Widget _appBarBackground(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                child: SearchInput(
                  controller: productController.searchController,
                  placeholder: 'Search'.tr,
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
                    if (debounceTimer != null) {
                      debounceTimer!.cancel();
                    }
                    debounceTimer =
                        Timer(const Duration(milliseconds: 500), () {
                      productController.searchProduct(
                          productController.selectedCountry.value!.id, val);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
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
                      'Products'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          showAppBottomSheet(
                            Obx(() {
                              return ChangeCountryBottomSheet(
                                countries: productController.countries,
                                initialSelectedCountry:
                                    productController.selectedCountry.value,
                                onCountrySelected: (selected) {
                                  productController
                                      .getProductByCountry(selected.id);
                                  productController
                                      .getCategoryByCountry(selected.id);
                                  productController.selectedCountry(selected);
                                },
                              );
                            }),
                          );
                        },
                        child: CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.transparent,
                          child: Obx(
                            () => ClipOval(
                              child: productController.selectedCountry.value !=
                                      null
                                  ? ClipOval(
                                      child: SvgPicture.network(
                                        '${AppConstants.IMAGER_URL}/${productController.selectedCountry.value!.attachment.id}',
                                        fit: BoxFit.cover,
                                        width: 78.r,
                                        height: 78.r,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        ),
                      ),
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
    return Obx(() {
      return ListView(
        shrinkWrap: true,
        children: [
          const Directionality(
              textDirection: TextDirection.ltr, child: ProductCategoryList()),
          ImageBanner(
            onButtonPressed: () {
              _launchUrl();
            },
            imagePath: productController.banners,
          ),
          if (productController.isLeading.value)
            SingleChildScrollView(
              child: buildFavoriteProductsListSkeleton(context),
            ),
          if (!productController.isLeading.value &&
              productController.products.isNotEmpty)
            Directionality(
              textDirection: TextDirection.ltr,
              child: FavoriteProductsList(
                productList: productController.products,
              ),
            ),
          if (!productController.isLeading.value &&
              productController.products.isEmpty)
            Container(),
        ],
      );
    });
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
