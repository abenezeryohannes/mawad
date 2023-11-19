import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/modules/cart/payment/payment_view.dart';
import 'package:mawad/src/modules/favorite/favorite_list.dart';
import 'package:mawad/src/modules/home/widgets%20/product.catagory.dart';
import 'package:mawad/src/modules/home/pages/change.country.bottom.sheet.dart';
import 'package:mawad/src/modules/home/pages/image_banner.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_catagory.dart';
import 'package:mawad/src/presentation/sharedwidgets/appbottomshet.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/search_input.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

import '../widgets /home_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme.bg,
      body: Obx(() {
        return SafeArea(
          child: productController.isCategory.value
              ? const ProductCategory()
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
                        collapsedHeight: 230.h,
                        expandedHeight: 280.h,
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
                      searchController.text = val;
                    },
                  ),
                ),
              ),
            ),
            const ProductCategoryList()
          ],
        ),
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
                      'Products',
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
                            child:
                                productController.selectedCountry.value != null
                                    ? SvgPicture.network(
                                        '${AppConstants.IMAGER_URL}/${productController.selectedCountry.value!.attachment.id}',
                                        fit: BoxFit.cover,
                                        width: 40,
                                        height: 40,
                                      )
                                    : const SizedBox(),
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
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ImageBanner(
            onButtonPressed: () {
              Get.to(const PaymentWebViewScreen(
                paymentUrl: 'http://ordermawad.com',
                title: "",
              ));
            },
            imagePath: productController.banners,
          ),
          if (productController.isLeading.value)
            Expanded(
              child: SingleChildScrollView(
                // Make sure this is scrollable
                child: buildFavoriteProductsListSkeleton(context),
              ),
            ),
          if (!productController.isLeading.value &&
              productController.products.isNotEmpty)
            FavoriteProductsList(
              productList: productController.products,
            ),
          if (!productController.isLeading.value &&
              productController.products.isEmpty)
            Expanded(child: buildFavoriteProductsListSkeleton(context)),
        ],
      );
    });
  }
}
