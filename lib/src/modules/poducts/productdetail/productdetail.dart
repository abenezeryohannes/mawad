import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/services/localization_service.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/modules/cart/widgets/item.count.controller.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';
import 'package:mawad/src/modules/home/widgets%20/home_skeleton.dart';
import 'package:mawad/src/modules/poducts/addon_handler_factory.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/Input_handler.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/favorite_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/utils.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentSlide = 0;

  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();
  final FavoritesController favoritesController =
      Get.find<FavoritesController>();
  final RegisterWithPhoneController authController =
      Get.put(RegisterWithPhoneController());
  final myController = TextEditingController();
  int initialQuantity = 1;
  final productID = Get.arguments;

  @override
  void initState() {
    super.initState();
    productController.getProductDetail(productID);

    int currentQuantity = cartController.getQuantityOfProductInCart(productID);
    setState(() {
      initialQuantity = currentQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      // backgroundColor: AppColorTheme.lightGray3,
      showBackButton: true,
      title: "Product Detail".tr,
      haveTitle: true,
      body: buildProductDetailBody(),
    );
  }

  Widget buildProductDetailBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Obx(() {
          if (productController.isLeadingDetail.value) {
            return buildProductDetailSkeleton();
          } else if (productController.productDetail.value != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  buildImageCarousel(),
                  buildProductInfo(),
                  buildProductPriceAndDescription(),
                  buildDescriptions(),
                  ...productController.productDetail.value!.productAddons!
                      .map((addon) => AddonHandlerFactory.create(
                            addon,
                            onAddonChanged: cartController.handleAddon,
                          ))
                      .toList(),
                  const SizedBox(height: 10),
                  Visibility(
                      visible: productController
                          .productDetail.value!.allowInstructions!,
                      child: const InputAddonHandler()),
                  const SizedBox(height: 10),
                  buildButton(),
                ],
              ),
            );
          } else {
            // Data is not yet fetched and no error, can show a placeholder or empty state
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: Get.height * 0.4),
              child: Center(
                child:
                    Text('Product details are not available at the moment.'.tr),
              ),
            );
          }
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
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Builder(
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
                        errorBuilder: (context, error, stackTrace) {
                          // Return a placeholder widget when an error occurs
                          return Image.network(
                            AppConstants.Placeholde,
                            fit: BoxFit.fill,
                            repeat: ImageRepeat.noRepeat,
                          );
                        },
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 25.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...productController.productDetail.value!.tags!.map(
                            (tg) => AdditionalProductData(tg.title, tg.url),
                          )
                        ],
                      ),
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
        ),
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
            child: SvgPicture.network(
              dataIcon,
              width: 20.w,
              height: 20.h,
            ),
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
    final info = productController.productDetail.value;
    return Container(
      padding: EdgeInsets.all(25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Expanded(
              child: Text(
                  LocalizationService.instance.currentLocaleLangCode ==
                          AppConstants.ENG
                      ? info!.nameEng.toString()
                      : info!.nameAr.toString(),
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
            isFavorite: favoritesController
                .isFavorite(productController.productDetail.value!),
            onTap: () async {
              if (await authController.isAuth()) {
                favoritesController
                    .toggleFavorite(productController.productDetail.value!);
              } else {
                Get.toNamed(AppRoutes.register);
              }
            },
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
                    ("${"KWD".tr} " +
                            Util.formatNumberWithCommas(
                                (productController.productDetail.value!.price *
                                        initialQuantity)
                                    .toString()))
                        .toString(),
                    style: AppTextTheme.dark18),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: ItemCountController(
                    maxCount: productController.productDetail.value!.stock!,
                    initialValue: initialQuantity,
                    onChange: (value) {
                      if (value == 0) {
                        value = 1;
                      }
                      setState(() {
                        initialQuantity = value;
                      });
                    },
                    backgroundColor: AppColorTheme.lightGray3,
                    iconColor: Colors.white,
                    canAdd: productController.productDetail.value!.allowStock!,
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
    final prod = productController.productDetail.value!;
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        LocalizationService.instance.currentLocaleLangCode == AppConstants.ENG
            ? prod.detailsEng.toString()
            : prod.detailsAr.toString(),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget buildButton() {
    return SizedBox(
      child: Obx(() {
        return BigTextButton(
          text: 'Add to cart'.tr,
          fontWight: FontWeight.bold,
          cornerRadius: 24,
          enabled:
              productController.productDetail.value!.allowInstructions == true
                  ? productController.productDetail.value!.allowInstructions! &&
                      productController.commentController.text.isNotEmpty
                  : true,
          elevation: 0,
          backgroudColor: Theme.of(context).colorScheme.secondary,
          borderColor: Theme.of(context).cardColor,
          textColor: Theme.of(context).colorScheme.onBackground,
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          isLoading: cartController.isLoading.value,
          horizontalMargin:
              const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          onClick: () {
            cartController.addItem(CartItem(
                product: productController.productDetail.value!,
                quantity: initialQuantity,
                attributes: cartController.selectedAddons,
                comment: productController.commentController.text,
                price: productController.productDetail.value!.price));
          },
        );
      }),
    );
  }
  // Implement other helper functions as needed.
}
