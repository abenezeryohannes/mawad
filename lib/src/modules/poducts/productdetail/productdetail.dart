import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/modules/cart/widgets/item.count.controller.dart';
import 'package:mawad/src/modules/poducts/addon_handler_factory.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/favorite_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentSlide = 0;

  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();
  final myController = TextEditingController();

  final productID = Get.arguments;
  late List<ProductAddons> productAddons;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.getProductDetail(productID);
    productAddons = productController.productDetail.value?.productAddons ?? [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productController.getProductDetail(productID);
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      // backgroundColor: AppColorTheme.lightGray3,
      showBackButton: true,
      title: "Product Detail",
      haveTitle: true,
      body: buildProductDetailBody(),
    );
  }

  Widget buildProductDetailBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Obx(() {
          return productController.isLeadingDetail.value
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: Get.height * 0.4),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : productController.productDetail.value != null
                  ? Container(
                      child: Column(
                      children: [
                        buildImageCarousel(),
                        buildProductInfo(),
                        buildProductPriceAndDescription(),
                        buildDescriptions(),
                        ...productAddons.map((addon) {
                          return AddonHandlerFactory.create(addon);
                        }).toList(),
                        const SizedBox(
                          height: 10,
                        ),
                        buildButton(),
                      ],
                    ))
                  : Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: Get.height * 0.4),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
        }),
      ),
    );
  }

  Widget buildImageCarousel() {
    return Obx(() => CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true, // Set to true to show one image at a time
            aspectRatio: 16 / 3, // Adjust the aspect ratio as needed
            viewportFraction: 1.0,

            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            scrollPhysics: const ScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            height: 290.0.h,
            onPageChanged: (index, reason) {
              setState(() {
                currentSlide = index;
              });
            },
          ),
          items:
              productController.productDetail.value?.images.isNotEmpty == true
                  ? carouselList(productController.productDetail.value!)
                  : List.empty(),
        ));
  }

  List<Widget> carouselList(Product product) {
    return product.images.map((prod) {
      return Builder(
        builder: (BuildContext context) {
          return SizedBox(
            child: Stack(
              children: [
                // Image
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.network(
                      prod.url,
                      fit: BoxFit.fill,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 25.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalProductData("Wood", IconRoutes.wood),
                      AdditionalProductData("45 cm", IconRoutes.arrowTop),
                      AdditionalProductData("30 cm", IconRoutes.arrowLeft),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(product.images.length, (index) {
                        return Container(
                          width: index == currentSlide ? 30.0 : 24,
                          height: 4.0,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: currentSlide == index
                                ? Colors.black
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }).toList();
  }

  Widget AdditionalProductData(String dataTitle, String dataIcon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColorTheme.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            child: SvgPicture.asset(dataIcon),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(dataTitle),
          ),
        ],
      ),
    );
  }

  Widget buildProductInfo() {
    return Container(
      padding: EdgeInsets.all(25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Expanded(
              child: Text(
                  productController.productDetail.value!.nameEng.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          //Todo add favorite logic
          FavoriteButton(
            isFavorite:
                false, // Initial state, can be dynamic based on some data
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget buildProductPriceAndDescription() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 23.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                    productController.productDetail.value!.price.toString(),
                    style: AppTextTheme.dark18),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: ItemCountController(
                    initialValue: 1,
                    onChange: (value) {
                      if (value == 0) {
                        value = 1;
                      }
                      print(value);
                    },
                    backgroundColor: AppColorTheme.lightGray3,
                    iconColor: Colors.white,
                    canAdd: true,
                    canSubtract: true,
                  ),
                ),
              ),
            ],
          ),
        ),

        // buildServiceRequestCheckbox(),
      ],
    );
  }

  Widget buildDescriptions() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        productController.productDetail.value!.detailsEng.toString(),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget buildButton() {
    return SizedBox(
      child: Obx(() {
        return BigTextButton(
          text: 'أضف للسلة',
          fontWight: FontWeight.bold,
          cornerRadius: 24,
          elevation: 0,
          backgroudColor: Theme.of(context).colorScheme.secondary,
          borderColor: Theme.of(context).cardColor,
          textColor: Theme.of(context).colorScheme.onBackground,
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          isLoading: cartController.isLoading.value,
          horizontalMargin:
              const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          onClick: () {
            cartController.addItem(productController.productDetail.value!);
          },
        );
      }),
    );
  }
  // Implement other helper functions as needed.
}
