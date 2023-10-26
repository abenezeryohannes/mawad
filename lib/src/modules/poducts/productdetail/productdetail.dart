import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/color_item.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/modules/cart/widgets/item.count.controller.dart';
import 'package:mawad/src/modules/poducts/addon_handler_factory.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/checkbox_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/favorite_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/textarea_filed.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';
import 'package:mawad/src/utils/hex_color.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentSlide = 0;
  bool isClicked = false;
  ColorItem selectedColor = ColorItem(1, HexColor("#F9DDCB"));
  final ProductController productController = Get.put(ProductController());
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
          return productController.productDetail.value != null
              ? Column(
                  children: [
                    buildImageCarousel(),
                    buildProductInfo(),
                    buildProductPriceAndDescription(),
                    buildCustomizationOptions(),
                    ...productAddons.map((addon) {
                      return AddonHandlerFactory.create(addon);
                    }).toList(),
                    buildSpecialRequests(),
                    const SizedBox(
                      height: 10,
                    ),
                    buildButton(),
                  ],
                )
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
                          width: index == 1 ? 42.0 : 24,
                          height: 4.0,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: index == 1 ? Colors.black : Colors.white,
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
                    backgroundColor: AppColorTheme.lightGray,
                    iconColor: AppColorTheme.white,
                    value: 3,
                    iconSize: 14,
                    onChange: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Text(
            productController.productDetail.value!.detailsEng.toString(),
            textAlign: TextAlign.start,
          ),
        ),
        // buildServiceRequestCheckbox(),
      ],
    );
  }

  Widget buildCustomizationOptions() {
    return Column(
      children: [
        buildServiceRequestCheckbox(),
      ],
    );
  }

  Widget buildServiceRequestCheckbox() {
    return PrimerCard(
      child: CheckboxIcon(
        title: "طلب خدمة أخذ المقاس",
        textStyle: AppTextTheme.darkblueTitle16,
        onClicked: (v) {
          setState(() {
            isClicked = !isClicked;
          });
        },
        isClicked: isClicked,
        checkedIconPath: IconRoutes.wood,
        iconPath: IconRoutes.checkbox,
      ),
    );
  }

  Widget buildSpecialRequests() {
    return PrimerCard(
      height: 200.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "هل لديك مواصفات خاصة؟",
              style: AppTextTheme.darkblueTitle16,
            ),
          ),
          TextAreaFiled(
            controller:
                myController, // You need to create a TextEditingController
            hintText: '',
            onChanged: (text) {
              // Handle text changes here
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "* سيتم الرد على الطلب الخاص خلال يومان عمل.",
              style: AppTextTheme.graysubtitle12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton() {
    return SizedBox(
      child: BigTextButton(
        text: 'أضف للسلة',
        fontWight: FontWeight.bold,
        cornerRadius: 24,
        elevation: 0,
        backgroudColor: Theme.of(context).colorScheme.secondary,
        borderColor: Theme.of(context).cardColor,
        textColor: Theme.of(context).colorScheme.onBackground,
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        horizontalMargin:
            const EdgeInsets.only(left: 30, right: 30, bottom: 10),
        onClick: () {},
      ),
    );
  }
  // Implement other helper functions as needed.
}
